(function () {
  var reveal = document.querySelectorAll(".rv");
  if ("IntersectionObserver" in window) {
    var observer = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add("on");
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 0.12 });
    reveal.forEach(function (element) { observer.observe(element); });
  } else {
    reveal.forEach(function (element) { element.classList.add("on"); });
  }

  var fixedCoa = document.querySelector(".fixed-coa");
  function updateFixedCta() {
    if (!fixedCoa) return;
    var available = document.documentElement.scrollHeight - window.innerHeight;
    var ratio = available > 0 ? window.scrollY / available : 0;
    fixedCoa.classList.toggle("show", ratio >= 0.6);
  }
  window.addEventListener("scroll", updateFixedCta, { passive: true });
  updateFixedCta();

  document.querySelectorAll(".faq-toggle").forEach(function (button) {
    button.addEventListener("click", function () {
      var item = button.closest(".faq-item");
      if (!item) return;
      item.classList.toggle("open");
      button.setAttribute("aria-expanded", item.classList.contains("open") ? "true" : "false");
    });
  });
}());

var lots = {
  B08: { assay: "99.2 %", ins: "0.07 %", cl: "0.0014 %", ph: "4.5", d: "2026-06-18" },
  B09: { assay: "99.1 %", ins: "0.08 %", cl: "0.0012 %", ph: "4.6", d: "2026-06-27" },
  B10: { assay: "99.3 %", ins: "0.06 %", cl: "0.0015 %", ph: "4.5", d: "2026-07-05" }
};

function showLot(id, button) {
  var lot = lots[id];
  if (!lot) return;
  ["assay", "ins", "cl", "ph", "d"].forEach(function (key) {
    var element = document.getElementById("lv-" + key);
    if (element) element.textContent = lot[key];
  });
  document.querySelectorAll(".lotTab").forEach(function (tab) {
    tab.classList.remove("act");
    tab.style.background = "#fff";
    tab.style.color = "var(--muted)";
    tab.style.borderColor = "var(--line)";
  });
  if (button) {
    button.classList.add("act");
    button.style.background = "var(--ink)";
    button.style.color = "#fff";
    button.style.borderColor = "var(--ink)";
  }
}

function coaMail(event) {
  event.preventDefault();
  var email = event.target.querySelector('input[type="email"]');
  location.href = "mailto:sales@oranphos.com?subject=" + encodeURIComponent("COA pack request") +
    "&body=" + encodeURIComponent("Please send the COA pack to: " + (email ? email.value : ""));
  return false;
}

function cMail(event) {
  event.preventDefault();
  var form = event.target;
  function value(name) { return form.querySelector("[name=" + name + "]").value; }
  location.href = "mailto:sales@oranphos.com?subject=" + encodeURIComponent("Inquiry from " + value("company")) +
    "&body=" + encodeURIComponent("Name: " + value("name") + "\nCompany: " + value("company") +
      "\nCountry: " + value("country") + "\n\n" + value("msg"));
  return false;
}
