From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v3 0/7] use imperative form for command
Date: Fri,  7 Nov 2014 21:11:13 +0100
Message-ID: <1415391080-26841-1-git-send-email-ralf.thielow@gmail.com>
References: <1411146770-8508-1-git-send-email-ralf.thielow@gmail.com>
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org, phillip.szelat@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 07 21:11:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpsX-0002Ye-Fe
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 21:11:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032AbaKGUL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 15:11:26 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:64532 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbaKGULZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 15:11:25 -0500
Received: by mail-wi0-f174.google.com with SMTP id d1so5656692wiv.13
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 12:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5mjAu7AWfnbLaQRx2FL6Dn2nUJpet0E7ax5sjb/3wiA=;
        b=CI4IczNtQuO0aWLvePVOXKV+8dSuFyuYg1IR9nvyhHY4bsHtsOuOrTP0y5KPj/+ENE
         bW5CKZ75fftFHWTfHjd/c7Yae6B9+oNjwUgXBTrERW5ruUz2DR2g/tiNXj2u2rTUEtU6
         uTN4WwluZb8AbIxSb0VqUFAGl5vo4UGk/WbXpSLbII8/3dM3eYL2dii4fRFISWA3W1z9
         WiX+i5nH9kr8Tzbogz+hM5+uWxS6TTUbst8VQonrp5XfxXhodf+hoioZxkYaMCzdVGA2
         thyB6mqskLo47VNRtl6bSvA+QQvskcqXqaVNytTltESqYIwqEubcBd5OeDHx8gpsSCg1
         t+7Q==
X-Received: by 10.194.89.161 with SMTP id bp1mr20266835wjb.114.1415391084295;
        Fri, 07 Nov 2014 12:11:24 -0800 (PST)
Received: from localhost (dslb-088-073-206-248.088.073.pools.vodafone-ip.de. [88.73.206.248])
        by mx.google.com with ESMTPSA id bf6sm13033862wjb.13.2014.11.07.12.11.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Nov 2014 12:11:23 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc0.232.g8ec773f
In-Reply-To: <1411146770-8508-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 is rebased on top of git-po's master branch.

Thanks for review, Phillip.

Ralf Thielow (7):
  part1: l10n: de.po: use imperative form for command options
  part2: l10n: de.po: use imperative form for command options
  part3: l10n: de.po: use imperative form for command options
  part4: l10n: de.po: use imperative form for command options
  part5: l10n: de.po: use imperative form for command options
  part6: l10n: de.po: use imperative form for command options
  part7: l10n: de.po: use imperative form for command options

 po/de.po | 1146 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 573 insertions(+), 573 deletions(-)

-- 
2.2.0.rc0.232.g8ec773f
