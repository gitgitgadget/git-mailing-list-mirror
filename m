From: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Subject: [PATCH] gitk: Update Russian translation
Date: Mon, 12 Oct 2015 14:10:35 +0300
Message-ID: <1444648236-16316-1-git-send-email-dimitriy.ryazantcev@gmail.com>
Cc: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 13:10:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zlb0F-00010v-Ov
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 13:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbbJLLKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 07:10:47 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:36119 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbbJLLKq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 07:10:46 -0400
Received: by lbcao8 with SMTP id ao8so139502531lbc.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 04:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=J9yHqUFvwGh2bi2P1A+89w9hNct0twDpSIE5G5H7U8c=;
        b=E0PT1Vz2L6TR4tVIxPU5idHUfrzizDuosKQJVYjaM3WK5NpotEJT6cBN9XqdPigdmY
         Qnoi/+vQgbIhgSBmtEesVSdF1nXxVTioloUYRx21vB916vkjLxWZoUnb8x211NdvPqen
         PijAL1Mri37w8HE4bkqq8Q6KMPYI+13pIdG4xNXVl1vqRo5ZbjmeBoK/AvD2wpKkDUXe
         nk+88jZvcM2jDy15T03K7U9XBLrccOdxzdDBqv6HR7nXK+3P45NHDCMI17S6IdsW0BZ+
         T1aHwj5+P/VIPWhtrgkUiJd/Bf/2RokfRBjRWE7lTHiDIXRVenpc0f/dZDdtL9vLr+WS
         wDMg==
X-Received: by 10.112.125.231 with SMTP id mt7mr11890000lbb.87.1444648244776;
        Mon, 12 Oct 2015 04:10:44 -0700 (PDT)
Received: from Prog004.devcubestudio.com (host-46-250-125-121.la.net.ua. [46.250.125.121])
        by smtp.gmail.com with ESMTPSA id g7sm2776895lbs.10.2015.10.12.04.10.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 04:10:44 -0700 (PDT)
X-Mailer: git-send-email 2.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279372>

I updated Russian translation for gitk.
Please feel free to add any sugessions on Git Russian Localization Project: https://www.transifex.com/djm00n/git-po-ru/language/ru/
Patch is against current git://ozlabs.org/~paulus/gitk master branch.

Dimitriy Ryazantcev (1):
  gitk: Update Russian translation

 po/ru.po | 401 +++++++++++++++++++++++++--------------------------------------
 1 file changed, 161 insertions(+), 240 deletions(-)

-- 
2.6.0
