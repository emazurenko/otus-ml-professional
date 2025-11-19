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

Преобразование значений в массиве:

```
labels = model.labels_
labels = np.array([1 if label == -1 else 0 for label in labels])
```

Расчет доли:

```
outlier_percentage = sum(labels==1) / len(labels)
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

#### Pandas

График по данным:

```
summary.sum(axis=1).value_counts().plot.bar()
```