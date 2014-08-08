From: Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH] Resending - Updated Bulgarian translation of git-gui
Date: Fri,  8 Aug 2014 08:23:28 +0300
Message-ID: <1407475409-3477-1-git-send-email-ash@kambanaria.org>
Cc: patthoyts@users.sourceforge.net,
	Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 07:23:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFceY-0005PH-1r
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 07:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbaHHFXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 01:23:42 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:44400 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbaHHFXl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 01:23:41 -0400
Received: by mail-wg0-f50.google.com with SMTP id n12so4941425wgh.21
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 22:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O2kLTbQKLSETOg4mAz9D921xPswg0MnJnjZKDWPb1Io=;
        b=kBuMt+7QMO7YJ/feFDNp2klVTs/tZcRHaNwHf7yxwENGHu3URPikejdUqXW+BIVIJl
         yE3vMfDPBk0cS8a83yKfOPaEBfhHYJ8g+8YKnzG49MjLMF3wvtnAQnTsP1oj2sepHeiE
         a6XnKUBqmduHx4D0B7NAwVCt35/TWMZuK3MYzfe3lrwhl2i/r8c8JmT2qj1SXz2QQW+K
         X6Ys2YV4xLUkV/rhWBKtTHRCTnKKMILOROWKy/ixlDbQ4gvzXC1LyK6uZb0DceUt9tqJ
         UGa655yT/qFTJYNmm1ADbBQYtAJeo23cwucyeVyTWfwIDoaycjg8LSf2emrdPJ603T8W
         tbnw==
X-Gm-Message-State: ALoCoQn5nRhB2WI/GHgct3Ytr/TnHnMeUO8CtAIdKwMXXumG/vW20zb7v4WtwyyB/GQSOtDQ+7yW
X-Received: by 10.180.75.17 with SMTP id y17mr1479437wiv.3.1407475420331;
        Thu, 07 Aug 2014 22:23:40 -0700 (PDT)
Received: from dalgonosko.localdomain (78-83-52-173.spectrumnet.bg. [78.83.52.173])
        by mx.google.com with ESMTPSA id q2sm3495875wia.19.2014.08.07.22.23.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Aug 2014 22:23:39 -0700 (PDT)
X-Mailer: git-send-email 1.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255003>

This is the updated Bulgarian translation og git-gui. It has been
synced with git & gitk.

I have just checked the archives of the mailing list - the patch was
never sent, just the previous version of the cover letter. Resending
so that it can be merged for 2.1.

Kind regards:
al_shopov

Alexander Shopov (1):
  git-gui i18n: Updated Bulgarian translation (520t,0f,0u)

 po/bg.po | 3572 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 1781 insertions(+), 1791 deletions(-)

-- 
1.9.3
