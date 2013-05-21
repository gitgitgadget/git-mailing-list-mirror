From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] remote-hg: fix configuration notes
Date: Mon, 20 May 2013 22:47:51 -0500
Message-ID: <1369108073-29275-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 21 05:49:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UedZt-0000jC-VB
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 05:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968Ab3EUDt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 23:49:29 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:49056 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262Ab3EUDt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 23:49:29 -0400
Received: by mail-oa0-f54.google.com with SMTP id o17so205236oag.41
        for <git@vger.kernel.org>; Mon, 20 May 2013 20:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=YqaspR6EqOJUEK5vIEwP6fhn9/dewgavNcRiXvDK7e4=;
        b=dYsjQyvEbc7SeFZBdFP1oIqTCsPyrCu14UwWZwAm/GEjFtEZRlG8mnPNUs0CqbfWNH
         e7O9p4IX76Lm+oGIy/yf3RLM5D3jcdwuSrmFj2ushfVpuJ2z+9GOFbugzDtt3JHrEJWW
         ck1QFncf15EZMs0tizvY12GWy0E6nRpJ23/QZTrBe7VvAOzc9JmL2eBRB2M7jKOKSQ4w
         DyKtqU4DJOxTFq0Z8kTfpaTczhMYaOCbxNDLYaZDxVTC+R4aoK/v4ZhD8XBRhLroNurk
         LQGFEtt39sEUmGf4BeEkukXp17zgZMS6Hv7/5ueg4Rlsc6fZlBRE4TnQ63+zfKpGRx9x
         vMiw==
X-Received: by 10.182.44.227 with SMTP id h3mr312943obm.16.1369108168534;
        Mon, 20 May 2013 20:49:28 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jt9sm975270obc.0.2013.05.20.20.49.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 20 May 2013 20:49:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.1.gf11a2b7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225014>

Hi,

For 'master'.

Felipe Contreras (2):
  remote-hg: trivial configuration note cleanup
  remote-hg: fix order of configuration comments

 contrib/remote-helpers/git-remote-hg | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
1.8.3.rc3.1.gf11a2b7.dirty
