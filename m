From: =?UTF-8?q?Mihai=20Capot=C4=83?= <mihai@mihaic.ro>
Subject: [PATCH] Fixed typo in git-pull manual
Date: Wed, 27 Mar 2013 12:04:51 +0100
Message-ID: <d50c433f40ef6d353966b84250c40d9ecd9de51d.1364381294.git.mihai@mihaic.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?UTF-8?q?Mihai=20Capot=C4=83?= <mihai@mihaic.ro>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 27 12:05:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKoAg-00025r-VS
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 12:05:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896Ab3C0LFD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Mar 2013 07:05:03 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:39458 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731Ab3C0LFB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 07:05:01 -0400
Received: by mail-we0-f169.google.com with SMTP id x43so2771673wey.14
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 04:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=/EoESCaczMtKF8QxeHX7e11N6wilv2F7uRw/XAcZxnE=;
        b=ewoqaEd/Ao3cf3M6FDsALMlRxZxOiDqUQkAXTtU+5HqSQFdfvcDToYd5CctXlfbdfs
         BL5TWlCN+SHRVAER/0sE6wa6nFfmbInj76Be7N6j35eehXT6p06czdiQi9iM24D2TmxK
         Kf+DIeocPSSyQyveyF7Od13y9S6iHxQldFdM8ux+fc6ses+KWVlsJqHpjkb/I46nG+l2
         pNt/YktTBXZZkllM+B20g0NV7iPmOlJEZF87IOPQ3vJQ6A/EqeXFvCMyNr+MqKOWnG1Z
         qhnMb36HMEX9HhkkvTrpHs7Yfo0YjWs+aVgP4Ecum185gG0Pu7eYskG7U+8RGaJO+8ha
         GLpA==
X-Received: by 10.180.97.132 with SMTP id ea4mr8818658wib.23.1364382300061;
        Wed, 27 Mar 2013 04:05:00 -0700 (PDT)
Received: from dutier.st.ewi.tudelft.nl (dutier.st.ewi.tudelft.nl. [130.161.159.51])
        by mx.google.com with ESMTPS id q13sm9189284wie.0.2013.03.27.04.04.58
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 27 Mar 2013 04:04:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
X-Gm-Message-State: ALoCoQlWKTygIYm8lnn20ES1MieoDBur5dpQh5xHerVWN3ZvPb55OIpRCY9DDuydtHOT0RxLGLR2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219244>

Signed-off-by: Mihai Capot=C4=83 <mihai@mihaic.ro>
---
 Documentation/git-pull.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index c975743..eec4c1d 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -218,7 +218,7 @@ $ git merge origin/next
 ------------------------------------------------
=20
=20
-If you tried a pull which resulted in a complex conflicts and
+If you tried a pull which resulted in a complex conflict and
 would want to start over, you can recover with 'git reset'.
=20
=20
--=20
1.7.9.5
