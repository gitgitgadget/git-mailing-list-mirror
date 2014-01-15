From: al_shopov@yahoo.com
Subject: [PATCH] Bulgarian translation of gitk
Date: Wed, 15 Jan 2014 13:27:27 +0200
Message-ID: <1389785251-8472-1-git-send-email-lists@kambanaria.org>
Cc: Paul Mackerras <paulus@samba.org>,
	Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 15 12:27:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3OdK-0002Gt-6G
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 12:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbaAOL1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 06:27:39 -0500
Received: from nm17-vm1.bullet.mail.ir2.yahoo.com ([212.82.96.216]:37356 "EHLO
	nm17-vm1.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750928AbaAOL1i (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jan 2014 06:27:38 -0500
Received: from [212.82.98.63] by nm17.bullet.mail.ir2.yahoo.com with NNFMP; 15 Jan 2014 11:27:36 -0000
Received: from [46.228.39.69] by tm16.bullet.mail.ir2.yahoo.com with NNFMP; 15 Jan 2014 11:27:36 -0000
Received: from [127.0.0.1] by smtp106.mail.ir2.yahoo.com with NNFMP; 15 Jan 2014 11:27:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1389785256; bh=bC3z4OQaHNirXwokttLWfYj6WwtDUs648ohvB1ojZKY=; h=X-Yahoo-Newman-Id:X-Rocket-Received:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:From:To:Cc:Subject:Date:Message-Id:X-Mailer; b=gl6G44W8oD0qWTp+W3lriNms+vQhfeR37jKS8hS9l9+uUSQwwdRfpTsI5h8v+eVERBqR0xcsmJpOPxbU782joeW9WAIKH5uigubeVJuEpKRReqz9gsumwbi/Ajt7kC1ocQV8lRd3wNb4jVjtS4tb2odZj6m4F/GJfFnfL6fMrcY=
X-Yahoo-Newman-Id: 770637.90545.bm@smtp106.mail.ir2.yahoo.com
X-Rocket-Received: from localhost.lan (al_shopov@78.83.52.173 with plain [188.125.69.59])
        by smtp106.mail.ir2.yahoo.com with SMTP; 15 Jan 2014 11:27:36 +0000 UTC
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: kgDNzmwVM1kAJuB0WqFq2xLzF9jAgMTRbDkFZWJ034QuUmT
 4n_XxelerbMThs6ZE2slRTfrXkMykHpUcx7DdY10AdYtrLyrR65hfoA45PYI
 qc0_99Lh7Kc83f.oBEtfGsbMYQtAHQN7vZ3sFKds9fElyJfGxlPrFyzB80ZP
 ZPTuACHRvpQ9woDuWp2YwvVYRpnH1oJ8ymw4oKh_1mG7.Vrw_.6nc88FfDqB
 rP6IITdoElZhNXoCpqXqK0tGUnwBrGY8JAJ9jB4XQ_aq6qQ779jjrW64DoTR
 NVHYwxZKlv2CSdcmHClE.rpGBENHB2swrPqev.4lv8cQue0hBdJ.vGLL3JeO
 _sfQW44D3xYRGQIBIS3oONlB6xaBAMDPWKvHiMK2ADTOppLLsgOo7NW2RcDt
 nbF9BygnIta0fQWZ_PL8s66AhM71G7ix9Yw_0MhOKXhZOLgvekgJDaqMAukw
 g6BlCSQAjWrNoxlcxG2BtoG_zzMa2SAY0Rv10FO3HJUcdsSaDvEVS4LOUyXH
 as2nekjkut_8_iFvbaXYU6NuWKczq723psEqrqa00OGWsOYI-
X-Yahoo-SMTP: yRWQ8BGswBDCUSC0.xLhuVo_zCa4SQ--
X-Mailer: git-send-email 1.8.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240460>

From: Alexander Shopov <ash@kambanaria.org>

This is the Bulgarian translation of gitk. Translation is synced
with git-gui so they have same terms and style.

Alexander Shopov (1):
  gitk i18n: Added Bulgarian translation (304t)

 po/bg.po | 1334 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1334 insertions(+)
 create mode 100644 po/bg.po

-- 
1.8.4.2
