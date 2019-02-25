Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D57F520248
	for <e@80x24.org>; Mon, 25 Feb 2019 22:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfBYVPL (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 16:15:11 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:9169 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbfBYVPI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 16:15:08 -0500
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id CB9E02003BE;
        Mon, 25 Feb 2019 22:15:01 +0100 (CET)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH] l10n: fr.po unfuzzy commented entries
Date:   Mon, 25 Feb 2019 22:14:53 +0100
Message-Id: <20190225211453.28300-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <874l8rwrh2.fsf@evledraar.gmail.com>
References: <874l8rwrh2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 0.14.4 gettext release was back in 2005, so presumably this is due
to some GPLv3 allergy of NetBSD's. The OS version itself is 7.1,
released a couple of years ago.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 po/fr.po | 190 +++++++++++++++++++++++++++----------------------------
 1 file changed, 95 insertions(+), 95 deletions(-)

diff --git a/po/fr.po b/po/fr.po
index 7b15b76374..47a4210570 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -22478,185 +22478,185 @@ msgstr "Souhaitez-vous réellement envoyer %s ?[y|N] : "
 #~ msgid "--reschedule-failed-exec requires an interactive rebase"
 #~ msgstr "--reschedule-failed-exec requiert un rebasage interactif"
 
-#, fuzzy
+#
 #~| msgid "git archive [<options>] <tree-ish> [<path>...]"
 #~ msgid "git diff --no-index [<options>] <path> <path>"
 #~ msgstr "git archive [<options>] <arbre ou apparenté> [<chemin>...]"
 
-#, fuzzy
+#
 #~| msgid "invalid sparse value '%s'"
 #~ msgid "invalid --stat value: %s"
 #~ msgstr "valeur invalide de 'sparse' '%s'"
 
-#, fuzzy
+#
 #~| msgid "unable to create '%s'"
 #~ msgid "unable to resolve '%s'"
 #~ msgstr "impossible de créer '%s'"
 
-#, fuzzy
+#
 #~| msgid "expected wanted-ref, got '%s'"
 #~ msgid "%s expects a character, got '%s'"
 #~ msgstr "wanted-ref attendu, '%s' trouvé"
 
-#, fuzzy
+#
 #~| msgid "invalid color '%s' in color.blame.repeatedLines"
 #~ msgid "invalid mode '%s' in --color-moved-ws"
 #~ msgstr "couleur invalide '%s' dans color.blame.repeatedlines"
 
-#, fuzzy
+#
 #~| msgid "invalid value for %s"
 #~ msgid "invalid argument to %s"
 #~ msgstr "Valeur invalide pour %s"
 
-#, fuzzy
+#
 #~| msgid "bad number of arguments"
 #~ msgid "bad --word-diff argument: %s"
 #~ msgstr "mauvais nombre d'arguments"
 
-#, fuzzy
+#
 #~| msgid "Generating patches"
 #~ msgid "generate patch"
 #~ msgstr "Génération des patchs"
 
-#, fuzzy
+#
 #~| msgid "ensure at least <n> lines of context match"
 #~ msgid "generate diffs with <n> lines context"
 #~ msgstr "s'assurer d'au moins <n> lignes de correspondance de contexte"
 
-#, fuzzy
+#
 #~| msgid "(synonym to --stat)"
 #~ msgid "synonym for '-p --raw'"
 #~ msgstr "(synonyme de --stat)"
 
-#, fuzzy
+#
 #~| msgid "(synonym to --stat)"
 #~ msgid "synonym for '-p --stat'"
 #~ msgstr "(synonyme de --stat)"
 
-#, fuzzy
+#
 #~| msgid "machine-readable output"
 #~ msgid "machine friendly --stat"
 #~ msgstr "sortie pour traitement automatique"
 
-#, fuzzy
+#
 #~| msgid "output only the trailers"
 #~ msgid "output only the last line of --stat"
 #~ msgstr "éliminer les lignes terminales vides"
 
-#, fuzzy
+#
 #~| msgid "synonym for --files-with-matches"
 #~ msgid "synonym for --dirstat=cumulative"
 #~ msgstr "synonyme pour --files-with-matches"
 
