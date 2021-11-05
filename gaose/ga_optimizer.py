import numpy as np
from random import random, uniform
from copy import deepcopy
from scipy.sparse.construct import rand
from sklearn.metrics import accuracy_score, f1_score

class GAOptimizer:
    def __init__(self, n_weights,
        n_generations=1000, pop_size=30,
        mutation_prob=0.1,
        crossover_prob=0.7, crossover_type='1pt',
        selection_type='tournment', poison_prob=0.3, best_fit_frac=0.05,
        eval_metric='accuracy'):
        self.pop_size = pop_size
        self.mutation_prob = mutation_prob
        self.crossover_prob = crossover_prob
        self.selection_type = selection_type
        self.n_weights = n_weights
        self.population = []
        self.n_generations = n_generations
        self.crossover_type = crossover_type
        self.best_fit_size = round(self.pop_size * best_fit_frac)
        self.poison_prob = poison_prob
        self.eval_metric = eval_metric

    def __select(self, mating_pool, selected_size):
        return self.__tournment_selection(mating_pool, selected_size)

    def __tournment_selection(self, mating_pool, selected_size):
        selected = []

        for i in range(selected_size):
            random_pos_1 = round(uniform(0, len(mating_pool)-1))
            random_pos_2 = round(uniform(0, len(mating_pool)-1))
            weaker_is_poisonous = random() < self.poison_prob

            if mating_pool[random_pos_1]['fit'] >= mating_pool[random_pos_2]['fit']:
                if weaker_is_poisonous:
                    selected.append(mating_pool[random_pos_2])
                else:
                    selected.append(mating_pool[random_pos_1])
            else:
                if weaker_is_poisonous:
                    selected.append(mating_pool[random_pos_1])
                else:
                    selected.append(mating_pool[random_pos_2])

        return selected
    
    def __mutate(self, chromossome):
        weight_change = uniform(0, 1.0) * [1, -1][round(random())]
        chosen_weight = round(uniform(0, len(chromossome['weights'])-1))

        new_weights = deepcopy(chromossome['weights'])
        new_weights[chosen_weight] = abs(new_weights[chosen_weight] + weight_change)
        normalized_weights = self.__normalize_weights(new_weights)

        return self.__create_chromossome(normalized_weights)

    def __crossover(self, chromossome1, chromossome2):
        crossover = {
            '1pt': self.__1pt_crossover,
            'uniform': self.__uniform_crossover,
        }

        return (crossover[self.crossover_type])(chromossome1, chromossome2)

    def __1pt_crossover(self, chromossome1, chromossome2):
        weights_len = len(chromossome1['weights'])
        random_pos = round(uniform(0, weights_len-1))
        chromossome1_weights, chromossome2_weights = chromossome1['weights'], chromossome2['weights']
        
        offspring1_weights = chromossome1_weights[:random_pos] + chromossome2_weights[random_pos:]
        offspring2_weights = chromossome2_weights[:random_pos] + chromossome1_weights[random_pos:]
        offspring1_weights = self.__normalize_weights(offspring1_weights)
        offspring2_weights = self.__normalize_weights(offspring2_weights)

        offspring1 = self.__create_chromossome(offspring1_weights)
        offspring2 = self.__create_chromossome(offspring2_weights)

        return offspring1, offspring2

    def __uniform_crossover(self, chromossome1, chromossome2):
        weights_len = len(chromossome1['weights'])
        chromossome1_weights, chromossome2_weights = chromossome1['weights'], chromossome2['weights']
        offspring1_weights = []
        offspring2_weights = []

        for i in range(weights_len):
            if i % 2 == 0:
                offspring1_weights.append(chromossome1_weights[i])
                offspring2_weights.append(chromossome2_weights[i])
            else:
                offspring1_weights.append(chromossome2_weights[i])
                offspring2_weights.append(chromossome1_weights[i])

        offspring1_weights = self.__normalize_weights(offspring1_weights)
        offspring2_weights = self.__normalize_weights(offspring2_weights)

        offspring1 = self.__create_chromossome(offspring1_weights)
        offspring2 = self.__create_chromossome(offspring2_weights)

        return offspring1, offspring2

    def __apply_genetic_operators(self):
        mating_pool = []

        for p in range(self.pop_size):
            if random() <= self.mutation_prob:
                mutant = self.__mutate(self.population[p])
                mating_pool.append(mutant)

            if random() <= self.crossover_prob:
                random_chromossome_pos = round(uniform(0, self.pop_size-1))
                offsprings = self.__crossover(
                    self.population[p], self.population[random_chromossome_pos])
                mating_pool += offsprings

        return mating_pool

    def optimize(self, X_train, y_train, meta_classifier):
        self.meta_classifier = meta_classifier
        self.X_train = X_train
        self.y_train = y_train
        self.population = self.__generate_population(self.pop_size)
        best_fit = []

        for g in range(self.n_generations):
            mating_pool = []

            self.population.sort(key=lambda x: x['fit'], reverse=True)
            # print(g)
            # print([p['fit'] for p in self.population])

            best_fit = self.population[:self.best_fit_size]
            mating_pool = self.__apply_genetic_operators()

            if g % 150 == 0:
                new_batch = self.__population_injection(mating_pool, 50)
                new_batch.sort(key=lambda x: x['fit'], reverse=True)

                best_fit += new_batch[:2]

            self.population = best_fit
            self.population += self.__select(mating_pool, self.pop_size - len(best_fit))
            
        return self.population[0]['weights']

    def __generate_population(self, pop_size):
        new_population = []
        for i in range(pop_size):
            new_weights = self.__generate_weights(self.n_weights)
            new_population.append(self.__create_chromossome(new_weights))

        return new_population

    def __evaluate_chromossome(self, weights):
        y_pred = self.meta_classifier.predict(self.X_train, weights)

        if self.eval_metric == 'accuracy':
            return accuracy_score(self.y_train, y_pred)
        elif self.eval_metric == 'f1-score':
            return f1_score(self.y_train, y_pred, average='weighted')

    def __generate_weights(self, n_weights):
        weights = []
        new_weights = np.random.dirichlet(np.ones(n_weights),size=1)[0]

        for w in new_weights:
            weights.append(w)

        return weights
    
    def __normalize_weights(self, weights):
        total = sum(weights)
        normalized_weights = []

        for w in weights:
            normalized_weights.append(w / total)

        return normalized_weights

    def __population_injection(self, mating_pool, new_pop_batch_size):
        new_population_batch = self.__generate_population(new_pop_batch_size)
        
        return mating_pool + new_population_batch

    def __create_chromossome(self, weights):
        return {
            'weights': weights, 'fit': self.__evaluate_chromossome(weights)
        }