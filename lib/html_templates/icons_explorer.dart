const iconsExplorerHtml = '''
<!DOCTYPE html>
<html>
    <head>
        <style>
            body {
              background-color: lightsteelblue;
            }
            h1 {
                text-align: center;
            }
            input {
                display: block;
                margin: auto;
                font-size: 20px;
                width: 50%;
                padding: 8px;
            }
            .wrapper {
                display: grid;
                grid-gap: 12px;
                grid-template-columns: repeat(5, 1fr);
                margin: 50px 0;
            }
            .icon-item {
                display: flex;
                flex-direction: column;
            }
            .icon-container {
                margin: auto;
                width: 75px;
                height: 100px;
            }
            .icon-container svg {
                width: 100%;
                height: 100%;
            }
            .icon-item .icon-name {
                text-align: center;
                font-size: 18px;
                margin-top: 8px;
            }
        </style>
    </head>
    <body>
        <div>
            <h1>Icons Explorer</h1>
            <input type="text" id="search" placeholder="Search an icon" oninput="onInputChange()">
            <div class="wrapper">
                <!-- ICONS_PLACE -->
            </div>
        </div>
    </body>
    <script>
        function onInputChange(newInput) {
            const searchInput = document.getElementById("search");
            const searchValue = searchInput.value;

            const allIconsSpans = [...document.getElementsByClassName('icon-name')];
            allIconsSpans.forEach(e => {
                e.parentElement.style.display = 'flex';
            })
            if (searchValue != '') {
                const iconsToHideSpan = allIconsSpans.filter(e => !e.innerText.includes(searchValue));
                iconsToHideSpan.forEach(e => {
                    e.parentElement.style.display = 'none';
                })
            }
        }
        </script>
</html>
''';
