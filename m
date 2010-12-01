From: jari.aalto@cante.net
Subject: [PATCH] git-commit.txt: (synopsis): move -i and -o before "--"
Date: Wed,  1 Dec 2010 16:51:25 +0200
Organization: Private
Message-ID: <74d884bbd76bf090472b123f8053f095cda523f9.1291215072.git.jari.aalto@cante.net>
References: <7vlj4b280b.fsf@alter.siamese.dyndns.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 15:51:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNo1w-0001GM-20
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 15:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042Ab0LAOvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 09:51:31 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:56783 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843Ab0LAOva (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 09:51:30 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 132EB13BD71
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 16:51:27 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A05BC5134FB; Wed, 01 Dec 2010 16:51:27 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 062741C6385
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 16:51:25 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNo1l-0002vP-Hv; Wed, 01 Dec 2010 16:51:25 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vlj4b280b.fsf@alter.siamese.dyndns.org>
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162523>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-commit.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 42fb1f5..46ddc80 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -11,8 +11,8 @@ SYNOPSIS
 'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dry-=
run]
 	   [(-c | -C) <commit>] [-F <file> | -m <msg>] [--reset-author]
 	   [--allow-empty] [--allow-empty-message] [--no-verify] [-e] [--author=
=3D<author>]
-	   [--date=3D<date>] [--cleanup=3D<mode>] [--status | --no-status] [--]
-	   [[-i | -o ]<file>...]
+	   [--date=3D<date>] [--cleanup=3D<mode>] [--status | --no-status]
+	   [-i | -o ] [--] [<file>...]
=20
 DESCRIPTION
 -----------
--=20
1.7.2.3
