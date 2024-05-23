
const price = () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = parseFloat(priceInput.value); // 入力値を数値型に変換
    const addTaxDom = document.getElementById("add-tax-price");
    const addTaxValue = Math.floor(inputValue * 0.1); // 小数点以下を切り捨てた消費税額
    addTaxDom.innerHTML = addTaxValue;
    const addProfitDom = document.getElementById("profit");
    addProfitDom.innerHTML = Math.floor(inputValue - addTaxValue); // 小数点以下を切り捨てた利益額
  })
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);



