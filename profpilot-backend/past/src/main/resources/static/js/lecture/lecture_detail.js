function openModal() {
    document.getElementById('lecture-popup').style.display = 'block';
}

function closeModal() {
    document.getElementById('lecture-popup').style.display = 'none';
}

// 모달 외부 클릭 시 닫기
window.onclick = function(event) {
    var modal = document.getElementById('lecture-popup');
    if (event.target == modal) {
        closeModal();
    }
}