From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 01/23] contrib/subtree: Fix typo (s/incldued/included/)
Date: Sun, 10 Mar 2013 23:41:09 +0000
Message-ID: <1362958891-26941-2-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Paul Cartwright <paul.cartwright@ziilabs.com>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Dan Sabath" <dsabath@whitepages.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:43:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpuI-0003X9-Gd
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337Ab3CJXmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:42:52 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:35855 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab3CJXmv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:42:51 -0400
Received: by mail-wg0-f49.google.com with SMTP id 15so4256945wgd.28
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=7ToDa2KZcikCWo3LVjoWOoDxf5so2g2rHwMbSXn6YWk=;
        b=cc9DAcqcuZSWw5wqPhgvRNup9cwURconJLoT/V0zNw+w+SlXZr6asfi1qyV2HRQOYt
         DAs9qAMHHj0nIaxq0q+IaB2KOwBIXW8RmtaLtI7sfE2kBCY4nMpM1KgAsf4LsTNZl/LJ
         2kpn9jLclyffIb+3/XC+4txtYoo/7yFrBetDY4h7Mrd+unRgzvAjn0Hsblik4fpksTOO
         c3ct6qJjqCWCOPmpBtuhEHNVEpnujkIDphzgMzGCT8CC3wjQBWQOYUm5CdhpQelzD/9V
         tdSyhmPI85+6t4ry60ux9bD9uOPgv9dfslHlmftz4SkeVMgvL6C0fRESZL6b5VKSoOyI
         orIw==
X-Received: by 10.194.77.129 with SMTP id s1mr15707416wjw.17.1362958970053;
        Sun, 10 Mar 2013 16:42:50 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.42.46
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:42:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQn0CGYqZV7WZO6BAqFWFpHEWjbvWYKaeW46jsC/dwrhILXSMb8S4ta2eTZAUg9eyJc66QzI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217821>

From: Paul Cartwright <paul.cartwright@ziilabs.com>

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 7ba853e..e0957ee 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -270,7 +270,7 @@ git-extensions repository in ~/git-extensions/:
 name
 
 You can omit the --squash flag, but doing so will increase the number
-of commits that are incldued in your local repository.
+of commits that are included in your local repository.
 
 We now have a ~/git-extensions/git-subtree directory containing code
 from the master branch of git://github.com/apenwarr/git-subtree.git
-- 
1.8.2.rc1
