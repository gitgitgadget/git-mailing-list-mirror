From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] difftool: Update copyright notices to list each year separately
Date: Fri, 15 Jan 2010 19:10:03 -0800
Message-ID: <1263611403-17900-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 16 04:12:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVz4v-0000Os-Q9
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 04:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758594Ab0APDKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 22:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758830Ab0APDKu
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 22:10:50 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:51063 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758881Ab0APDKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 22:10:09 -0500
Received: by yxe17 with SMTP id 17so1400365yxe.33
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 19:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=pBl8R1pZRBCvfWK7sFfDznJIyLNvYuCefOMFEWB/kss=;
        b=uH6KixoDfK0EXXamGnDXZmnvpzK/LwYHFLjmLITlnQHHre1jo2dTs/MgMBWg4wL6+2
         BiL2qzzEmPNBLVUaXOe9APj54DlBhaCaqhV7ZDAYB57O7XTEVYsn5kCTBsXl79jexOZU
         GxRB26PIphjm71B+J1v+iOKNlWzfEniSP9eyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BDcPr/m3gWynwnpdtcp8uMwitDn+Zt+hlcHQ8SaSFoLrh/AiXZ1y+EziJIvOkAekhB
         ZkIBMhAAk8h5s+GyblWdnNCBO6t3r4M8Nq4jHXoEZi9M/BtHZ8A7Ma1KxuuNnbs9PnO1
         dJdIkIrd92tQSHdP3U5LBo2kQWiQpkpdSwgC0=
Received: by 10.101.180.12 with SMTP id h12mr5952784anp.24.1263611408584;
        Fri, 15 Jan 2010 19:10:08 -0800 (PST)
Received: from localhost (isrfasc7a1-gw.disneyanimation.com [12.188.26.241])
        by mx.google.com with ESMTPS id 21sm1070502ywh.1.2010.01.15.19.10.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 19:10:08 -0800 (PST)
X-Mailer: git-send-email 1.6.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137194>

Reference: http://article.gmane.org/gmane.comp.version-control.git/137182
Signed-off-by: David Aguilar <davvid@gmail.com>
---

This applies on top of the difftool series I sent today
which itself applies on top of da/difftool in next.

 git-difftool--helper.sh |    2 +-
 t/t7800-difftool.sh     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 69f6bce..e43b5d6 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -3,7 +3,7 @@
 # This script is typically launched by using the 'git difftool'
 # convenience command.
 #
-# Copyright (c) 2009-2010 David Aguilar
+# Copyright (c) 2009, 2010 David Aguilar
 
 TOOL_MODE=diff
 . git-mergetool--lib
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index a183f1d..fad5472 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 #
-# Copyright (c) 2009 David Aguilar
+# Copyright (c) 2009, 2010 David Aguilar
 #
 
 test_description='git-difftool
-- 
1.6.2.5
