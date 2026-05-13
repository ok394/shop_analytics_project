import pandas as pd
from sqlalchemy import create_engine
import matplotlib.pyplot as plt

# подключение к postgresql
engine = create_engine("postgresql+psycopg2://postgres:123123@localhost:5432/shopkz_db")

# sql запрос
query = """
select sale_date, total_amount
from sales
"""

# загрузка данных
df = pd.read_sql(query, engine)

# преобразование даты
df['sale_date'] = pd.to_datetime(df['sale_date'])

# индекс
df.set_index('sale_date', inplace=True)

# ежедневная выручка
daily_revenue = df['total_amount'].resample('D').sum()

# накопительный итог
cumulative_revenue = daily_revenue.cumsum()

# скользящее среднее за 7 дней
rolling_mean = daily_revenue.rolling(7).mean()

# dashboard
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(14, 10))

# верхний график
ax1.bar(daily_revenue.index, daily_revenue.values, label='Дневная выручка')
ax1.plot(rolling_mean.index, rolling_mean.values, linewidth=2, label='Скользящее среднее 7 дней')

ax1.set_title('Дневная выручка и тренд')
ax1.set_xlabel('Дата')
ax1.set_ylabel('Выручка')
ax1.legend()

# нижний график
ax2.plot(cumulative_revenue.index, cumulative_revenue.values, label='Накопительный итог')
ax2.fill_between(
    cumulative_revenue.index,
    cumulative_revenue.values,
    alpha=0.3
)

ax2.set_title('Накопительная выручка')
ax2.set_xlabel('Дата')
ax2.set_ylabel('Сумма')
ax2.legend()

plt.tight_layout()
plt.show()
