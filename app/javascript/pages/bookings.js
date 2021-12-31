if($("#selectCity")) {
	$("#selectCity").addEventListener("change", (e) => {
		let value = e.target.value
		let url = `${window.location.origin}/services?location_id=${value}`
		console.log(url)	

		fetch(url, {
			method: 'GET',
			headers: {
				'X-Requested-With': 'XMLHttpRequest'
			}
		}).then(resp => resp.text())
		  .then(resp => { eval(resp) })
		  .catch(err => console.error(err))
	})
}
