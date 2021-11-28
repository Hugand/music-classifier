from pydub import AudioSegment
import os
# sound = AudioSegment.from_file('../Data/genres_original/blues/blues.00000.wav')

# halfway_point = len(sound) // 2
# first_half = sound[halfway_point:]

# print(len(sound))

# # create a new file "first_half.mp3":
# first_half.export("./sample.wav", format="wav")

for d in os.walk('../Data/genres_original_3/'):
    curr_genre = d[0].split('/')[-1]

    if curr_genre == '': continue

    for clip in d[2]:
        clip_path = d[0] + '/' + clip
        print(clip_path, clip)

        if clip == '.DS_Store': continue

        sound = AudioSegment.from_file(clip_path)

        curr_point = 0
        prev_point = -1

        # for i in range(10):
        i = 0
        while prev_point < len(sound):
            prev_point = curr_point
            curr_point += 10000

            if prev_point >= len(sound): break

            if curr_point > len(sound) and len(sound) - prev_point >= 8000:
                sample = sound[prev_point:len(sound)]
            elif curr_point < len(sound):
                sample = sound[prev_point:curr_point]
            else:
                break

            sample.export(
                '../Data/sampled_tracks_4/' + curr_genre + '/' + str(i) + '_' + clip,
                format="wav")

            i += 1
    
    print(d[0])
    # print(curr_genre)