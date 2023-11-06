const selectPais = document.querySelector('#selectPais');
let listSelect = document.querySelector('#listSelect');
let saveButton = document.getElementById('saveButton');

let listPais = []
function getValueSelect() {
    
    selectPais.addEventListener('change', function(){
        if (listPais.length < 5 && !listPais.includes(selectPais.value)) {
            listPais.push(selectPais.value)
            listPais = Array.from(new Set(listPais));
            console.log(listPais)
            updateList()
        } else {
            alert('Você pode selecionar no máximo 5 países.');
        }
    })
}

// <i class="bi bi-trash"></i>
function updateList() {
    listSelect.innerHTML = '';

// Iterando sobre a lista de países e adicionando à lista
listPais.forEach(function(pais, index) {
    const listItem = document.createElement('div');
    listItem.classList.add('d-flex', 'flex-row', 'align-items-center');

    // Cria um elemento de parágrafo para o nome do país
    const paragraph = document.createElement('p');
    paragraph.classList.add('p-2', 'm-0');
    paragraph.textContent = pais;

    // Cria um botão de lixeira para excluir o país
    const deleteButton = document.createElement('button');
    deleteButton.classList.add('btn');
    deleteButton.innerHTML = '<i class="bi bi-trash"></i>';
    deleteButton.addEventListener('click', function() {
        listPais.splice(index, 1);
        updateList();
    });

    listItem.appendChild(paragraph);
    listItem.appendChild(deleteButton);

    listSelect.appendChild(listItem);
});
}

saveButton.addEventListener('click', function() {
if (listPais.length == 5){
    const body = {
        list : listPais
    }
    fetch(
        `/population`,
        {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(body)
        }
    )
}else{
    alert("Você precisa selecionar 5 paises")
}
});

getValueSelect()