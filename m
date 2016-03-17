From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH 03/10] Documentation: Whitespace fix
Date: Thu, 17 Mar 2016 19:46:54 +0100
Message-ID: <1458240421-3593-4-git-send-email-anton.wuerfel@fau.de>
References: <1458240421-3593-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, i4passt@cs.fau.de,
	Phillip Raffeck <phillip.raffeck@fau.de>,
	Anton Wuerfel <anton.wuerfel@fau.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 19:47:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agcxY-0007X0-6i
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 19:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936543AbcCQSrl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 14:47:41 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:43314 "EHLO
	faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935918AbcCQSrh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2016 14:47:37 -0400
Received: from faui49man2 (faui49man2.informatik.uni-erlangen.de [131.188.42.190])
	by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 792EE58C4D0;
	Thu, 17 Mar 2016 19:47:34 +0100 (CET)
Received: by faui49man2 (sSMTP sendmail emulation); Thu, 17 Mar 2016 19:47:34 +0100
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1458240421-3593-1-git-send-email-anton.wuerfel@fau.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289144>

This commit contains just a tiny whitespace fix in the git-tag document=
ation.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
---
 Documentation/git-tag.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 940676e..b49725b 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -39,7 +39,7 @@ created (i.e. a lightweight tag).
 A GnuPG signed tag object will be created when `-s` or `-u
 <keyid>` is used.  When `-u <keyid>` is not used, the
 committer identity for the current user is used to find the
-GnuPG key for signing. 	The configuration variable `gpg.program`
+GnuPG key for signing. The configuration variable `gpg.program`
 is used to specify custom GnuPG binary.
=20
 A tag containing a time-stamp according to RFC3161 will be created whe=
n `-t` is
--=20
2.8.0.rc0.62.gfc8aefa.dirty
