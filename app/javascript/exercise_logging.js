//initialize the rep shortcut buttons
var initRepShortcuts = () => {
    var buttons = document.querySelectorAll('#shortcut-buttons button.rep-changer');
    buttons.forEach((btn)=> {
         btn.addEventListener('click', function(e, target) {
            e.preventDefault();
            setRepCount(e.target.textContent);
         });
    });

    var setRepCount = (value) => {
        var repCount = document.querySelectorAll('#rep-count')[0];
        repCount.value = parseInt(value);
    }

    var incrementRepCount = (amount) => {
        var repCount = document.querySelectorAll('#rep-count')[0];
        repCount.value = parseInt(repCount.value || 0) + amount;
    }

    var minusBtn = document.querySelectorAll('#rep-btn-minus')[0];
    var plusBtn = document.querySelectorAll('#rep-btn-plus')[0];

    minusBtn.addEventListener('click', function(e, target) {
        e.preventDefault();
        incrementRepCount(-1);
    });

    plusBtn.addEventListener('click', function(e, target) {
        e.preventDefault();
        incrementRepCount(1);
    });
}

//init
initRepShortcuts();
