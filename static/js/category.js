document.addEventListener('DOMContentLoaded', function () {
    const accordionButton = document.getElementById('accordion-button');
    const categoryList = document.getElementById('category-list');

    accordionButton.addEventListener('click', function () {
        if (categoryList.style.display === 'none' || categoryList.style.display === '') {
            categoryList.style.display = 'block';
        } else {
            categoryList.style.display = 'none';
        }
    });
});