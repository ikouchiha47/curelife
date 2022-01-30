if($(".bookdoctor")) {
    let els = $$(".bookdoctor");

    els.forEach(el => {
        el.addEventListener("click", handleBookDoctor)
    })
}

function toggleModal() {
    if(!$("#modal")) { return; }

    let modal = $("#modal");
    if(modal.classList.contains("hidden")) {
        modal.classList.remove("hidden")
    } else {
        modal.classList.add("hidden")
        modal.innerHTML = ""
    }
}

function handleBookDoctor(e) {
    e.preventDefault();
    
    let target = e.target;
    let bookingID = target.dataset.bookingId,
        userID = target.dataset.userId,
        doctorID = target.dataset.doctorId;
    
    let locationID = (new URLSearchParams(window.location.search)).get("locations[]")

    let url = `${window.location.origin}/bookings/${bookingID}/appointment?doctor_id=${doctorID}&location_id=${locationID}`
    fetch(url, {
        method: 'GET',
        headers: {
            'X-Requested-With': 'XMLHttpRequest'
        }
    }).then(resp => resp.text())
      .then(resp => { eval(resp) })
      .catch(err => { console.error(err) })
}

