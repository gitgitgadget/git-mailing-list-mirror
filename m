From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH 02/15] Documentation: fix gitlinks
Date: Wed, 2 Jul 2008 23:54:38 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807022347200.16085@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <7viqvqov01.fsf@gitster.siamese.dyndns.org> <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Dan McGee <dpmcgee@gmail.com>,
	"Dana L. How" <danahow@gmail.com>,
	"J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 10:25:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEK7k-0002yW-LE
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123AbYGCG7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752669AbYGCG5x
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:57:53 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:42557 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbYGCEyl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 00:54:41 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m634sctR007371;
	Wed, 2 Jul 2008 23:54:38 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m634sc0M017877;
	Wed, 2 Jul 2008 23:54:38 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87239>

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Documentation/git-repack.txt  |    2 +-
 Documentation/user-manual.txt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 0d72e83..c956aff 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -72,7 +72,7 @@ OPTIONS
 	`git-update-server-info`.  This option skips
 	updating local catalog files needed to publish
 	this repository (or a direct copy of it)
-	over HTTP or FTP.  See gitlink:git-update-server-info[1].
+	over HTTP or FTP.  See linkgit:git-update-server-info[1].
 
 --window=[N]::
 --depth=[N]::
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index ca13266..cbfc5d0 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1303,7 +1303,7 @@ $ git diff -3 file.txt		# diff against stage 3
 $ git diff --theirs file.txt	# same as the above.
 -------------------------------------------------
 
-The linkgit:git-log[1] and gitk[1] commands also provide special help
+The linkgit:git-log[1] and linkgit:gitk[1] commands also provide special help
 for merges:
 
 -------------------------------------------------
-- 
1.5.5.GIT
