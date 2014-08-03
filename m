From: ash@kambanaria.org
Subject: [PATCH] Updated Bulgarian translation of git-gui
Date: Sun,  3 Aug 2014 15:29:38 +0300
Message-ID: <1407068979-8301-1-git-send-email-ash@kambanaria.org>
Cc: patthoyts@users.sourceforge.net,
	Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 03 14:30:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDuvL-0004ya-4F
	for gcvg-git-2@plane.gmane.org; Sun, 03 Aug 2014 14:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbaHCM37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2014 08:29:59 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:64414 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbaHCM36 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2014 08:29:58 -0400
Received: by mail-wi0-f180.google.com with SMTP id n3so3586325wiv.7
        for <git@vger.kernel.org>; Sun, 03 Aug 2014 05:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MMnQwWSPFGfHoCuper7l1mydjm45Q3r+jTzxpGyXF5g=;
        b=VMxuKDuxHpYU34RJ+QaD5UeWSza8phGt5oP6szvqvFqMjGqOMqhJJgdTtoFKUehEaS
         WUB54++yiMWz2ciP26vY7Qeg5J7CtHoAdRuDh3LQ/2sQ4fqh1X1kDRyCOwq2OKPapIrR
         GqjBmZqv4/HnbihhdAT+OgGnQW3gUdKIIRUF1TtfIjAhQkSN2qtM79a0KA49YLlzKClH
         MJLACA+hns+ORwMyRvGRk833sBRF5gDMaft62Wu5ay+2Qt7nM6gWwZ+ftzRAE/wNB3li
         mApCbz/8h3vRTcYNjpW6yH1+slke6GFwWMoNopKJajbGU4uhmU7H9G3N4f1jgD/BOEfQ
         GQZQ==
X-Gm-Message-State: ALoCoQln0hnqxBRz7UgIKqwoylIBLyx5OKQ0WOXmB/atsXm7FzJipcdpQt+FmSt8eurHaNKcAeh+
X-Received: by 10.180.187.141 with SMTP id fs13mr22096081wic.57.1407068997294;
        Sun, 03 Aug 2014 05:29:57 -0700 (PDT)
Received: from dalgonosko.lan (78-83-52-173.spectrumnet.bg. [78.83.52.173])
        by mx.google.com with ESMTPSA id l7sm35541621wjx.7.2014.08.03.05.29.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Aug 2014 05:29:56 -0700 (PDT)
X-Mailer: git-send-email 1.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254723>

From: Alexander Shopov <ash@kambanaria.org>

This is the updated Bulgarian translation og git-gui. It has been
synced with git & gitk.

Alexander Shopov (1):
  git-gui i18n: Updated Bulgarian translation (520t,0f,0u)

 po/bg.po | 3572 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 1781 insertions(+), 1791 deletions(-)

-- 
1.9.3
