From: jari.aalto@cante.net
Subject: [PATCH] git-init.txt: order options alphabetically
Date: Wed,  1 Dec 2010 22:04:55 +0200
Organization: Private
Message-ID: <1291233895-20780-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 21:05:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNsvI-0004s5-8f
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 21:05:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756849Ab0LAUE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 15:04:59 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:49330 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755947Ab0LAUE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 15:04:58 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 76CE013BADB
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:04:57 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A010FF6FB63; Wed, 01 Dec 2010 22:04:57 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 681DE41BE8
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:04:56 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNsv9-0005Pa-MH; Wed, 01 Dec 2010 22:04:55 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162595>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-init.txt |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 00d4a12..65463a9 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -16,20 +16,15 @@ OPTIONS
=20
 --
=20
--q::
---quiet::
-
-Only print error and warning messages, all other output will be suppress=
ed.
-
 --bare::
=20
 Create a bare repository. If GIT_DIR environment is not set, it is set t=
o the
 current working directory.
=20
---template=3D<template_directory>::
+-q::
+--quiet::
=20
-Specify the directory from which templates will be used.  (See the "TEMP=
LATE
-DIRECTORY" section below.)
+Only print error and warning messages, all other output will be suppress=
ed.
=20
 --shared[=3D(false|true|umask|group|all|world|everybody|0xxx)]::
=20
@@ -71,6 +66,11 @@ into it.
 If you name a (possibly non-existent) directory at the end of the comman=
d
 line, the command is run inside the directory (possibly after creating i=
t).
=20
+--template=3D<template_directory>::
+
+Specify the directory from which templates will be used.  (See the "TEMP=
LATE
+DIRECTORY" section below.)
+
 --
=20
=20
--=20
1.7.2.3
