From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCH] Remove dead link
Date: Fri, 23 Aug 2013 16:25:02 +0200
Message-ID: <884d025e9da6f309d33dffdd1ed3731defa514ba.1377267683.git.mina86@mina86.com>
Cc: git@vger.kernel.org, Michal Nazarewicz <mina86@mina86.com>
To: Jon Loeliger <jdl@jdl.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 16:25:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCsJ5-0002mE-Dg
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 16:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707Ab3HWOZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 10:25:39 -0400
Received: from mail-ea0-f173.google.com ([209.85.215.173]:59876 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645Ab3HWOZi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 10:25:38 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so329161eak.4
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 07:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=QLOAXPnLW8PBraE/FPVWD8KS6QHqsGvnd9GG7PIJaKU=;
        b=Zfm0hRGEhbJbYKLaEN2MOeKOvMtM5CYjpkVLzsFF7Wzb2jp84AyvqyawnV2cr/ByCz
         LdWmWMCT6BrJ5FwnWbf1oxTzPWhuZgkGtybvLGDADBMRAEN8e8fYizaQ5tZqY4Pn1kzX
         e83Q5zFlfBiL0zkgy7i+N/6EYsGsS2HWwcRoyY9I3gv84yr44WuwRzCH2j9dI8HVod6g
         kjC02VaqPwoqcjfJZveJBx/StyA+joZbIc+h9S86RpvXu1Rr08qETOUk/GnU/wl7eh5/
         QfUtzf73d5SKVCPb6fUKdwX8N+5aH3cWds51ScQDwlWcebeiJ1zf/Di+Aa/fsv+c+kBC
         xkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QLOAXPnLW8PBraE/FPVWD8KS6QHqsGvnd9GG7PIJaKU=;
        b=ditzG/sFUOyuBjxbLdHDxdra+jQIhO4jEHZQ50obKuNeZNyalWdMRGjCbQYCFRELmk
         zlHyUTjR/Pn//qeQ20YPILDINFpyN8x3xBJdSQLwSPvPlaX9IaGAndABfBSAQVt/YPtZ
         0DbiU8dui6LqVUmkP6Qh1YhIe1dtQk0uUMj5xMT1F64TeotupevsNMbN4FF+mjRTVYAg
         6/JK9u2ThBIu2ynwUehMBJhlR6vpQHRcDJ1KPW5FHS0ZY25zh98bSVcW10UYWAVP3tpE
         /8nANKa0pM+h+8oDnJlaGWsVtcPAmPWATRIuyShdBkVVEfEeptKWIYC0Bo0CbN2xc1NK
         f0oQ==
X-Gm-Message-State: ALoCoQlaGOaMyB9ZSPRWtUafSgICsKYl30gJw5MqVTWKVkJwracNakbGfVkH4Bn6zwaQXmNOE6VEH37FChPfQ9hiBCUw+dFeB9MNVtMrFvRXTGpYfRh/9RkEG4kLd1nsOlx2YAklAamBIBDh97qD7QMJpL7c5DPDT+Zf4/TV90BtIAMU71cUqd3CQk6IX/lW7/80x4XxcCli
X-Received: by 10.14.109.200 with SMTP id s48mr4371eeg.61.1377267937527;
        Fri, 23 Aug 2013 07:25:37 -0700 (PDT)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:301:dc5b:ca2e:b113:6dc0])
        by mx.google.com with ESMTPSA id d8sm89598eeh.8.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 Aug 2013 07:25:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232810>

From: Michal Nazarewicz <mina86@mina86.com>

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 Documentation/technical/pack-heuristics.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/technical/pack-heuristics.txt b/Documentation/technical/pack-heuristics.txt
index 8b7ae1c..b7bd951 100644
--- a/Documentation/technical/pack-heuristics.txt
+++ b/Documentation/technical/pack-heuristics.txt
@@ -366,12 +366,6 @@ been detailed!
 
     <linus> Yes, we always write out most recent first
 
-For the other record:
-
-    <pasky> njs`: http://pastebin.com/547965
-
-The 'net never forgets, so that should be good until the end of time.
-
     <njs`> And, yeah, I got the part about deeper-in-history stuff
         having worse IO characteristics, one sort of doesn't care.
 
-- 
1.8.4.rc1
