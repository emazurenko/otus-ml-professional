## Репозиторий для материалов курса [_OTUS. ML Professional_](https://otus.ru/learning/300381/)

### Подготовка к запуску блокнотов Jupyter

#### Создание виртуального окружения:
```
conda create --name otus-ml python=3.12.12
```
В случае ошибки вида `CondaSSLError: Encountered an SSL error. Most likely a certificate verification issue` помогло отключение безопасности соединения:
```
conda config --set ssl_verify false
```

#### Активация окружения
```
conda activate otus-ml
```
В случае множественной ошибки вида `CondaError: Run 'conda init' before 'conda activate'` помогла комбинация команд:
```
conda init --all
```
Перезапуск консоли, далее:
```
conda activate base
conda activate otus-ml
```

#### Установка пакетов в окружение

Пример установки пакетов:

```
conda install -n otus-ml lightgbm catboost
```

Для установки PyTorch необходимо, чтобы было активировано окружение conda, тогда установка пакета через pip (через conda установить не удаетсяы) приведет к его установке в это окружение:

```
pip3 install torch torchvision --index-url https://download.pytorch.org/whl/cu130
pip install torchsummary
```
Команды для установки можно взять на сайте https://pytorch.org/

Для видеокарты GTX 1050, которая поддерживает только CUDA 6.1 рекомендуют выполнить установку:
```
pip install --index-url https://download.pytorch.org/whl/cu121 torch==2.4.1 torchvision==0.19.1 torchaudio==2.4.1
```

#### Миграция окружения
Для полного переноса окружения на другую машину можно сначала использовать альтернативные команды по выгрузки окружения в файл:
```
conda export -n otus-ml --file=./environment.yaml

conda list -n otus-ml --export > ./package-list.txt
```

Затем для воссоздания из файла использовать команду:
```
conda env create --name otus-ml --file ./environment.yaml
``` 

### Заготовки кода

#### Пропуски

Определение пропусков:

```
data.isnull().sum().head()

Happiness in life     0
Age                   7
Height               20
Gender                6
Weight               20
dtype: int64
```

```
data.info()

<class 'pandas.core.frame.DataFrame'>
RangeIndex: 891 entries, 0 to 890
Data columns (total 12 columns):
 #   Column       Non-Null Count  Dtype  
---  ------       --------------  -----  
 0   PassengerId  891 non-null    int64  
 1   Survived     891 non-null    int64  
 2   Pclass       891 non-null    int64  
 3   Name         891 non-null    object 
 4   Sex          891 non-null    object 
 5   Age          714 non-null    float64
 6   SibSp        891 non-null    int64  
 7   Parch        891 non-null    int64  
 8   Ticket       891 non-null    object 
 9   Fare         891 non-null    float64
 10  Cabin        204 non-null    object 
 11  Embarked     889 non-null    object 
dtypes: float64(2), int64(5), object(5)
memory usage: 83.7+ KB
```

#### Заполнение пропусков

Способы заполнения пропуков:

```
# СПОСОБ 1
sales = df['SalesAmount'].to_numpy()
mean_sales = np.nanmean(sales)
df['SalesAmountFilled'] = np.nan_to_num(sales, nan=mean_sales)

# СПОСОБ 2
df['DiscountFilled'] = df['Discount'].fillna(0)

# СПОСОБ 2.5
df['DiscountFilled'] = df['Discount'].fillna(df['Discount'].mean())

# СПОСОБ 3
from sklearn.impute import SimpleImputer
imputer = SimpleImputer(strategy='mean')
df[['SalesAmountFilled']] = imputer.fit_transform(df[['SalesAmount']])

# СПОСОБ 4 (удаление)
data_cleaned = data.dropna()
```

#### Кодирование значений

Категориальные переменные:

```
from sklearn.preprocessing import OrdinalEncoder

X = np.array([['LOW', 'RED'],
              ['MEDIUM', 'BLUE'],
              ['HIGH', 'GREEN']])

# Индексация определяется порядоком перечисления значений
# Важно совпадение входящих данных и списков категорий для преобразований
encoder = OrdinalEncoder(categories=[
    ['LOW', 'MEDIUM', 'HIGH'],
    ['RED', 'GREEN', 'BLUE']
])

X_encoded = encoder.fit_transform(X).astype(int)
X_encoded

array([[0, 0],
       [1, 2],
       [2, 1]])
```