-#, fuzzy
+#
 #~| msgid "show only filenames instead of matching lines"
 #~ msgid "show only names of changed files"
 #~ msgstr ""
 #~ "n'afficher que les noms de fichiers au lieu des lignes correspondant"
 
-#, fuzzy
+#
 #~| msgid "show only filenames instead of matching lines"
 #~ msgid "show only names and status of changed files"
 #~ msgstr ""
 #~ "n'afficher que les noms de fichiers au lieu des lignes correspondant"
 
-#, fuzzy
+#
 #~| msgid "failed to generate diff"
 #~ msgid "generate diffstat"
 #~ msgstr "échec de la génération de diff"
 
-#, fuzzy
+#
 #~| msgid "show ignored files"
 #~ msgid "show colored diff"
 #~ msgstr "afficher les fichiers ignorés"
 
-#, fuzzy
+#
 #~| msgid "<prefix>/"
 #~ msgid "<prefix>"
 #~ msgstr "<préfixe>/"
 
-#, fuzzy
+#
 #~| msgid "prepend parent project's basename to output"
 #~ msgid "prepend an additional prefix to every line of output"
 #~ msgstr "préfixer le nom de base du projet parent à la sortie"
 
-#, fuzzy
+#
 #~| msgid ""
 #~| "Create a shallow clone truncated to the specified number of revisions"
 #~ msgid "show context between diff hunks up to the specified number of lines"
 #~ msgstr "Créer un clone superficiel tronqué au nombre de révisions spécifié"
 
-#, fuzzy
+#
 #~| msgid "Generic options"
 #~ msgid "Diff rename options"
 #~ msgstr "Options génériques"
 
-#, fuzzy
+#
 #~| msgid "<n>[,<base>]"
 #~ msgid "<n>[/<m>]"
 #~ msgstr "<n>[,<base>]"
 
-#, fuzzy
+#
 #~| msgid "do not detect renames"
 #~ msgid "detect renames"
 #~ msgstr "ne pas détecter les renommages"
 
-#, fuzzy
+#
 #~| msgid "Updated preimage for '%s'"
 #~ msgid "omit the preimage for deletes"
 #~ msgstr "Pré-image mise à jour pour '%s'"
 
-#, fuzzy
+#
 #~| msgid "Performing inexact rename detection"
 #~ msgid "disable rename detection"
 #~ msgstr "Détection de renommage inexact en cours"
 
-#, fuzzy
+#
 #~| msgid "invalid option: %s"
 #~ msgid "Diff algorithm options"
 #~ msgstr "option invalide : %s"
 
-#, fuzzy
+#
 #~| msgid "ignore changes in whitespace when finding context"
 #~ msgid "ignore whitespace when comparing lines"
 #~ msgstr "ignorer des modifications d'espace lors de la recherche de contexte"
 
-#, fuzzy
+#
 #~| msgid "ignore changes in whitespace when finding context"
 #~ msgid "ignore changes in amount of whitespace"
 #~ msgstr "ignorer des modifications d'espace lors de la recherche de contexte"
 
-#, fuzzy
+#
 #~| msgid "ignore changes in whitespace when finding context"
 #~ msgid "ignore changes in whitespace at EOL"
 #~ msgstr "ignorer des modifications d'espace lors de la recherche de contexte"
 
-#, fuzzy
+#
 #~| msgid "text"
 #~ msgid "<text>"
 #~ msgstr "texte"
 
-#, fuzzy
+#
 #~| msgid "mode"
 #~ msgid "<mode>"
 #~ msgstr "mode"
 
-#, fuzzy
+#
 #~| msgid "decorate options"
 #~ msgid "Diff other options"
 #~ msgstr "décorer les options"
 
-#, fuzzy
+#
 #~| msgid "process binary files as text"
 #~ msgid "treat all files as text"
 #~ msgstr "traiter les fichiers binaires comme texte"
 
-#, fuzzy
+#
 #~| msgid "when"
 #~ msgid "<when>"
 #~ msgstr "quand"
 
-#, fuzzy
+#
 #~| msgid ""
 #~| "ignore changes to submodules, optional when: all, dirty, untracked. "
 #~| "(Default: all)"
@@ -22665,72 +22665,72 @@ msgstr "Souhaitez-vous réellement envoyer %s ?[y|N] : "
 #~ "ignorer les modifications dans les sous-modules, \"quand\" facultatif : "
 #~ "all (tous), dirty (sale), untracked (non suivi). (Défaut : all)"
 
