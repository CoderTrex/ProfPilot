document.addEventListener('DOMContentLoaded', () => {
    const modal = document.getElementById("termsModal");
    const btn = document.getElementById("openModalBtn");
    const span = document.getElementsByClassName("closeBtn")[0];

    btn.onclick = function() {
        modal.style.display = "block";
    }

    span.onclick = function() {
        modal.style.display = "none";
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
});
