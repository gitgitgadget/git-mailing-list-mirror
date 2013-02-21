From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/4] t7800: update copyright notice
Date: Wed, 20 Feb 2013 20:03:46 -0800
Message-ID: <1361419428-22410-2-git-send-email-davvid@gmail.com>
References: <1361419428-22410-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 05:04:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8NOQ-0000UR-2i
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 05:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198Ab3BUED6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 23:03:58 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:44751 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab3BUED5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 23:03:57 -0500
Received: by mail-pb0-f45.google.com with SMTP id ro8so3278491pbb.32
        for <git@vger.kernel.org>; Wed, 20 Feb 2013 20:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=t1qr2UiXN9ZzGqgGrcEBWSgFZ3VrjXOIqzvtNaGu6Xs=;
        b=tD0ZLDRqRlHFP1sHFALMkZRK0lJXhh6Ph04ign4J5aY0oKXIVeLOfHgo+gKOkVnEOg
         SDp5gWLpAlKkTSzSBklz/WFJq1pjqgiJ3xAsV7YKWI9z38Wil66TTMYjRuCDYtb8ATkP
         QqqVHInwlbqTig+z4bF3Z+6LDmw9V0FRsVv1rwhp5j4Ix4R2KPJNJF9xfV1khbGo+2O9
         M9gxGGmP/XtTYGVB2+L0gHPEp5W8W1iP9VyKZry5ISepurZLQYo+LPo+Rrrarr2yZTrz
         UL7j/EILm+L8PkKMzEL41jTRkz40dj543YIjpgugWHYt9OaExXscVnZEB/hUtC/bxvpw
         pgSg==
X-Received: by 10.66.120.136 with SMTP id lc8mr6000241pab.194.1361419436907;
        Wed, 20 Feb 2013 20:03:56 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id qp13sm23808911pbb.3.2013.02.20.20.03.53
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 20 Feb 2013 20:03:56 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.20.gf548dd7
In-Reply-To: <1361419428-22410-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216747>

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Unchanged since v2.

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
