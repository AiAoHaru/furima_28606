window.addEventListener('keyup', function(){
  const sellingPrice = document.getElementById("item-price").value;
  
  const sellingPriceCommission = Math.round(sellingPrice*0.1)
  const sellingProfit = sellingPrice - sellingPriceCommission  
  
  document.getElementById("add-tax-price").textContent = sellingPriceCommission.toLocaleString("jp",{maximumFractionDigits:5});
  document.getElementById("profit").textContent = sellingProfit.toLocaleString("jp",{maximumFractionDigits:5});
})
