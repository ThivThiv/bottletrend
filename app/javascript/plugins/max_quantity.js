const maxQuantity = () => {
  const input = document.querySelector('#transaction_quantity')
  if (input) {
    const availableStock = document.querySelector(".available-stock").innerHTML;
    input.addEventListener('change', (event) => {
      const inputValue = event.target.value
      if (availableStock < inputValue) {
        const alert = document.getElementById('alert-msg')
        setTimeout(alert.classList.remove('d-none'), 2000)
      }
    })
  }
}

export { maxQuantity }
