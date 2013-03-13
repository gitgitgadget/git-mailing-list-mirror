From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 3/4] contrib/subtree: Fix typo (s/incldued/included/)
Date: Wed, 13 Mar 2013 22:32:42 +0000
Message-ID: <1363213963-4065-4-git-send-email-pcampbell@kemitix.net>
References: <1363213963-4065-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Paul Cartwright <paul.cartwright@ziilabs.com>,
	Paul Campbell <pcampbell@kemitix.net>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 13 23:34:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFuFO-0005XP-CU
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 23:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934339Ab3CMWdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 18:33:39 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:53540 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934325Ab3CMWdi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 18:33:38 -0400
Received: by mail-wi0-f182.google.com with SMTP id hi18so1262024wib.3
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 15:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=yFMJ9lwRUz/FQavuJpfolNdbJ6+Yd5oTzoW4ry4X5wo=;
        b=icAXlMoppxHKY31p3JXSEVwgpTPybHDH9OXfDILxcYRhI+Fr8Gn5Fg2bnbYJ6/B7FH
         TD+85+HHW9GTRU6zUkDzVgs+duoaqdd3UjylO4B9PZQ7A9tLBo2mvjCEKSOSbQf5Qle1
         72SKRScdIMhBL67JMQ1v62VDBh/fz6sJ1X8ah6XEA6gF2xJZG2Hiq1RmWBnk3bNXj/KB
         D2EbOfm/p7Aui1cV4qsZGwZjhC+dkABwa+Vn2rhNXymfUcEjbb6DMRbF/EJhm2oNwkD5
         frcsi9dM2t7LbNmCwG5i6v3khzeSdBhP/xul/OoLy57OVtueANIodFnz4TLHpDKaFw6j
         flBg==
X-Received: by 10.180.83.39 with SMTP id n7mr172668wiy.8.1363214017105;
        Wed, 13 Mar 2013 15:33:37 -0700 (PDT)
Received: from coyote.home (host-2-102-86-203.as13285.net. [2.102.86.203])
        by mx.google.com with ESMTPS id c15sm330641wiw.3.2013.03.13.15.33.35
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 13 Mar 2013 15:33:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1363213963-4065-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQkry5EoC/jyvrnyaBq6K9TF8PQW095DmkABS5MojAylev7ijk0K4oso1EHb2Ex3P4ryUAT/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218099>

From: Paul Cartwright <paul.cartwright@ziilabs.com>

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 97dd3c9..e1bfa61 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -275,7 +275,7 @@ git-extensions repository in ~/git-extensions/:
 name
 
 You can omit the --squash flag, but doing so will increase the number
-of commits that are incldued in your local repository.
+of commits that are included in your local repository.
 
 We now have a ~/git-extensions/git-subtree directory containing code
 from the master branch of git://github.com/apenwarr/git-subtree.git
-- 
1.8.2
