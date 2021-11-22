from typing import NewType

AudioDataAlias = "dict[str, float | int | bool]"
AudioFeatures = "dict[str, float]"
AudioData = NewType('UserId', AudioDataAlias)