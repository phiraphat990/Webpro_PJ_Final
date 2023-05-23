<template>
 <div style="background-color: #f9f7f0">
      <section class="hero is-small has-text-centered">
        <div class="p-6">
            <p class="title is-size-1" style="color: #63b224;">
              Plants Store Web Application.
            </p>
            <img src="../assets/Homepage.png" alt="Homepage" style="width: 75%;"/>
            <p class="title is-size-3 mt-5 p-2">Why Shop at The Plant Store?</p>
            <p class="subtitle mt-3">
              At The Plant Store we put an emphasis on Plants, Prices, Community, Education and Mental Health.
            </p>
            <!-- <button class="button"><router-link to="/manageProduct">GO TO Products</router-link></button> -->
        </div>
      </section>
  </div>
</template>

<script>
import axios from '@/plugins/axios'
// @ is an alias to /src
export default {
  name: "Home",
  props: ['user'],
  data() {
    return {
      search: "",
      blogs: [],
    };
  },
  mounted() {
    this.getBlogs();
  },
  methods: {
    getBlogs() {
      axios
        .get("http://localhost:3000", {
          params: {
            search: this.search,
          },
        })
        .then((response) => {
          this.blogs = response.data;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    imagePath(file_path) {
      if (file_path) {
        return "http://localhost:3000/" + file_path;
      } else {
        return "https://bulma.io/images/placeholders/640x360.png";
      }
    },
    shortContent(content) {
      if (content.length > 200) {
        return content.substring(0, 197) + "...";
      }
      return content;
    },
    addLike(blogId) {
      axios
        .put(`http://localhost:3000/blogs/addlike/${blogId}`)
        .then((response) => {
          let selectedBlog = this.blogs.filter((e) => e.id === blogId)[0];
          selectedBlog.like = response.data.like;
        })
        .catch((err) => {
          console.log(err);
        });
    },

   isBlogOwner (blog) {
          if (!this.user) return false
          return blog.create_by_id === this.user.id
      }
  },
};
</script>
