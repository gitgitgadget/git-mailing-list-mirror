From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/4] t7800: Update copyright notice
Date: Fri, 15 Feb 2013 21:47:44 -0800
Message-ID: <1360993666-81308-2-git-send-email-davvid@gmail.com>
References: <1360993666-81308-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 06:48:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6adO-0001e6-FU
	for gcvg-git-2@plane.gmane.org; Sat, 16 Feb 2013 06:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344Ab3BPFr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2013 00:47:56 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:52662 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab3BPFrz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2013 00:47:55 -0500
Received: by mail-ie0-f179.google.com with SMTP id k11so5636497iea.24
        for <git@vger.kernel.org>; Fri, 15 Feb 2013 21:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=UUh/kRAoM4Cyd+dQuFCXxHZ4OhqFANvR3jEFCXfNv0o=;
        b=aawaUDFeX3i9pKdmg7CCcyEWL86oI3ZbRg47KW8HOTzcsWxqU/8GG1aSz/SmgwTJCA
         mPECrKu894p3mkKZdFSp/M6wXs8kDY9DDxPURej9Bs2Pa8iMNenJhjTi7xrFcXVOirBl
         cpvJnnJIpbpD3M4e4/mrfOQypFiXwbEDkvXT7IsvTM+/k/iQLgH6QyRjs601rTtIPyV2
         412KEMPfsrKFZdw3VwiSyxIOmptddoFbMNr/wBFmcmj3gDaYvuXuGsS2aQw7qsblfmEO
         xDQZxyXG+rk5XN0aXVHJLmfCjw7sB8umseQNnWDGu0Qyi/RCE83B5NNCic7iaZIdKOx9
         PrzQ==
X-Received: by 10.50.219.234 with SMTP id pr10mr3432127igc.26.1360993674776;
        Fri, 15 Feb 2013 21:47:54 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id z1sm6255743igc.1.2013.02.15.21.47.53
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 15 Feb 2013 21:47:54 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.623.g622c8fc
In-Reply-To: <1360993666-81308-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216373>

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 t/t7800-difftool.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index eb1d3f8..bb3158a 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 #
-# Copyright (c) 2009, 2010 David Aguilar
+# Copyright (c) 2009, 2010, 2012 David Aguilar
 #
 
 test_description='git-difftool
-- 
1.8.1.3.623.g622c8fc
