From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] Documentation: add missing second colons and remove a typo
Date: Thu, 12 Oct 2006 18:26:34 +0200
Message-ID: <452E6CBA.7090007@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 12 18:26:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY3O4-0002tG-9U
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 18:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668AbWJLQ0T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 12:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbWJLQ0T
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 12:26:19 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:54199
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932668AbWJLQ0S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 12:26:18 -0400
Received: from [10.0.1.3] (p508E4AE9.dip.t-dialin.net [80.142.74.233])
	by neapel230.server4you.de (Postfix) with ESMTP id 6203B24016;
	Thu, 12 Oct 2006 18:26:17 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28787>

It takes two colons to mark text as item label.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

 Documentation/git-http-push.txt |    2 +-
 Documentation/git-send-pack.txt |    2 +-
 Documentation/git-shortlog.txt  |    4 ++--
 Documentation/glossary.txt      |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index 7e1f894..c2485c6 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -34,7 +34,7 @@ OPTIONS
 	Report the list of objects being walked locally and the
 	list of objects successfully sent to the remote repository.
 
-<ref>...:
+<ref>...::
 	The remote refs to update.
 
 
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 9e67f17..5376f68 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -43,7 +43,7 @@ OPTIONS
 <directory>::
 	The repository to update.
 
-<ref>...:
+<ref>...::
 	The remote refs to update.
 
 
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 1601d22..d54fc3e 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -27,8 +27,8 @@ OPTIONS
 	Sort output according to the number of commits per author instead
 	of author alphabetic order.
 
--s:
-	Supress commit description and Provide a commit count summary only.
+-s::
+	Supress commit description and provide a commit count summary only.
 
 FILES
 -----
diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index 14449ca..7e560b0 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -179,7 +179,7 @@ object name::
 	character hexadecimal encoding of the hash of the object (possibly
 	followed by a white space).
 
-object type:
+object type::
 	One of the identifiers "commit","tree","tag" and "blob" describing
 	the type of an object.
 
@@ -324,7 +324,7 @@ tag::
 	A tag is most typically used to mark a particular point in the
 	commit ancestry chain.
 
-unmerged index:
+unmerged index::
 	An index which contains unmerged index entries.
 
 working tree::
