// your_script.js 파일

document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('university').addEventListener('change', function() {
        var buildingSelect = document.getElementById('building');
        buildingSelect.disabled = false;
        buildingSelect.innerHTML = '<option value="">건물 선택</option>';
        $.ajax({
            url: '/api/buildings?universityId=' + this.value,
            type: 'GET',
            success: function(data) {
                data.forEach(function(building) {
                    var option = document.createElement('option');
                    option.value = building.id;
                    option.text = building.buildingName;
                    buildingSelect.appendChild(option);
                });

                // 선택된 건물 이름을 lectureBuilding 필드에 저장
                document.getElementById('building').addEventListener('change', function() {
                    var selectedBuilding = this.options[this.selectedIndex].text;
                    console.log(selectedBuilding);
                    document.getElementById('lectureBuilding').value = selectedBuilding;
                });

            }
        });
    });
});

});