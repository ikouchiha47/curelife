let dashed = (camel) => camel.replace(/[A-Z]/g, m => "-" + m.toLowerCase());
let rzp;

function payup(e) {
    if(!rzp) return
    rzp.open()
    e.preventDefault()
}

function handlePayment() {
    let el = $("#values");
    if(!el) {
        return
    }

    let dataset = el.dataset
    // debugger 

    let options = Object.keys(dataset)
        .map(k => [dashed(k), dataset[k]])
        .reduce((acc, kv) => {
            let sps = kv[0].split("-");
            let t = acc;

            sps.forEach((k, i) => {
              t = i == sps.length - 1 ? t[k] = kv[1] : t[k] = {}
            })

            return acc
        }, {})

    options = Object.assign(options, {
        theme: {
            color: "#fff",
            backdrop_color: "#3399cc"
        },
        handler: function(response) {
            let data = new FormData();
            let fields = ["razorpay_order_id", "razorpay_payment_id", "razorpay_signature"]
            fields.forEach(function(field) {
                data.append(field, response[field])
            })

            console.log(fields)
            fetch(options.success.handler, {
                method: 'POST',
                body: data
            }).then(resp => resp.text()).then(x => {
                alert("payment successs")
                $("#rzp-button1").removeEventListener('click', payup)
                window.location.href=options.redirect_url
            })
        }
      })

    // console.log(options) 

    rzp = new Razorpay(options)
    rzp.on('payment,failed', function(resp) {
        var data = new FormData();
        data.append('error_code', resp.error.code)
        data.append('error_source', resp.error.source)
        data.append('reason', resp.error.reason)
        data.append('error_order_id', resp.error.metadata.order_id)
        data.append('error_payment_id', resp.error.metadata.payment_id)

        fetch(options.failure.handler, {
            method: 'POST',
            body: data
        }).then(resp => resp.text()).then(x => {
            alert("payment failed")
            window.location.href=options.redirect_url
        })
    })
    
    $("#rzp-button1").addEventListener("click", payup)
}

let s = document.createElement('script')
s.setAttribute('src', "https://checkout.razorpay.com/v1/checkout.js")
s.dataset.buttontext="Pay with RazorPay"
s.onload = handlePayment()