-#, fuzzy
+#
 #~| msgid "format"
 #~ msgid "<format>"
 #~ msgstr "format"
 
-#, fuzzy
+#
 #~| msgid "use .gitattributes only from the index"
 #~ msgid "hide 'git add -N' entries from the index"
 #~ msgstr "utiliser .gitattributes seulement depuis l'index"
 
-#, fuzzy
+#
 #~| msgid "string"
 #~ msgid "<string>"
 #~ msgstr "chaîne"
 
-#, fuzzy
+#
 #~| msgid "show matching files in the pager"
 #~ msgid "show all changes in the changeset with -S or -G"
 #~ msgstr "afficher les fichiers correspondant dans le pagineur"
 
-#, fuzzy
+#
 #~| msgid "use extended POSIX regular expressions"
 #~ msgid "treat <string> in -S as extended POSIX regular expression"
 #~ msgstr "utiliser des expressions régulières étendues POSIX"
 
-#, fuzzy
+#
 #~| msgid "print all configuration variable names"
 #~ msgid "override diff.orderFile configuration variable"
 #~ msgstr "afficher tous les noms de variables de configuration"
 
-#, fuzzy
+#
 #~| msgid "object"
 #~ msgid "<object-id>"
 #~ msgstr "objet"
 
-#, fuzzy
+#
 #~| msgid "file"
 #~ msgid "<file>"
 #~ msgstr "fichier"
 
-#, fuzzy
+#
 #~| msgid "commit only specified files"
 #~ msgid "Output to a specific file"
 #~ msgstr "valider seulement les fichiers spécifiés"
 
-#, fuzzy
+#
 #~| msgid "Could not spawn pack-objects"
 #~ msgid "could not start pack-objects"
 #~ msgstr "Impossible de créer des objets groupés"
 
-#, fuzzy
+#
 #~| msgid "Could not spawn pack-objects"
 #~ msgid "could not finish pack-objects"
 #~ msgstr "Impossible de créer des objets groupés"
 
-#, fuzzy
+#
 #~| msgid "unrecognized position:%s"
 #~ msgid "Unrecognized protocol version"
 #~ msgstr "position non reconnue : %s"
 
-#, fuzzy
+#
 #~| msgid "unrecognized position:%s"
 #~ msgid "Unrecognized protocol_version"
 #~ msgstr "position non reconnue : %s"
 
-#, fuzzy
+#
 #~| msgid "could not write '%s'"
 #~ msgid "could not write '%s'."
 #~ msgstr "impossible d'écrire '%s'"
@@ -22744,52 +22744,52 @@ msgstr "Souhaitez-vous réellement envoyer %s ?[y|N] : "
 #~ msgid "cannot read sha1_file for %s"
 #~ msgstr "impossible de lire le fichier sha1 pour %s"
 
-#, fuzzy
+#
 #~| msgid "bad revision '%s'"
 #~ msgid "Can't find revision '%s' to ignore"
 #~ msgstr "mauvaise révision '%s'"
 
-#, fuzzy
+#
 #~| msgid "ignore index when checking"
 #~ msgid "Ignore <rev> when blaming"
 #~ msgstr "ignorer l'index pendant la vérification"
 
-#, fuzzy
+#
 #~| msgid "read message from file"
 #~ msgid "Ignore revisions from <file>"
 #~ msgstr "lire le message depuis un fichier"
 
-#, fuzzy
+#
 #~| msgid "could not resolve HEAD commit"
 #~ msgid "could not resolve HEAD"
 #~ msgstr "impossible de résoudre le commit HEAD"
 
-#, fuzzy
+#
 #~| msgid "HEAD not found below refs/heads!"
 #~ msgid "HEAD (%s) points outside of refs/heads/"
 #~ msgstr "HEAD non trouvée sous refs/heads !"
 
-#, fuzzy
+#
 #~| msgid "No current branch."
 #~ msgid "show current branch name"
 #~ msgstr "Pas de branche courante."
 
-#, fuzzy
+#
 #~| msgid "prune loose refs (default)"
 #~ msgid "use overlay mode (default)"
 #~ msgstr "éliminer les références perdues (défaut)"
 
