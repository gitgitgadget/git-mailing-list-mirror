From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH 08/10] Docs: git tag: Remove superfluous 'with'
Date: Mon, 28 Mar 2011 14:59:32 +0000
Message-ID: <1301327622-8595-9-git-send-email-mfwitten@gmail.com>
References: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 17:55:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Emc-0004Wa-5l
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 17:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734Ab1C1PzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 11:55:00 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49622 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207Ab1C1Py6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 11:54:58 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1202218eyx.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 08:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:message-id:x-mailer
         :in-reply-to:references:date;
        bh=O7ArLQErIgMnouvoqS97neQJZqzK4tvXs/t4TUGo/bc=;
        b=ToAl7u8pPriq+P6h7YjmLsSUWE2tnp7M0iJjae6Pz6L4JYCP+qm5bC6u9g88tWJSB5
         bKWY8aX4F66izmABk5FUma94p+KJhDsfwC0afiTtV2HC86uRe8ge1xTc+BZaFtZg5t5o
         g8345Cm1F5iEJZ8TDFECZQPxy3gVLx/jIzWmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:message-id:x-mailer:in-reply-to:references:date;
        b=Nn3B+9vPZCA6pLSL77vgKinMcl7iQYGSJPuTdc+RXFqw67S5N/wluaG5zU4Refev4A
         sQthK2NQOH3q3KPOI4cR3UI1Oen+nGcjemOlu+kW5S+zoo46W4oS5Jx28g1S6/Fucceg
         RHroBvCsJI2TQoiOl9D2O2GJxUU22WgTKzOkg=
Received: by 10.213.9.12 with SMTP id j12mr1812536ebj.147.1301327698003;
        Mon, 28 Mar 2011 08:54:58 -0700 (PDT)
Received: from localhost.localdomain ([174.143.243.243])
        by mx.google.com with ESMTPS id v1sm2878807eeh.6.2011.03.28.08.54.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 08:54:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.18.g68fe8
In-Reply-To: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170144>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-tag.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 695a224..0b24c87 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -233,7 +233,7 @@ this case.
 
 It may well be that among networking people, they may want to
 exchange the tags internal to their group, but in that workflow
-they are most likely tracking with each other's progress by
+they are most likely tracking each other's progress by
 having remote-tracking branches.  Again, the heuristic to automatically
 follow such tags is a good thing.
 
-- 
1.7.4.18.g68fe8
