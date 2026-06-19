import pandas as pd
df=pd.read_excel("C:\\Users\\VENNELA\\OneDrive\\Desktop\\python  data\\Assignment_Retail_Sales_Analysis_Data.xlsx")
df
df.isnull().sum()
df["Age"].mean()
df["Age"]=df["Age"].replace([0,120,150],pd.NA)
df.loc[df["Age"]<0,"Age"]=pd.NA
df
df["Age"].mean()
df["Age"]=df["Age"].fillna(df["Age"].mean()).astype(int)
df
df["Product"]=df["Product"].fillna(df["Product"].mode()[0])
df
df["UnitPrice"].mean()
df["UnitPrice"]=df["UnitPrice"].fillna(df["UnitPrice"].mean()).astype(int)
df
df["Discount"].mean()
df["Discount"]=df["Discount"].fillna(df["Discount"].mean()).astype(int)
df
df.isnull().sum()
import numpy as np
df.loc[df["Sales"]<0,"Sales"]=np.nan
df
df["Sales"].mean()
df["Sales"]=df["Sales"].fillna(df["Sales"].mean()).astype(int)
df
df["Cost"].mean()
df["Cost"]=df["Cost"].fillna(df["Cost"].mean()).astype(int)
df
df["Profit"].mean()
df["Profit"]=df["Profit"].fillna(df["Profit"].mean()).astype(int)
df
df.isnull().sum()
df.info()
import pandas as pd
df["OrderDate"]=pd.to_datetime(df["OrderDate"],format="mixed")
df    
df.info()
df["Region"].unique()
df["State"]=df["State"].replace({
    "telangana":"Telangana",
    "TELANGANA":"Telangana",
    "TG":"Telangana",
    "Telengana":"Telangana"})
df
df["City"].unique()
df["City"]=df["City"].replace({
    "HYD":"Hyderabad",
    "Hyd":"Hyderabad",
    " HYD ":"Hyderabad",
    "hyderabad":"Hyderabad",
    "New Delhi":"Delhi",
    "Calcutta":"Kolkata",
    "Bombay":"Mumbai",
    "Benguluru":"Banglore",
    "BLR":"Banglore",
    "Kochi":"Cochin",
    "Panjim":"Panaji",
    "Madras":"Chennai",
    "BSSR":"Bhubaneswar",
    "Munbai":"Mumbai",
    "BSSR":"Bhubaneswar"})
df
df["City"].unique()    
df["CustomerName"].unique()    
df["Gender"].unique()    
df["Gender"]=df["Gender"].replace({
    "M":"Male",
    "F":"Female",
    "female":"Female",
    "male":"Male"})    
df
df.info()
df["PaymentMode"].mode()
df["PaymentMode"]=df["PaymentMode"].fillna(df["PaymentMode"].mode()[0])
df
df["PaymentMode"].unique()
df["PaymentMOde"]=df["PaymentMode"].replace({
    "UPI":"Upi",
    "upi":"Upi",
    "GooglePay":"GPay",
    "GPay":"GPay"
    })
df
df["Quantity"]=df["Quantity"].replace(["abc"],np.nan)
df
df.loc[df["Quantity"]<0,"Quantity"]=np.nan
df
df["Quantity"].mean()    
df["Quantity"]=df["Quantity"].fillna(df["Quantity"].mean()).astype(int)
df
df["DeliveryDays"].mean()
df["DeliveryDays"]=df["DeliveryDays"].fillna(df["DeliveruDays"].mean()).astype(int)
df
df.info()
df["Rating"].unique()
df["Rating"]=df["Rating"].fillna(df["Rating"].mean()).astype(int)
df
df.info()

df["Returned"].unique()
df["Returned"].mode()
df["Returned"]=df["Returned"].fillna(df["Returned"].mode()[0])
df
df.info()
df.isnull().sum()

#To check the duplicates columns
df[df["OrderID"]==1099]
df=df.drop_duplicates()
df
df.isnull().sum()
#checking each names are equal or not
df["Region"]=df["Region"].str.title()
df
#customer bucketization high,low,avg
mean_sales=df["Sales"].mean()
df["Customer Bucket"]=df["Sales"].apply(
    lambda x:"Low" if x < mean_sales * 0.8
    else "Average" if x <= mean_sales * 1.2
    else "High")
df
#sales category with high,low,avg
mean_sales=df["Sales"].mean()
df["Sales Category"]=df["Sales"].apply(
    lambda x:"High" if x > mean_sales
    else "Low" if x < mean_sales
    else "Average")
df
#Rating 1-7
df["Rating Category"]=df["Rating"].replace({
    1:"Very Poor",
    2:"Poor",
    3:"Fair",
    4:"Average",
    5:"Good",
    6:"Excellent"
    })
df
#Delivery days >5
df["Deivery Status"]=df["DeliveryDays"].apply(
    lambda x:"Deployed" if x > 5 else "On Time"
    )
df
#Profit %
df["Profit %"]=(df["Profit"]/df["Sales"])*100
df
#payment mode
df["PaymentMode"].unique()
df["Paymenty Category"]=df["PaymentMode"].replace({
    "Upi":"Online",
    "Card":"Online",
    "Cash":"Offline"})
df
#one customer how many times repeated >1 frequent buyer <1 not frequent
customer_count=df["CustomerName"].value_counts()
df["Buyer Type"]=df["CustomerName"].map(
    lambda x:"Frequent Buyer" if customer_count[x]>1 else "Not Frequent")
df
#Divide years,month,day in orderdate
df["Year"]=df["OrderDate"].dt.year
df
df["Month"]=df["OrderDate"].dt.month
df
df["Day"]=df["OrderDate"].dt.day
df
df["Quarter"]=df["OrderDate"].dt.quarter
df
df.columns
path=r"C:\\Users\\VENNELA\\OneDrive\\Desktop\\python  data\\Retail data.xlsx"
df.to_excel(path,index=False)



























































