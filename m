From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] t3507: Make test executable
Date: Sun, 11 Apr 2010 01:43:46 -0700
Message-ID: <1270975426-17459-1-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 10:44:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0sm1-0005Be-Px
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 10:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341Ab0DKInx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 04:43:53 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:48111 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab0DKInw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 04:43:52 -0400
Received: by yxe1 with SMTP id 1so2047275yxe.33
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 01:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=DWsdmYVLkt/E+t8YtHNcuLQiMmqBlmAetqJ4C0MqqSk=;
        b=eHyleoxenWNUcs/1nSH+edwGKNpjAwTeDE7t84kpa/fRXxkveytYdYZLIUPeZZIFaL
         GEbyaqIfRI/GbT02vrQqZTZc2rkrDuwc85Pu7zmPJWQwZ/WoeyvJizaYx/h65nn+k0g9
         Tb7Rayw7BWB2W6pS9oagwgnvT8MfW5opi/cfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=th0875tSXYWdfxRCgPmXkHVgNBMrb9tsqAmCqa1IABjD03BnHFTfMdTWZjskwbhqmY
         phbNv6Q70jkER4aoDLS1Ne1dBvOcRLUPPWHy0BR0G19Dj+8eX1aBgghPPAKAHEnt2VfW
         /u0NRcmsZ4BNSMoLiU/bbd//YPwNJKw3VCcT8=
Received: by 10.101.58.8 with SMTP id l8mr3970310ank.7.1270975429539;
        Sun, 11 Apr 2010 01:43:49 -0700 (PDT)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 22sm2745237iwn.0.2010.04.11.01.43.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Apr 2010 01:43:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144633>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 t/t3507-cherry-pick-conflict.sh

diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
old mode 100644
new mode 100755
-- 
1.7.1.rc1
