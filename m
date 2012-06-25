From: =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
Subject: [PATCH 1/2] git-submodule.sh: fix filename in comment.
Date: Mon, 25 Jun 2012 12:56:59 +0200
Message-ID: <1340621820-19448-1-git-send-email-mgorny@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 12:57:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj6yw-0003tB-6X
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 12:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755814Ab2FYK5S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 06:57:18 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:58260 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755572Ab2FYK5R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 06:57:17 -0400
Received: from pomiocik.lan (77-255-3-88.adsl.inetia.pl [77.255.3.88])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mgorny)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 44DCF1B43CE;
	Mon, 25 Jun 2012 10:57:16 +0000 (UTC)
X-Mailer: git-send-email 1.7.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200564>

Signed-off-by: Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>
---
 git-submodule.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5c61ae2..fbf2faf 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 #
-# git-submodules.sh: add, init, update or list git submodules
+# git-submodule.sh: add, init, update or list git submodules
 #
 # Copyright (c) 2007 Lars Hjemli
=20
--=20
1.7.10.2
