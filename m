From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] update pasky's email address
Date: Thu, 4 Apr 2013 01:50:42 +0000
Message-ID: <20130404015042.GA19593@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marcin Owsiany <marcin@owsiany.pl>,
	Thomas Rast <trast@inf.ethz.ch>
To: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Apr 04 03:51:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNZKk-0002T7-JI
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 03:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762744Ab3DDBuo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Apr 2013 21:50:44 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40361 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762424Ab3DDBun (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 21:50:43 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09AF1F5BD;
	Thu,  4 Apr 2013 01:50:42 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219984>

Mail to pasky@suse.cz is bouncing.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 I noticed this when I attempted to reply to Thomas's email:
 http://mid.gmane.org/f3d238a4c6cfbc6d68f2c4fa285aefa93acf4b7d.13650276=
16.git.trast@inf.ethz.ch

 .mailmap                                            | 1 +
 Documentation/howto/rebase-from-internal-branch.txt | 4 ++--
 gitweb/static/js/blame_incremental.js               | 2 +-
 gitweb/static/js/javascript-detection.js            | 2 +-
 gitweb/static/js/lib/common-lib.js                  | 2 +-
 gitweb/static/js/lib/datetime.js                    | 2 +-
 perl/Git.pm                                         | 2 +-
 7 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/.mailmap b/.mailmap
index c7e8618..1f01263 100644
--- a/.mailmap
+++ b/.mailmap
@@ -73,6 +73,7 @@ Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
 <nico@fluxnic.net> <nico@cam.org>
 Peter Krefting <peter@softwolves.pp.se> <peter@svarten.intern.softwolv=
es.pp.se>
 Peter Krefting <peter@softwolves.pp.se> <peter@softwolves.pp.se>
+Petr Baudis <pasky@ucw.cz> <pasky@suse.de>
 Philippe Bruhat <book@cpan.org>
 Ralf Thielow <ralf.thielow@gmail.com> <ralf.thielow@googlemail.com>
 Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
diff --git a/Documentation/howto/rebase-from-internal-branch.txt b/Docu=
mentation/howto/rebase-from-internal-branch.txt
index 19ab604..914d011 100644
--- a/Documentation/howto/rebase-from-internal-branch.txt
+++ b/Documentation/howto/rebase-from-internal-branch.txt
@@ -1,6 +1,6 @@
 From:	Junio C Hamano <gitster@pobox.com>
 To:	git@vger.kernel.org
-Cc:	Petr Baudis <pasky@suse.cz>, Linus Torvalds <torvalds@osdl.org>
+Cc:	Petr Baudis <pasky@ucw.cz>, Linus Torvalds <torvalds@osdl.org>
 Subject: Re: sending changesets from the middle of a git tree
 Date:	Sun, 14 Aug 2005 18:37:39 -0700
 Abstract: In this article, JC talks about how he rebases the
@@ -14,7 +14,7 @@ How to rebase from an internal branch
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 --------------------------------------
-Petr Baudis <pasky@suse.cz> writes:
+Petr Baudis <pasky@ucw.cz> writes:
=20
 > Dear diary, on Sun, Aug 14, 2005 at 09:57:13AM CEST, I got a letter
 > where Junio C Hamano <junkio@cox.net> told me that...
diff --git a/gitweb/static/js/blame_incremental.js b/gitweb/static/js/b=
lame_incremental.js
index db6eb50..e162ec9 100644
--- a/gitweb/static/js/blame_incremental.js
+++ b/gitweb/static/js/blame_incremental.js
@@ -1,5 +1,5 @@
 // Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>
-//               2007, Petr Baudis <pasky@suse.cz>
+//               2007, Petr Baudis <pasky@ucw.cz>
 //          2008-2011, Jakub Narebski <jnareb@gmail.com>
=20
 /**
diff --git a/gitweb/static/js/javascript-detection.js b/gitweb/static/j=
s/javascript-detection.js
index fa2596f..3da2d2e 100644
--- a/gitweb/static/js/javascript-detection.js
+++ b/gitweb/static/js/javascript-detection.js
@@ -1,5 +1,5 @@
 // Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>
-//               2007, Petr Baudis <pasky@suse.cz>
+//               2007, Petr Baudis <pasky@ucw.cz>
 //          2008-2011, Jakub Narebski <jnareb@gmail.com>
=20
 /**
diff --git a/gitweb/static/js/lib/common-lib.js b/gitweb/static/js/lib/=
common-lib.js
index 018bbb7..9c3c465 100644
--- a/gitweb/static/js/lib/common-lib.js
+++ b/gitweb/static/js/lib/common-lib.js
@@ -1,5 +1,5 @@
 // Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>
-//               2007, Petr Baudis <pasky@suse.cz>
+//               2007, Petr Baudis <pasky@ucw.cz>
 //          2008-2011, Jakub Narebski <jnareb@gmail.com>
=20
 /**
diff --git a/gitweb/static/js/lib/datetime.js b/gitweb/static/js/lib/da=
tetime.js
index f78c60a..fdd46d3 100644
--- a/gitweb/static/js/lib/datetime.js
+++ b/gitweb/static/js/lib/datetime.js
@@ -1,5 +1,5 @@
 // Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>
-//               2007, Petr Baudis <pasky@suse.cz>
+//               2007, Petr Baudis <pasky@ucw.cz>
 //          2008-2011, Jakub Narebski <jnareb@gmail.com>
=20
 /**
diff --git a/perl/Git.pm b/perl/Git.pm
index 96cac39..7802afc 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1434,7 +1434,7 @@ sub git_cmd_try(&$) {
=20
 =3Dhead1 COPYRIGHT
=20
-Copyright 2006 by Petr Baudis E<lt>pasky@suse.czE<gt>.
+Copyright 2006 by Petr Baudis E<lt>pasky@ucw.czE<gt>.
=20
 This module is free software; it may be used, copied, modified
 and distributed under the terms of the GNU General Public Licence,
--=20
Eric Wong
