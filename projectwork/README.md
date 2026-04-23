## Замечания к проектной работе

#### Настройка с БД

БД [data.db3](./data.db3) была создана командами:

```
sqlite3 data.db3
sqlite> .read ./sql/create_candle_table.sql
sqlite> .read ./sql/create_candle_h12_view.sql
```

И наполнена данными из CSV-дампа из источника (к работе не приложен):

```
sqlite3 data.db3
sqlite> .mode csv
sqlite> .separator ,
sqlite> .import ./candles_dump.csv candle
```

##### Скрипты БД

В директории [/sql](./sql) содержатся для основной работы скрипты:
- [create_candle_table.sql](./sql/create_candle_table.sql) - создание таблицы для исходных часовых показателей цены.
- [create_candle_h12_view.sql](./sql/create_candle_h12_view.sql) - создание представления для агрегации исходных показателей цены в 12-часовые периоды и расчет скользящих средних для них.
- [select_combinations.sql](./sql/select_combinations.sql) - скрипт отбора комбинаций для дальнейшей предобработки и последующих вычислений.

Дополнительно имеются скрипты для внешнего (экспертного) назначения классов комбинациям:

- [create_class_table.sql](./sql/create_class_table.sql) - создание таблицы для классов целевых свечей.
- [insert_class.sql](./sql/insert_class.sql) - наполнение таблицы классов заранее размеченными данными.

#### Зависимости

Дополнительно установил следующие зависимости:

1. Визуализация финансовых графиков, [mplfinance](https://github.com/matplotlib/mplfinance)
```
pip install --upgrade mplfinance
```