### Работа с данными

#### NumPy

Преобразование элементов массива к массивам из одного элемента:

```
X = np.array([1,2,3])

print(f'\tX: \n{X}\n\tX asrows: \n{X.reshape(-1,1)}')

	X: 
[1 2 3]
	X asrows: 
[[1]
 [2]
 [3]]
```

Соединение столбцов:

```
result = np.column_stack((rows, counts))
```

Преобразование значений в массиве:

```
# СПОСОБ 1
labels = model.labels_
labels = np.array([1 if label == -1 else 0 for label in labels])

# СПОПОБ 2
np_labels = np.vectorize(lambda x: dict(c)[x])(np_labels)
# где
# dict(c) - словарь ключ-значений
# np.vectorize - "векторизация" функции и её возврат
```

Расчет доли:

```
СПОСОБ 1
outlier_percentage = sum(labels==1) / len(labels)

СПОСОБ 2
y_train.value_counts(normalize=True)

Class
0    0.998271
1    0.001729
Name: proportion, dtype: float64

СПОСОБ 3
print(f"Классы: {np.unique(y)}, распределение: {np.bincount(y)}")

Классы: [0 1 2], распределение: [50 50 50]
```

Подсчет уникальных значений и их количества
```
СПОСОБ 1
rows, counts = np.unique(np_labels, axis=0, return_counts=True)

СПОСОБ 2
np.bincount(y)
```

### Графики

#### matplotlib.pyplot

Объединение двух графиков на одной фигуре при общей независимой переменной и разных зависимых:

```
fig, ax1 = plt.subplots()

# Общая шкала аргумента
ax1.set_xlabel('epsilon')

# Совмещение графиков
ax2 = ax1.twinx()

color = 'tab:red'
ax1.set_ylabel('number of clusters', color=color)
ax1.plot(iterations, num_clusters, color=color)
ax1.tick_params(axis='y', labelcolor=color)

color = 'tab:blue'
ax2.set_ylabel('anomaly percentage', color=color)
ax2.plot(iterations, anomaly_percentage, color=color)
ax2.tick_params(axis='y', labelcolor=color)

fig.tight_layout()
plt.show()
```

Добавление графиков к фигуре:

```
figure = plt.figure(figsize=(8, 8))
cols, rows = 3, 3
for i in range(1, cols * rows + 1):
    sample_idx = torch.randint(len(training_data), size=(1,)).item()
    img, label = training_data[sample_idx]
    figure.add_subplot(rows, cols, i)
    plt.title(label)
    plt.axis("off")
    plt.imshow(img.squeeze(), cmap="gray") # squeeze() - удаляем все измерения размером 1
plt.show();
```

Отключить оси:
```
plt.title(label)
plt.axis("off")
plt.imshow(img.squeeze(), cmap="gray") 
```

Приведение одноразмерного индекса к двухразмерному:

```
СПОСОБ 1
fig, axs = plt.subplots(nrows=2, ncols=2, figsize=(10, 4))

for i, method in enumerate(['ward', 'average', 'weighted', 'centroid', 'single', 'complete']):
    ax = axs[i//2][i%2]

СПОСОБ 2
fig, axes = plt.subplots(2, 6, figsize=(25, 8))
fig.suptitle('Box-plots')

row=0
col=0

for ax, feature in enumerate(data_features):
    data_features[feature].plot.box(ax=axes[row, col])
    col+=1
    if col > 5:
        row+=1
        col=0

СПОСОБ 3
fig, axes = plt.subplots(2, 5, figsize=(15, 6))
for i, ax in enumerate(axes.flat):
    img, label = train_data[i]
    ax.imshow(img.permute(1, 2, 0) * 0.5 + 0.5)  # Денормализация
    ax.set_title(classes[label])
    ax.axis('off')
```

#### Pandas

График по данным:

