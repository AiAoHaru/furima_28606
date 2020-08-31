window.addEventListener('keyup', function(){
  const sellingPrice = document.getElementById("item-price").value;
  console.log(sellingPrice)
  
  const sellingPriceCommission = Math.round(sellingPrice*0.1)
  const sellingProfit = sellingPrice - sellingPriceCommission  
  console.log(sellingPriceCommission)
  console.log(sellingProfit)
  
  document.getElementById("add-tax-price").textContent = sellingPriceCommission.toLocaleString("jp",{maximumFractionDigits:5});
  document.getElementById("profit").textContent = sellingProfit.toLocaleString("jp",{maximumFractionDigits:5});
})
