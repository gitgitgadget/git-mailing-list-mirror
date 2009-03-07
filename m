From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: fix badly indented paragraphs in
 "--bisect-all" description
Date: Sat, 7 Mar 2009 13:37:24 +0100
Message-ID: <20090307133724.4ff730b4.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 13:39:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfvoj-0002nx-5W
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 13:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806AbZCGMiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 07:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754709AbZCGMiV
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 07:38:21 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:47893 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754644AbZCGMiU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 07:38:20 -0500
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 182174B004F;
	Sat,  7 Mar 2009 13:38:11 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with SMTP id 176AA4B016B;
	Sat,  7 Mar 2009 13:38:09 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112537>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/rev-list-options.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5076322..7dd237c 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -568,11 +568,11 @@ This outputs all the commit objects between the included and excluded
 commits, ordered by their distance to the included and excluded
 commits. The farthest from them is displayed first. (This is the only
 one displayed by `--bisect`.)
-
++
 This is useful because it makes it easy to choose a good commit to
 test when you want to avoid to test some of them for some reason (they
 may not compile for example).
-
++
 This option can be used along with `--bisect-vars`, in this case,
 after all the sorted commit objects, there will be the same text as if
 `--bisect-vars` had been used alone.
-- 
1.6.2.rc2.2.g08c84
