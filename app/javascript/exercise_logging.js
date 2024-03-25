//initialize the rep shortcut buttons
const initRepShortcuts = () => {
    const buttons = document.querySelectorAll('#shortcut-buttons button');
    const repCount = document.querySelectorAll('#rep-count')[0];
    buttons.forEach((btn)=> {
         btn.addEventListener('click', function(e, target) {
            e.preventDefault();
            repCount.value = parseInt(e.target.textContent);
         });
    });
}

//init
initRepShortcuts();
