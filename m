From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/3] l10: de.po: grammar fix
Date: Tue, 19 May 2015 10:51:32 +0200
Message-ID: <2b4460dbf6abb15c4cd94d4c5c335cc9e8059ee7.1432025365.git.git@drmicha.warpmail.net>
References: <cover.1432025365.git.git@drmicha.warpmail.net>
Cc: Ralf Thielow <ralf.thielow@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 10:51:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YudFf-0007U6-Gg
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 10:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbbESIvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 04:51:42 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55371 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753628AbbESIvj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2015 04:51:39 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 904D4209BF
	for <git@vger.kernel.org>; Tue, 19 May 2015 04:51:37 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 19 May 2015 04:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=lo7TpcB5Dm4u7E8dsDD2zgFFfDU
	=; b=X4rF0HZiV9T/EDztXW9S2Fdt/aWtY8fWSccyYgVSo25UG6ifCRWQTFvf23H
	mro7DI9cdEb+vARS+AzN+PmNwvr/VgADofddQHMvqzLvCESDOJ1gvok3/yhXgWxN
	0OXPcsG2OqPhHwSjkHrbk5QsOhRr72Wchx1X/K0z/caOIjhc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=lo7T
	pcB5Dm4u7E8dsDD2zgFFfDU=; b=NZHKplA8Ac6Tza46YLHCW6EUMT7g2OkgAVkn
	D19dlciIKFKzNXK3zkB9G/5qURTHpJRgjsknYlG+/YVJvoEn3hdveeYsSD4QYhzs
	645DXwCmcR0+gGGJG8ATW+6m2vQeb1njRKQlg5GvgF1nIztBLO8/2gT7Ig009p21
	a472IMw=
X-Sasl-enc: PpMNaCQanDKDxuriyxLWRgkrj03UMtLfbSVh+53Dq9s6 1432025497
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 21322C0001A;
	Tue, 19 May 2015 04:51:37 -0400 (EDT)
X-Mailer: git-send-email 2.4.0.rc3.332.g886447c
In-Reply-To: <cover.1432025365.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269346>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 po/de.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index 2feaec1..25258e3 100644
--- a/po/de.po
+++ b/po/de.po
@@ -10478,7 +10478,7 @@ msgstr ""
 #: git-am.sh:142
 msgid "Using index info to reconstruct a base tree..."
 msgstr ""
-"Verwende Informationen aus der Staging-Area, um einen Basisverzeichnis "
+"Verwende Informationen aus der Staging-Area, um ein Basisverzeichnis "
 "nachzustellen"
 
 #: git-am.sh:157
-- 
2.4.0.rc3.332.g886447c