-#, fuzzy
+#
 #~| msgid "-n and -k are mutually exclusive"
 #~ msgid "-p and --overlay are mutually exclusive"
 #~ msgstr "-n et -k sont mutuellement exclusifs"
 
-#, fuzzy
+#
 #~| msgid "unable to read config file '%s'"
 #~ msgid "move a variable to a different config file"
 #~ msgstr "lecture du fichier de configuration '%s' impossible"
 
-#, fuzzy
+#
 #~| msgid "Unknown commit %s"
 #~ msgid "unknown config source"
 #~ msgstr "Commit inconnu %s"
@@ -22803,161 +22803,161 @@ msgstr "Souhaitez-vous réellement envoyer %s ?[y|N] : "
 #~ "exec, --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) "
 #~ "avec les options am (%s)"
 
-#, fuzzy
+#
 #~| msgid "git remote set-url --delete <name> <url>"
 #~ msgid "git remote set-url --save-to-push <name> <url>"
 #~ msgstr "git remote set-url --delete <nom> <URL>"
 
-#, fuzzy
+#
 #~| msgid "The --cached option cannot be used with the --files option"
 #~ msgid "--save-to-push cannot be used with other options"
 #~ msgstr "L'option --cached ne peut pas être utilisée avec l'option --files"
 
-#, fuzzy
+#
 #~| msgid "--format cannot be used when not listing"
 #~ msgid "--save-to-push can only be used when only one url is defined"
 #~ msgstr "--format ne peut pas être utilisé sans lister"
 
-#, fuzzy
+#
 #~| msgid "git worktree list [<options>]"
 #~ msgid "git stash list [<options>]"
 #~ msgstr "git worktree list [<options>]"
 
-#, fuzzy
+#
 #~| msgid "git remote show [<options>] <name>"
 #~ msgid "git stash show [<options>] [<stash>]"
 #~ msgstr "git remote show [<options>] <nom>"
 
-#, fuzzy
+#
 #~| msgid "git branch [<options>] [-l] [-f] <branch-name> [<start-point>]"
 #~ msgid "git stash branch <branchname> [<stash>]"
 #~ msgstr ""
 #~ "git branch [<options] [-l] [-f] <nom-de-branche> [<point-de-départ>]"
 
-#, fuzzy
+#
 #~| msgid "'$args' is not a stash-like commit"
 #~ msgid "'%s' is not a stash-like commit"
 #~ msgstr "'$args' n'est pas une validation de type remisage"
 
-#, fuzzy
+#
 #~| msgid "Too many revisions specified: $REV"
 #~ msgid "Too many revisions specified:%s"
 #~ msgstr "Trop de révisions spécifiées : $REV"
 
-#, fuzzy
+#
 #~| msgid "'%s' is not a valid ref name"
 #~ msgid "%s is not a valid reference"
 #~ msgstr "'%s' n'est pas un nom valide de référence"
 
-#, fuzzy
+#
 #~| msgid "Cannot apply a stash in the middle of a merge"
 #~ msgid "cannot apply a stash in the middle of a merge"
 #~ msgstr "Impossible d'appliquer un remisage en cours de fusion"
 
-#, fuzzy
+#
 #~| msgid "could not generate todo list"
 #~ msgid "could not generate diff %s^!."
 #~ msgstr "impossible de générer la liste à-faire"
 
-#, fuzzy
+#
 #~| msgid "Conflicts in index. Try without --index."
 #~ msgid "conflicts in index.Try without --index."
 #~ msgstr "Conflits dans l'index. Essayez sans --index."
 
-#, fuzzy
+#
 #~| msgid "Could not save index tree"
 #~ msgid "could not save index tree"
 #~ msgstr "Impossible de sauvegarder l'arbre d'index"
 
-#, fuzzy
+#
 #~| msgid "Could not restore untracked files from stash entry"
 #~ msgid "could not restore untracked files from stash"
 #~ msgstr ""
 #~ "Impossible de restaurer les fichiers non-suivis depuis l'entrée de "
 #~ "remisage"
 
-#, fuzzy
+#
 #~| msgid "Merging %s with %s\n"
 #~ msgid "Merging %s with %s"
 #~ msgstr "Fusion de %s avec %s\n"
 
