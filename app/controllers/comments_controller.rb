class CommentsController < ApplicationController

    http_basic_authenticate_with name: "ktgw", password: "zob", only: [:create, :destroy]

    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.create(comment_params)
        redirect_to article_path(@article)
    end

    def destroy
        @article = Article.find(params[:article_id])
        @comment = @article.comments.find(params[:id])
        @comment.destroy
        redirect_to article_path(@article), status: :see_other
    end
    # Mais la comme un trou du cul, je viens d'oublier d'implementer le reste, de faire supprimer de la database la data associee au comment. Or je viens de supprimer plusieurs comments. Et donc il reste de la garbage data dans la database. Donc 1. je vais aller m'acheter du QI, et 2. ce pourrait etre une bonne idee de set un status 'deleted' a tout objet (article, comment, whatever) supprime, car si je tape dans le source code un jour ou l'autre, je reimplemente un truc du genre, et je le test pareillement, j'aurai des leftovers dans la database, donc je pourrai les trouver et les en purger facilement via un script de maintenance base sur SQLite3 ou autre. La meme logique s'applique pour plus ou moins tout ce qui touche a la database. Je set un flag, je delete, et si la deletion ne se passe pas, le flag marquera quand meme l'objet pour les prochaines maintenances.

    private
        def comment_params
            params.require(:comment).permit(:commenter, :body, :status)
        end
end
# Tout faire pour ne pas passer pour un mouton, c'est pas en etre un ? A tout faire pour ne pas etre mouton, on n'est qu'un mouton noir. Okay, la couleur change, mais l'animal bouge pas des masses. Comment passer pour un con toujours plus fort dans un monde toujours plus aseptise.
