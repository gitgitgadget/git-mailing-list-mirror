From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 1/2] apply: consistent spelling of "don't"
Date: Wed, 18 Mar 2009 19:05:39 +0100
Message-ID: <1237399540-27258-1-git-send-email-barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 18:59:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk02S-0000Uu-Pn
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 18:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852AbZCRR5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 13:57:16 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754143AbZCRR5P
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 13:57:15 -0400
Received: from smtp.katamail.com ([62.149.157.154]:53091 "HELO smtp2.aruba.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752516AbZCRR5O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 13:57:14 -0400
Received: (qmail 21786 invoked by uid 89); 18 Mar 2009 17:57:05 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.57.140)
  by smtp2-pc with SMTP; 18 Mar 2009 17:57:05 -0000
X-Mailer: git-send-email 1.6.2.22.gc2ac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113638>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 builtin-apply.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index f312798..a664338 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -3212,7 +3212,7 @@ int cmd_apply(int argc, const char **argv, const =
char *unused_prefix)
=20
 	struct option builtin_apply_options[] =3D {
 		{ OPTION_CALLBACK, 0, "exclude", NULL, "path",
-			"don=C2=B4t apply changes matching the given path",
+			"don't apply changes matching the given path",
 			0, option_parse_exclude },
 		{ OPTION_CALLBACK, 0, "include", NULL, "path",
 			"apply changes matching the given path",
--=20
1.6.2.22.gc2ac
