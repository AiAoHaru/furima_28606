const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);   // PAY.JPテスト公開鍵（環境変数）  
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();   // サーバーサイドにRailsのフォーム送信から値を送らせず、JavaScriptで送らせるためにRailsのフォーム送信処理のキャンセルを設定

    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {    // 入力フォームのカードの情報を変数に代入 
      number: formData.get("item_order[number]"),
      cvc: formData.get("item_order[cvc]"),
      exp_month: formData.get("item_order[exp_month]"),
      exp_year: `20${formData.get("item_order[exp_year]")}`,
    };
    Payjp.createToken(card, (status, response) => {   // PAY.JPにアクセスして、トークンを作成
      if (status == 200) {    // HTTPステータスコードが正常（PAY.JP側の処理でトークンの生成に成功）だった場合、if文の{...}のコードを実行
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} type="hidden" name='item_order[token]'>`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      document.getElementById("card-number").removeAttribute("name");    // パラメーターとして送られないように、値を削除
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");

      document.getElementById("charge-form").submit();    // フォームに記載されている情報をサーバーサイドへ送信
      document.getElementById("charge-form").reset();    // フォームの情報を削除
    });
  });
};

window.addEventListener("load", pay);