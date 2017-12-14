// function postComment(){
//     var commentForm = document.getElementById("new_comment")
//     $("#new_comment").submit(function(event) {
//         event.preventDefault()
//         debugger
//         let url = this.action.replace(/https?:\/\/localhost:3000/, "")
//         let values = $(this).serialize()     
//         let postThis = $.post(url, values)

//         postThis.done(function(data) {
//             $('#ajaxComments').html("<%= j (render(@comments)) %>")
//         })
//     })
// }

// $(function (){
//     postComment()
// })