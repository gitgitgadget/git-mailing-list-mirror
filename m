From: Christoph Hoopmann <christophhoopmann@gmail.com>
Subject: [PATCH v2] l10n: de.po: fix typo
Date: Wed,  2 Mar 2016 12:46:26 +0100
Message-ID: <1456919186-5538-1-git-send-email-christophhoopmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 12:46:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab5Ej-0002bs-3V
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 12:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbcCBLqb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2016 06:46:31 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34519 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062AbcCBLqa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 06:46:30 -0500
Received: by mail-wm0-f52.google.com with SMTP id p65so76066018wmp.1
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 03:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xJg985sd5vUL7FygPDnNDdY5fcprWxMcmyr0nshY8Ck=;
        b=YfoHe6cBEBhE4dbAnBZUEXHg/E64jxgh32RCeVC1/WK2auIsaRlvkw/SqtwSJAB+fm
         PwOEKmZRtCepfwjFqHgSXqWnMDcQvlCkXS23IhKcOa2ZavQts0ypRFMeYodAwS6AJFB2
         jtMZlK+xSIN90ZMZD99XLwu3yfM1xWeqQieTl2obneRFJwM6WV4TDdke065yTKcIYwBq
         l+vJ3qf67GRZirZpnTnu+YTaicH6GzYJSaMEWjTX1TvFxiw5U3fiT53M0Kchy5jMP0BN
         hpxUmq2EhFmKIEQzzYlrQlpFydVjmyu+Dcka9SLAK+hvGHgVAe4j5jIyRQFxpgsABBnS
         OUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xJg985sd5vUL7FygPDnNDdY5fcprWxMcmyr0nshY8Ck=;
        b=gm49KRESYU8IptOmFQXyPUltmPLag/OMGdZpbx1F5qDGgADLkDjnqBQWwOpmytfRFt
         kFCN1zRd46Yh2dP3A4QgCr0jpPMiAU2K0uVngrujbr6nhfyixu2knKTwD/xQc+HilMbp
         2eBQw77NNmzQrA5ELE5z0J6mTSp77R8T0/0Opr4GSfyga2oxBKwlnGj8jwrf9A6MRj17
         K3r01nt+Srw2rYOZMXPZe0YrYo40v5E7hIOFfQO4cNyqm6KCp2sylKTiz/YeZMmATvtm
         trqcC8xKd7bug19KEj2jztwc+YAS/cPXSI01PAKXSQavR/5RKm/yGufeJ1vl/PhEsi+p
         gtlA==
X-Gm-Message-State: AD7BkJLim/M94c498e1XPhxFVtRnAzIkH0y1ARNGXPR7usD9B5OvYFFs2zTQ0EYIxAiZJw==
X-Received: by 10.28.104.87 with SMTP id d84mr4500984wmc.56.1456919189420;
        Wed, 02 Mar 2016 03:46:29 -0800 (PST)
Received: from arch-w530.0pointer.org (ip-178-203-206-218.hsi10.unitymediagroup.de. [178.203.206.218])
        by smtp.gmail.com with ESMTPSA id a128sm3814429wmh.6.2016.03.02.03.46.28
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Mar 2016 03:46:28 -0800 (PST)
X-Mailer: git-send-email 2.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288123>

Signed-off-by: Christoph Hoopmann <christophhoopmann@gmail.com>
---

Changes since v1:
 * Imperative in commit subject
 * "Signed-off-by"-line inserted
---
 po/de.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index 8c5f05d..a6b7bf3 100644
--- a/po/de.po
+++ b/po/de.po
@@ -12079,7 +12079,7 @@ msgid ""
 "option."
 msgstr ""
 "oder Sie sich unsicher sind, was das bedeutet, w=C3=A4hlen Sie einen =
anderen "
-"Namenmit der Option '--name'."
+"Namen mit der Option '--name'."
=20
 #: git-submodule.sh:347
 #, sh-format
--=20
2.7.1
