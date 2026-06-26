package model;

public class Category {
    private int id;
    private String name;
    private String slug;
    private String imageUrl;

    public Category() {}

    public Category(int id, String name, String slug, String imageUrl) {
        this.id = id; this.name = name; this.slug = slug; this.imageUrl = imageUrl;
    }

    public int getId()                      { return id; }
    public void setId(int id)               { this.id = id; }

    public String getName()                 { return name; }
    public void setName(String name)        { this.name = name; }

    public String getSlug()                 { return slug; }
    public void setSlug(String slug)        { this.slug = slug; }

    public String getImageUrl()             { return imageUrl; }
    public void setImageUrl(String imageUrl){ this.imageUrl = imageUrl; }
}
