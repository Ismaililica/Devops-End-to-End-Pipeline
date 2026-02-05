@GetMapping("/ask")
public String lovePage() {
    return """
    <!DOCTYPE html>
    <html lang="tr">
    <head>
        <meta charset="UTF-8">
        <title>Aşkım 💖</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                text-align: center;
                background: linear-gradient(135deg, #ff9a9e, #fad0c4);
                height: 100vh;
                margin: 0;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }
            img {
                width: 300px;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            }
            h1 {
                margin-top: 20px;
                color: #fff;
            }
            h2 {
                color: #fff;
                margin: 20px 0;
            }
            .buttons {
                position: relative;
                width: 300px;
                height: 100px;
            }
            button {
                padding: 12px 24px;
                font-size: 18px;
                border: none;
                border-radius: 10px;
                cursor: pointer;
                position: absolute;
            }
            #yes {
                left: 0;
                background-color: #4CAF50;
                color: white;
            }
            #no {
                right: 0;
                background-color: #f44336;
                color: white;
            }
        </style>
    </head>
    <body>

        <img src="src/main/resources/static/images/bebisimlefotolar.jpg">
        alt="Aşkım">

        <h1>Seni çooooooooook seviyorum aşkım benim 💖</h1>

        <h2>Kapadokya'ya gidiyor muyuz? 😍</h2>

        <div class="buttons">
            <button id="yes" onclick="alert('Biliyordum 😍✈️')">Evet</button>
            <button id="no">Hayır</button>
        </div>

        <script>
            const noButton = document.getElementById("no");

            noButton.addEventListener("mouseover", () => {
                const x = Math.random() * 200;
                const y = Math.random() * 60;
                noButton.style.left = x + "px";
                noButton.style.top = y + "px";
            });
        </script>

    </body>
    </html>
    """;
}
