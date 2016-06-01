From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] Documentation/git-send-email: fix typo in gmail 2FA section
Date: Thu,  2 Jun 2016 01:37:41 +0200
Message-ID: <20160601233741.31594-1-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 01:38:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8FiX-0003hW-Dc
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 01:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbcFAXiZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2016 19:38:25 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:44813 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751058AbcFAXiY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2016 19:38:24 -0400
Received: from x590c39c4.dyn.telefonica.de ([89.12.57.196] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1b8FiM-0003ZK-Ll; Thu, 02 Jun 2016 01:38:20 +0200
X-Mailer: git-send-email 2.9.0.rc0.90.g0dee6e8
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1464824300.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296176>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

On top of v2.9.0-rc1~10^2 (Documentation: add instructions to help
setup gmail 2FA, 2016-05-27).

 Documentation/git-send-email.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-=
email.txt
index edbba3a2ef4c..a88d18604a5b 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -450,7 +450,7 @@ edit ~/.gitconfig to specify your account settings:
 		smtpUser =3D yourname@gmail.com
 		smtpServerPort =3D 587
=20
-If you have multifactor authentication setup on your gmail acocunt, yo=
u will
+If you have multifactor authentication setup on your gmail account, yo=
u will
 need to generate an app-specific password for use with 'git send-email=
'. Visit
 https://security.google.com/settings/security/apppasswords to setup an
 app-specific password.  Once setup, you can store it with the credenti=
als
--=20
2.9.0.rc0.90.g0dee6e8
