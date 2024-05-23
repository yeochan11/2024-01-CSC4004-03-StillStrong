import numpy as np
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Input

import os
os.environ["CUDA_VISIBLE_DEVICES"] = "0"
# 입력 데이터와 출력 데이터를 저장할 리스트 초기화
X_train_list = []
y_train_list = []

# 100개의 데이터셋 생성
for _ in range(100):
    # 977x3 크기의 입력 데이터 생성
    X_train = np.random.randn(997, 3)
    
    # 각 행의 합을 구하여 977x1 크기의 출력 데이터 생성
    y_train = np.sum(X_train, axis=1, keepdims=True)
    
    # 생성된 데이터를 리스트에 추가
    X_train_list.append(X_train)
    y_train_list.append(y_train)

# 리스트를 배열로 변환
X_train = np.array(X_train_list)
y_train = np.array(y_train_list)

# 데이터 확인
print(f"X_train shape: {X_train.shape}")  # (100, 977, 3)
print(f"y_train shape: {y_train.shape}")  # (100, 977, 1)

# 모델 정의
model = Sequential([
    Input(shape=(997, 3)),
    Dense(64, activation='relu'),
    Dense(1)
])

from tensorflow.keras.losses import MeanSquaredError

# Define the custom objects dictionary
custom_objects = {
    'mse': MeanSquaredError()  # Register the mean squared error function
}

# 모델 컴파일
model.compile(optimizer='adam', loss=MeanSquaredError())

# 모델 학습
model.fit(X_train, y_train, epochs=10, batch_size=10)

model.save('recommend_model.h5')

# # 모델 요약 출력
# model.summary()

# X_test = np.random.randn(977, 3)
# # 차원을 확장하여 입력 데이터의 형태를 (1, 977, 3)으로 변경
# X_test_expanded = np.expand_dims(X_test, axis=0)
# # 수정된 형태의 데이터로 예측
# predictions = model.predict(X_test_expanded)
# print(predictions.shape)

# #피드백 데이터 수집
# feedback_data = []  # (X값, 예측 최종 점수, 피드백) 형태로 저장

# for i in range(100):
#     if i % 2 == 0:
#         feedback = '불만족'
#     else:
#         feedback = '만족'
#     feedback_data.append((X_train[i], y_train[i], feedback))

# # 피드백 기반 학습
# for X_value, predicted_score, feedback in feedback_data:
#     if feedback == '불만족':
#         # 모델이 예측한 최종 점수가 만족스럽지 않으면,
#         # (X_value, predicted_score) 쌍을 이용해 모델을 업데이트
#         y_adjusted = predicted_score - 1  # 예시: 불만족할 때 점수 -1
#         model.fit(np.array([X_value]), np.array([y_adjusted]), epochs=1, verbose=0)
#     else:
#         # 만족할 때는 학습하지 않거나, 아주 적게 학습
#         pass