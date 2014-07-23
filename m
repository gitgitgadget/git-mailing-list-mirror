From: Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH 1/2] General Manpage: Switch homepage for stats
Date: Wed, 23 Jul 2014 14:32:09 +0200
Message-ID: <1406118730-13224-1-git-send-email-stefanbeller@gmail.com>
Cc: Stefan Beller <stefanbeller@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 23 14:32:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9viZ-0005oo-H4
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 14:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462AbaGWMcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 08:32:17 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:48519 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbaGWMcP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 08:32:15 -0400
Received: by mail-we0-f174.google.com with SMTP id x48so1130783wes.33
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 05:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5D9aQb0KNY3FxiA5oQFa+KdawyaZgurm4CFTKxsv5Jw=;
        b=IBt4JGhC9ieScMP+tevPFGYXvkQqTVu4r8N3IamNOy2l1G9lwgq4Jl9Bn7yzSiNQ2v
         3zB2IBass7J1nTL2LFPEqJmCPVACI9Ngh3DC4LPcSvrfK5jI99X/3Qwn6r+cGPy8nY/d
         L5u/nNh2xF+GclRZ5oO99ueCSTrhJW/D/XqR1xMOovcmVBeH0QlKjp/If1AM+lh6UtKC
         LX8JdJPZrBgU7Kws3kOn7nfwrpHfYXDHfKDSJ71TShzkqpF3aRiwBLHTpyCUEz/jG3ly
         Zyr/2/mdxeAlAQLRJD/vb5o0ZNP2lr7wRzJcV3+00aaPUYpKCjEkhaginCWhYSLFkFS0
         aoHg==
X-Received: by 10.194.90.51 with SMTP id bt19mr1199940wjb.105.1406118733637;
        Wed, 23 Jul 2014 05:32:13 -0700 (PDT)
Received: from localhost (ip-109-91-30-58.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id cz4sm8942741wib.23.2014.07.23.05.32.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 23 Jul 2014 05:32:13 -0700 (PDT)
X-Mailer: git-send-email 2.0.2.608.g398dd4b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254071>

According to http://meta.ohloh.net/2014/07/black-duck-open-hub/
the site name of ohloh changed to openhub.
Change the man page accordingly.

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
---
 Documentation/git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index d0ddfcb..2dbc63c 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1044,7 +1044,7 @@ Authors
 -------
 Git was started by Linus Torvalds, and is currently maintained by Junio
 C Hamano. Numerous contributions have come from the Git mailing list
-<git@vger.kernel.org>.  http://www.ohloh.net/p/git/contributors/summary
+<git@vger.kernel.org>.  http://www.openhub.net/p/git/contributors/summary
 gives you a more complete list of contributors.
 
 If you have a clone of git.git itself, the
-- 
2.0.2.608.g398dd4b
