From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] more mailmap entries
Date: Sun, 14 Jul 2013 12:14:58 +0200
Message-ID: <1373796899-23378-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jul 14 12:15:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyJKw-0008WA-1s
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 12:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129Ab3GNKO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 06:14:58 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:60902 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab3GNKO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 06:14:57 -0400
Received: by mail-wg0-f41.google.com with SMTP id y10so1772199wgg.4
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 03:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=vJ8F/L/ikTwadJNrL0/Jkai+BzhSFwprUAxMd4JfH9c=;
        b=qBC+jaWVbeOaNlGoQxAwrTlBDPSlJajoafZEEb10tuITGkiGqqIuq4MpuuiGxwPJ2z
         C6jYQHeRcAus+iTtQjLY0+9cUtxkBiBpAzf3I7sAyrs3aNbW/Fd3bTLAswACi/my/9QQ
         5wn3izScwLyw4gJitPq++4NPDMiC90fAi5xkoz7Zt04HQdqb3AuiC2gmLnh15DJ+8RQ1
         ryDRDjzmap74prnZIbVHSzEcYLtR5exSaz0dcFtNhqBWhFr4N6hHVPwMdVGhGsgw0aCc
         2MSsy6Ssgm2G+fJVYu5dsbZPx1shqIDZaCCnJnacySzyFc9rmEomPPdqxFz1jGHXvYMl
         4Lpw==
X-Received: by 10.180.94.67 with SMTP id da3mr5995090wib.30.1373796895927;
        Sun, 14 Jul 2013 03:14:55 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id fb9sm13605490wid.2.2013.07.14.03.14.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 03:14:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.804.g0da7a53.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230361>

This patch goes on top of branch sb/mailmap-updates


Stefan Beller (1):
  .mailmap: Combine more (email, name) to individual persons

 .mailmap | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

-- 
1.8.3.2.804.g0da7a53.dirty