-#, fuzzy
+#
 #~| msgid "failed to read the index"
 #~ msgid "attempt to recreate the index"
 #~ msgstr "échec à la lecture de l'index"
 
-#, fuzzy
+#
 #~| msgid "Dropped ${REV} ($s)"
 #~ msgid "Dropped %s (%s)"
 #~ msgstr "${REV} supprimé ($s)"
 
-#, fuzzy
+#
 #~| msgid "${REV}: Could not drop stash entry"
 #~ msgid "%s: Could not drop stash entry"
 #~ msgstr "${REV}: Impossible de supprimer l'élément de stash"
 
-#, fuzzy
+#
 #~| msgid "'$args' is not a stash reference"
 #~ msgid "'%s' is not a stash reference"
 #~ msgstr "'$args' n'est pas une référence de remisage"
 
-#, fuzzy
+#
 #~| msgid "Cannot update $ref_stash with $w_commit"
 #~ msgid "Cannot update %s with %s"
 #~ msgstr "Impossible de mettre à jour $ref_stash avec $w_commit"
 
-#, fuzzy
+#
 #~| msgid "tag message"
 #~ msgid "stash message"
 #~ msgstr "message pour l'étiquette"
 
-#, fuzzy
+#
 #~| msgid "--bisect-clean-state requires no arguments"
 #~ msgid "\"git stash store\" requires one <commit> argument"
 #~ msgstr "--bisect-clean-state ne supporte aucun argument"
 
-#, fuzzy
+#
 #~| msgid "Maybe you wanted to say 'git add .'?\n"
 #~ msgid "Did you forget to 'git add'?"
 #~ msgstr "Vous vouliez sûrement dire 'git add .' ?\n"
 
-#, fuzzy
+#
 #~| msgid "Saved working directory and index state $stash_msg"
 #~ msgid "Saved working directory and index state %s"
 #~ msgstr "Copie de travail et état de l'index sauvegardés dans $stash_msg"
 
-#, fuzzy
+#
 #~| msgid "Refresh index"
 #~ msgid "keep index"
 #~ msgstr "Rafraîchir l'index"
 
-#, fuzzy
+#
 #~| msgid "quiet"
 #~ msgid "quiet mode"
 #~ msgstr "quiet"
 
-#, fuzzy
+#
 #~| msgid "list untracked files in columns"
 #~ msgid "include untracked files in stash"
 #~ msgstr "afficher les fichiers non suivis en colonnes"
 
-#, fuzzy
+#
 #~| msgid "show ignored files"
 #~ msgid "include ignore files"
 #~ msgstr "afficher les fichiers ignorés"
 
-#, fuzzy
+#
 #~| msgid "expiry-date"
 #~ msgid "expiry date"
 #~ msgstr "date-d'expiration"
 
-#, fuzzy
+#
 #~| msgid "Use binary search to find the commit that introduced a bug"
 #~ msgid "Find by binary search the change that introduced a bug"
 #~ msgstr ""
 #~ "Trouver par recherche binaire la modification qui a introduit un bogue"
 
-#, fuzzy
+#
 #~| msgid "path into the working tree"
 #~ msgid "Checkout a branch or paths to the working tree"
 #~ msgstr "chemin dans la copie de travail"
@@ -22967,22 +22967,22 @@ msgstr "Souhaitez-vous réellement envoyer %s ?[y|N] : "
 #~ "Reporter les validations locales sur le sommet mis à jour d'une branche "
 #~ "amont"
 
-#, fuzzy
+#
 #~| msgid "invalid ident line: %s"
 #~ msgid "invalid hunk line '%d'\n"
 #~ msgstr "ligne d'identification invalide : %s"
 
-#, fuzzy
+#
 #~| msgid "invalid ident line: %s"
 #~ msgid "invalid hunk line '%s'\n"
 #~ msgstr "ligne d'identification invalide : %s"
 
-#, fuzzy
+#
 #~| msgid "select mainline parent"
 #~ msgid "select lines? "
 #~ msgstr "sélectionner le parent principal"
 
-#, fuzzy
+#
 #~| msgid "cannot store index file"
 #~ msgid "Cannot select line by line\n"
 #~ msgstr "impossible de stocker le fichier d'index"
-- 
2.21.0

