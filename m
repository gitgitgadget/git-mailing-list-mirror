From: jari.aalto@cante.net
Subject: [PATCH] git-rm.txt: (Synopsis): Order options alphabetically
Date: Wed,  1 Dec 2010 17:47:28 +0200
Organization: Private
Message-ID: <1291218448-13409-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 16:47:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNou9-0004nU-57
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 16:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837Ab0LAPrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 10:47:32 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:36976 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab0LAPrb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 10:47:31 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id D26CEC801F
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 17:47:29 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A01EEBAA4D8; Wed, 01 Dec 2010 17:47:29 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id C749127D84
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 17:47:28 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNou0-0003Uh-6g; Wed, 01 Dec 2010 17:47:28 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162537>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-rm.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 71e3d9f..c67966c 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -7,7 +7,7 @@ git-rm - Remove files from the working tree and from the =
index
=20
 SYNOPSIS
 --------
-'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch] [--quiet=
] [--] <file>...
+'git rm' [--cached] [-f | --force] [--ignore-unmatch] [-n] [--quiet] [-r=
] [--] <file>...
=20
 DESCRIPTION
 -----------
--=20
1.7.2.3
