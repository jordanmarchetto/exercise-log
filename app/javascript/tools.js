//initialize the tools
const initToolsControls = () => {
    const button = document.querySelectorAll('#calculate-button')[0];
    const inputs = document.querySelectorAll('.max-calc-input');
    
    const updateValue = () => {
        const weight = parseInt(document.querySelectorAll('#weight')[0].value);
        const reps = parseInt(document.querySelectorAll('#reps')[0].value);
        const display = document.querySelectorAll('#estimated-max')[0];
        const estMax = Math.round(((weight * reps * 0.0333) + weight) * 100) / 100 ;
        if(isNaN(estMax)){
            display.textContent =  "";
        } else {
            display.textContent =  "Estimated Max: " + estMax + " lbs.";
        }
    }
    
    //bind calc button
    button.addEventListener('click', function(e, target) {
        e.preventDefault();
        updateValue();
    });

    //bind input change
    inputs.forEach((inp) => {
        inp.addEventListener('change', function(e, target) {
            updateValue();
        });
   });
}

//init
initToolsControls();
