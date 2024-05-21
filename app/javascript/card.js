const pay = () => {
  const publickey = gon.public_key;
  const payjp = Payjp(publickey); // PAY.JPテスト公開鍵
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content'); // CSRFトークンを取得
  const tokenInput = `<input type="hidden" name="authenticity_token" value="${token}">`; // トークンを含むinput要素を作成
  form.insertAdjacentHTML('beforeend', tokenInput); // フォームにトークンを追加

  form.addEventListener("submit", (e) => {
    e.preventDefault(); // デフォルトのフォーム送信をキャンセル
    // フォームに入力されたカードの情報を、JavaScriptで取得してトークン化
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        // エラー処理
      } else {
        const token = response.id;
        // トークンの値をフォームに含める
        const tokenInput = `<input type="hidden" name="token" value="${token}">`;
        form.insertAdjacentHTML("beforeend", tokenInput);
        // フォームの情報をサーバーサイドに送信
        form.submit();
      }
      // クレジットカードの情報を削除
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
    });
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);

