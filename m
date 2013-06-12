From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH 0/3] Switch German translation from pure German to German+English
Date: Wed, 12 Jun 2013 19:15:28 +0200
Message-ID: <1371057331-3917-1-git-send-email-ralf.thielow@gmail.com>
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Wed Jun 12 19:16:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umoee-0004jy-R6
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 19:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757693Ab3FLRQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 13:16:12 -0400
Received: from mail-bk0-f45.google.com ([209.85.214.45]:55235 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756612Ab3FLRQL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 13:16:11 -0400
Received: by mail-bk0-f45.google.com with SMTP id je9so3171219bkc.4
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=9wDrmy0KWBKY8qNmjW6uUE8Ii2uocFmkLirHaZuRoPY=;
        b=K4/sFCKSqVtMN8q8/hf/PmfTqlhUV37CfGO5G/+s86oXBkIaptlf8MAKL3mUCzpsfL
         im+FESo+TRmLUX1VoMbFO3Nm7yHU4fhd2h/F7vCun3uyq4PlFmMnkSnIfO3P2H2PJ1aE
         FZjk5ZzXDQLOgcgIJqjuzNHTxQgIaJcyWyaffzX3dLSa8DH6YiRgJxKgWdb6F+fIn2GY
         keeRlrZt9xZ9k1/fHNhKl1OMMLRXqlZQnGY+C7ZDg60/i2+wiRvT7P+Gxm86Ak8nj8ZJ
         MsaaNmWm8qGpIihaAj0CmBRgTPyHqVlEAv4Xeb6eZ/HGdGYt3ziCXibbt3Gz4syFdMJI
         4+AA==
X-Received: by 10.204.175.198 with SMTP id bb6mr3339965bkb.9.1371057370117;
        Wed, 12 Jun 2013 10:16:10 -0700 (PDT)
Received: from localhost (dslb-178-005-125-192.pools.arcor-ip.net. [178.5.125.192])
        by mx.google.com with ESMTPSA id v6sm8161969bko.3.2013.06.12.10.16.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Jun 2013 10:16:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1228.g75fb170
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227654>

Hi,

sorry for being slow. Here's the attempt to change the German translation
from pure German to German+English. Because of the big changes in de.po,
I have splitted one big commit into these three parts and will squash
them after the review.

Thanks for reading and comments.

Ralf

Ralf Thielow (3):
  l10n: de.po: switch from pure German to German+English (part 1)
  l10n: de.po: switch from pure German to German+English (part 2)
  l10n: de.po: switch from pure German to German+English (part 3)

 po/de.po | 1794 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 891 insertions(+), 903 deletions(-)

-- 
1.8.2.1228.g75fb170
