From: Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH 2/2] .mailmap: Add Stefan Bellers corporate mail address
Date: Mon, 20 Oct 2014 18:50:45 -0700
Message-ID: <1413856245-5443-2-git-send-email-stefanbeller@gmail.com>
References: <1413856245-5443-1-git-send-email-stefanbeller@gmail.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 21 03:51:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgObL-00047F-IM
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 03:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbaJUBuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 21:50:55 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:50138 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbaJUBuw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 21:50:52 -0400
Received: by mail-pd0-f169.google.com with SMTP id w10so274264pde.14
        for <git@vger.kernel.org>; Mon, 20 Oct 2014 18:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r3C3V3FvukkKalja2B9gxvHz3Uj90jrplIeqPywebMI=;
        b=peLqrgm4Ojhs7X6HIzZ17YUjU6jNiMK/kUHmc9bL4qiinG4kcDDNtCocWd7h3ztZQZ
         AtVqzcFNtvGfkBc8LrIdN4wPLtIeehl+4nlg7V2BAdp2aQCcBI3OGecGlwz/mwfk6mJG
         zo9bXDX7cf1EIf5Cml1KFVS++plv7OOAL71WiLqAiFVusKLEscjqVQnwUx8B4XDj3Pah
         h8AEKHsDBKw1FgSmyky3jS34fhAMuH8tMaQvavnYwaPG06eYcyX+a9lbBc0+81kqpUY1
         PoLZn4szALg8dnIo1D+FHtnPd2yq5E2+rMJjJRsBRA/bEJ4nQnhKAEkPsBzhS96xFLCp
         Rd9g==
X-Received: by 10.68.92.66 with SMTP id ck2mr9336830pbb.72.1413856251971;
        Mon, 20 Oct 2014 18:50:51 -0700 (PDT)
Received: from localhost (c-76-102-52-132.hsd1.ca.comcast.net. [76.102.52.132])
        by mx.google.com with ESMTPSA id dl1sm10270791pbc.16.2014.10.20.18.50.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 18:50:51 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.332.g8071e93
In-Reply-To: <1413856245-5443-1-git-send-email-stefanbeller@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Note that despite the private address being first, Google owns the
copyright on this patch as any other patch I'll be sending signed off
by the sbeller@google.com address.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 8aefb5a..bb6f52e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -205,6 +205,7 @@ Shawn O. Pearce <spearce@spearce.org>
 Simon Hausmann <hausmann@kde.org> <simon@lst.de>
 Simon Hausmann <hausmann@kde.org> <shausman@trolltech.com>
 Stefan Beller <stefanbeller@gmail.com> <stefanbeller@googlemail.com>
+Stefan Beller <stefanbeller@gmail.com> <sbeller@google.com>
 Stefan Naewe <stefan.naewe@gmail.com> <stefan.naewe@atlas-elektronik.com>
 Stefan Naewe <stefan.naewe@gmail.com> <stefan.naewe@googlemail.com>
 Stefan Sperling <stsp@elego.de> <stsp@stsp.name>
-- 
2.1.2.332.g8071e93
