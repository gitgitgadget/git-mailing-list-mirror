From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] Documentation, git reset: fix typo.
Date: Fri, 19 Jul 2013 18:26:24 +0200
Message-ID: <1374251184-24095-1-git-send-email-stefanbeller@googlemail.com>
References: <CADfnUUKVDmuqt9s05ehrHVBVhtRFahna-r8=2_OpQW7ruUq+ig@mail.gmail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, imgx64@gmail.com
X-From: git-owner@vger.kernel.org Fri Jul 19 18:26:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0DVn-0005IQ-HN
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 18:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760606Ab3GSQ01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 12:26:27 -0400
Received: from mail-we0-f180.google.com ([74.125.82.180]:52312 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405Ab3GSQ01 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 12:26:27 -0400
Received: by mail-we0-f180.google.com with SMTP id p59so298544wes.25
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=C13VfrQPVucMSPEmjDJz9XWAfhrhT2BRtfSVXCWwmno=;
        b=yHhy1LoWtWGF92semG4UXk6Ao7atMKgJuHMIpBEZvMPTn3AhoSvRr4BnIig1HPQoBW
         l5BDvR9U1HqiQYRKxSsnvpaNBSisOoRT4xDX1c4g6O2G3CIMO+kLlKiL+Jrwyf2lC4ND
         7iUxMti9vurT8mH3M85w4ofCyfxCpgMkgP7ETkAdLXSPrLJPcE10rQgFNAU+RchVevDc
         GrJkj9Hrb9MCmQt/CkOMeBV3LFCB5tVeA49Yymq/UbIdqReShdEfr7st6x56HbHjrTzb
         2uJOjBklmADRxq1/lBh9cz4jnp9N803PCawZrSZdHB4iD7Uc2FEPB9NYam6jG7hPOHGt
         6cyg==
X-Received: by 10.194.157.65 with SMTP id wk1mr12577878wjb.8.1374251185777;
        Fri, 19 Jul 2013 09:26:25 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id i1sm49455474wiz.6.2013.07.19.09.26.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 09:26:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.754.g9c3c367.dirty
In-Reply-To: <CADfnUUKVDmuqt9s05ehrHVBVhtRFahna-r8=2_OpQW7ruUq+ig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230825>

Reported-By: Ibrahim M. Ghazal <imgx64@gmail.com>
Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 Documentation/git-reset.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index a404b47..f445cb3 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git reset' [-q] [<tree-ish>] [--] <paths>...
-'git reset' (--patch | -p) [<tree-sh>] [--] [<paths>...]
+'git reset' (--patch | -p) [<tree-ish>] [--] [<paths>...]
 'git reset' [--soft | --mixed | --hard | --merge | --keep] [-q] [<commit>]
 
 DESCRIPTION
-- 
1.8.3.3.754.g9c3c367.dirty
