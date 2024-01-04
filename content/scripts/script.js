document.getElementById("image").addEventListener("click", function() {
    var gandalf = "images/gandalf.png";
    this.src = gandalf;
    document.getElementById("text-you-fool").textContent = "You fool! Don't touch the ring!!";
});