```
summary.sum(axis=1).value_counts().plot.bar()
```

Агрегатный расчет перцентилей:

```
СПОСОБ 1
X_agg = X_tmp.agg([lambda x: x.quantile(0.25), lambda x: x.quantile(0.75)]).T

СПОСОБ 2
X_agg = X_tmp.quantile([0.25, 0.75]).T
```

#### PyTorch

Активация GPU:

```
device = torch.device("cuda") if torch.cuda.is_available() else torch.device("cpu")

model = model.to(device)
data, target = data.to(device), target.to(device)

```

Фиксация вопроизводимости:

```
import numpy as np
import os
import random
import torch

# Зафиксируем seed для воспроизводимости

def seed_everything(seed):
    random.seed(seed) # фиксируем генератор случайных чисел
    os.environ['PYTHONHASHSEED'] = str(seed) # фиксируем заполнения хешей
    np.random.seed(seed) # фиксируем генератор случайных чисел numpy
    torch.manual_seed(seed) # фиксируем генератор случайных чисел pytorch
    torch.cuda.manual_seed(seed) # фиксируем генератор случайных чисел для GPU
    torch.backends.cudnn.deterministic = True # выбираем только детерминированные алгоритмы (для сверток)
    torch.backends.cudnn.benchmark = False # фиксируем алгоритм вычисления сверток
```

Нормализация

Нейронные сети, особенно с методами оптимизации на основе градиента (SGD, Adam), лучше работают, когда входные данные имеют нулевое среднее и сопоставимые масштабы. Нормализация предотвращает проблемы с взрывами/затуханием градиентов + многие активационные функции (sigmoid, tanh) наиболее чувствительны около нуля

```
СПОСОБ 1

# Загружаем данные MNIST без преобразований (только ToTensor)
transform = transforms.Compose([
    # Внимание! В этом случае для изображений значения приводятся к дмиапазону [0;1]
    # Но видна эта трансформация будет только при работе с DataLoader, т.е. она отложенная
    transforms.ToTensor()  # Преобразует изображение в тензор
])

# Загружаем тренировочный датасет
train_dataset = datasets.MNIST(root='../18_Neural_learning_problems/MNIST_data', train=True, download=True, transform=transform)

# Создаем DataLoader для итерации по данным
train_loader = torch.utils.data.DataLoader(train_dataset, batch_size=64, shuffle=False)

# Инициализируем переменные для вычисления среднего и std
mean = 0.0
std = 0.0
total_samples = 0

# Вычисляем среднее
for images, _ in train_loader:
    batch_samples = images.size(0)  # Количество изображений в батче
    images = images.view(batch_samples, images.size(1), -1)  # Преобразуем в [batch_size, channels, height*width]
    # Размерность 2 - "плоское" изображение, т.е. среднее считается по пикселям
    mean += images.mean(2).sum(0)  # Суммируем среднее по всем изображениям в батче
    total_samples += batch_samples

mean /= total_samples  # Делим на общее количество изображений

# Вычисляем стандартное отклонение
for images, _ in train_loader:
    batch_samples = images.size(0)
    images = images.view(batch_samples, images.size(1), -1)
    # sum([0, 2]) - суммирование по двум измерениям сразу, сначала каждый пиксель по всему батчу, затем сумма всех аггрегированных
    # эквивалентно .sum(0).sum(1)
    std += ((images - mean.unsqueeze(1)) ** 2).sum([0, 2])  # Суммируем квадраты отклонений

std = torch.sqrt(std / (total_samples * 28 * 28))  # Делим на общее количество пикселей

print("Mean:", mean.item())
print("Std:", std.item())

# Mean: 0.13066041469573975
# Std: 0.30810800194740295

СПОСОБ 2

# Деление на 255 происходит с поправкой на то, что при применении трансформации ToTensor максимальное значение пикселя 255 будет приведено к 1
 
t = datasets.MNIST(root='./MNIST_data', train=False, download=True)
mean = t.data.float().mean() / 255
std = t.data.float().std() / 255
(mean, std)

# (tensor(0.1325), tensor(0.3105))

```