From: Jeff Muizelaar <jeff@infidigm.net>
Subject: [PATCH] cosmetics: change from 'See-Also' to 'See Also'
Date: Sun, 5 Mar 2006 01:20:07 -0500
Message-ID: <20060305062007.GA23775@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Mar 05 07:20:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFmbI-0007Bg-TG
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 07:20:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbWCEGUK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 5 Mar 2006 01:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbWCEGUK
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 01:20:10 -0500
Received: from [209.161.218.26] ([209.161.218.26]:3245 "EHLO
	freiheit.infidigm.net") by vger.kernel.org with ESMTP
	id S1751894AbWCEGUI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 01:20:08 -0500
Received: from jeff by freiheit.infidigm.net with local (Exim 3.36 #1 (Debian))
	id 1FFmb9-0006Bk-00
	for <git@vger.kernel.org>; Sun, 05 Mar 2006 01:20:07 -0500
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17206>

Changes the documentation that uses 'See-Also' to the more common=20
'See Also' form.
---

 Documentation/git-pack-objects.txt   |    2 +-
 Documentation/git-pack-redundant.txt |    2 +-
 Documentation/git-prune-packed.txt   |    2 +-
 Documentation/git-repack.txt         |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

a4de726b80fe261856b9086b32f6e879f5ff0013
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pac=
k-objects.txt
index 4cb2e83..567dabf 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -101,7 +101,7 @@ Documentation
 -------------
 Documentation by Junio C Hamano
=20
-See-Also
+See Also
 --------
 gitlink:git-repack[1]
 gitlink:git-prune-packed[1]
diff --git a/Documentation/git-pack-redundant.txt b/Documentation/git-p=
ack-redundant.txt
index 9fe86ae..2f4cc46 100644
--- a/Documentation/git-pack-redundant.txt
+++ b/Documentation/git-pack-redundant.txt
@@ -46,7 +46,7 @@ Documentation
 --------------
 Documentation by Lukas Sandstr=F6m <lukass@etek.chalmers.se>
=20
-See-Also
+See Also
 --------
 gitlink:git-pack-objects[1]
 gitlink:git-repack[1]
diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-pru=
ne-packed.txt
index 37c53a9..2348826 100644
--- a/Documentation/git-prune-packed.txt
+++ b/Documentation/git-prune-packed.txt
@@ -40,7 +40,7 @@ Documentation
 --------------
 Documentation by Ryan Anderson <ryan@michonline.com>
=20
-See-Also
+See Also
 --------
 gitlink:git-pack-objects[1]
 gitlink:git-repack[1]
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.tx=
t
index 6c0f792..d2f9a44 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -63,7 +63,7 @@ Documentation
 --------------
 Documentation by Ryan Anderson <ryan@michonline.com>
=20
-See-Also
+See Also
 --------
 gitlink:git-pack-objects[1]
 gitlink:git-prune-packed[1]
--=20
1.2.4.g8bc6
