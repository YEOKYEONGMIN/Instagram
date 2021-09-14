
document.querySelector('#followBtn').onclick = (e) =>{
    e.preventDefault();

    document.querySelector('.modal-heart').style.display = "flex";
};
document.querySelector('.modal-heart').addEventListener('click', (e) => {
    if (e.target.classList[0] === "modal-heart") {
        document.querySelector('.modal-heart').style.display = "none";
    }
});