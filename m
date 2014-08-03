From: ash@kambanaria.org
Subject: [PATCH] gitk - Bulgarian translation of gitk
Date: Sun,  3 Aug 2014 15:36:42 +0300
Message-ID: <1407069403-8495-1-git-send-email-ash@kambanaria.org>
Cc: paulus@samba.org, Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 03 14:37:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDv27-00056y-3a
	for gcvg-git-2@plane.gmane.org; Sun, 03 Aug 2014 14:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbaHCMgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2014 08:36:53 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:33048 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbaHCMgw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2014 08:36:52 -0400
Received: by mail-we0-f169.google.com with SMTP id u56so6361704wes.0
        for <git@vger.kernel.org>; Sun, 03 Aug 2014 05:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DPeITNqcw74UF/KaLBypn3spicl0QGzrWvu0J693aYA=;
        b=m96hnlQuL7c7wt9dvgg5GhTdq5sq88wrM0OhG28NTyc9DS4JHX507r/ZQxPcPLvX5q
         KERgsHDFjXYjLpP5PdyaE7pPdoH98fBWYfIiAa8twBR+ExDMJw3ALVWboQT4HtMI7sGa
         NdeQik0wWqpaDrlz/HV8qCjFGtJD9/sfTIuVgL1agZO6L7yatuA+V1BdtL9oAjcQSHno
         z3tLR05Tl81IYoxmrbLSsrRM4BdwEsC83Od+gf7KNzxpiQKUoQJlcwxlHaGf81Vz9OBG
         mh6v0fPugGlX2qKz66u8+1PuNu2s3LSDaWhsyoPPBMTVOMJtsKEjvwoqrxaDNpLwpwJ9
         A5mg==
X-Gm-Message-State: ALoCoQle+vhGJBuPteikh7hLOpeDEwQM9RoJ9PpgdLdkm1pB8qTGO7HrjRPTXi+ABlySCnJf6F/5
X-Received: by 10.180.100.133 with SMTP id ey5mr22094962wib.16.1407069411164;
        Sun, 03 Aug 2014 05:36:51 -0700 (PDT)
Received: from dalgonosko.lan (78-83-52-173.spectrumnet.bg. [78.83.52.173])
        by mx.google.com with ESMTPSA id mw4sm3559619wic.20.2014.08.03.05.36.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Aug 2014 05:36:50 -0700 (PDT)
X-Mailer: git-send-email 1.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254724>

From: Alexander Shopov <ash@kambanaria.org>

This is the updated Bulgarian translation of gitk. It has been synced
with git-gui and git.

Alexander Shopov (1):
  gitk: Updated Bulgarian translation (302t,0f,0u)

 po/bg.po | 652 ++++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 329 insertions(+), 323 deletions(-)

-- 
1.9.3
