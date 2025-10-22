import pandas as pd
import plotly.express as px

df = pd.DataFrame({
    "Fruit": ["Apples", "Oranges", "Bananas", "Apples", "Oranges", "Bananas"],
    "Amount": [10, 15, 7, 10, 15, 7],
})
fig = px.scatter(df, x="Fruit", y="Amount", color="Fruit",title="Hello Plotly")
fig.update_layout(template="plotly_white")
fig.show()