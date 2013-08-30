From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 28/28] rebase: cherry-pick: add copyright
Date: Fri, 30 Aug 2013 00:56:22 -0500
Message-ID: <1377842182-18724-29-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:02:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHmt-0007tj-PW
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756002Ab3H3GCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:02:15 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:60111 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755984Ab3H3GCM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:02:12 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so1768964oag.21
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1B5VDDvFugA1kqYWp3D8X+o5CQBJQKcSNpWYnYkIRes=;
        b=onUakp+pvmkSnH07o/D/3+gbAFZorvNNeaSZJw8QKAQGeEuoLXG/2l5nqKz1DPZ1/j
         sbdNGycUsMl6LTVd6H4FKOdAW7TwPIzkY+Ax7jeCw2VtFNsQDeVmZa7yZVJhSg7PlG4T
         rvA81wOVTwHqvfsY1WgFzMEsRUmyHRuXMPOpVLGpHbO6XGAqELioxuTa2LO6oSdMGr91
         xSuvtbXx6U6LPEA7g3dXMjNldqtolCEItGLHgXCLW7EZ2BwzBahkGCroZ5ODdUWShKg1
         +DfNKwaNH2hno5rswsva9G5Ap87EPBxSJrbcrouSi5wIuPPVCfLKd5ARkQh7Zn3kfwlc
         DjUQ==
X-Received: by 10.182.45.195 with SMTP id p3mr5589779obm.29.1377842532177;
        Thu, 29 Aug 2013 23:02:12 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xr8sm35742615obc.12.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:02:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233422>

Probably enough changes to warrant that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index bda7cfc..da949aa 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 #
-# Copyright (c) 2010 Junio C Hamano.
+# Copyright (c) 2013 Felipe Contreras
 #
 
 GIT_CHERRY_PICK_HELP="$resolvemsg"
-- 
1.8.4-fc
