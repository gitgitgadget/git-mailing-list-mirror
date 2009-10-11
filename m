From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] Documentation: add 'git replace' to main git manpage
Date: Sun, 11 Oct 2009 23:08:25 +0200
Message-ID: <1255295305-7364-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 23:12:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx5i5-0002D4-Uf
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 23:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbZJKVJQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Oct 2009 17:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbZJKVJQ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 17:09:16 -0400
Received: from francis.fzi.de ([141.21.7.5]:20041 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752139AbZJKVJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 17:09:16 -0400
Received: from [127.0.1.1] ([141.21.16.16]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 11 Oct 2009 23:08:37 +0200
X-Mailer: git-send-email 1.6.5.85.g16dab
X-OriginalArrivalTime: 11 Oct 2009 21:08:37.0898 (UTC) FILETIME=[005BFEA0:01CA4AB7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129960>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 command-list.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index fb03a2e..59b0adc 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -92,6 +92,7 @@ git-reflog                              ancillarymani=
pulators
 git-relink                              ancillarymanipulators
 git-remote                              ancillarymanipulators
 git-repack                              ancillarymanipulators
+git-replace                             ancillarymanipulators
 git-repo-config                         ancillarymanipulators	deprecat=
ed
 git-request-pull                        foreignscminterface
 git-rerere                              ancillaryinterrogators
--=20
1.6.5.85.g16dab
