From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 2/4] t7800: update copyright notice
Date: Tue, 19 Feb 2013 21:35:26 -0800
Message-ID: <1361338528-17835-2-git-send-email-davvid@gmail.com>
References: <1361338528-17835-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 06:36:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U82Lj-0000yi-19
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 06:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756356Ab3BTFfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 00:35:47 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:46974 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756308Ab3BTFfq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 00:35:46 -0500
Received: by mail-pb0-f49.google.com with SMTP id xa12so2651103pbc.22
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 21:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=e6cdr9eLtfqWA/Wix2u1PJhCVc6gY0+bG/O/36q6VbY=;
        b=W3MDJdaQKLijkDgjOZixIz9C6Eo50p1d7oSTANr4z+VBHi/ImkGiON6YH31c+a0Xk5
         hKvHACAjblwY3uq4mmFkliq7i6RW9LdMM9DotzJsV90vMmC0sedNlzDuzbNmJGBNfdvj
         am9SqvSbLpnL9ncskfAjiWjL3plsNKKNDGrxoNFLsDH+xEabFZtZFjHWxsOpGMyFgNMV
         sMM2AMKD/MnCIImqnVS8iSqWf4VBKYEEXNGqPnWZL9KarcfneTkgzOn9to7Tox3pqec9
         gOh6hGvDS6piAwDeAzgdSzy78CGBGq7Qe9RIa+T/rzFDOtoCZqJRnwv4CEHhkyXZLF1x
         ZP4A==
X-Received: by 10.68.211.103 with SMTP id nb7mr35661978pbc.140.1361338545512;
        Tue, 19 Feb 2013 21:35:45 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id s9sm26625100pav.7.2013.02.19.21.35.34
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 19 Feb 2013 21:35:44 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.20.gf548dd7
In-Reply-To: <1361338528-17835-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216677>

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 t/t7800-difftool.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index eb1d3f8..5b5939b 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 #
-# Copyright (c) 2009, 2010 David Aguilar
+# Copyright (c) 2009, 2010, 2012, 2013 David Aguilar
 #
 
 test_description='git-difftool
-- 
1.8.2.rc0.20.gf548dd7
