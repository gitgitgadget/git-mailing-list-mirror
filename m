From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull git-l10n updates for git v1.7.12-146-g16d26
Date: Thu, 13 Sep 2012 06:41:03 +0800
Message-ID: <CANYiYbExJRAK0zvO4FSce2tOTyW1fLW1OLqZSm0KLjG1V4nTbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 00:41:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBvcQ-0003Zv-6M
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 00:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320Ab2ILWlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 18:41:05 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:58031 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055Ab2ILWlE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 18:41:04 -0400
Received: by ieje11 with SMTP id e11so3840118iej.19
        for <git@vger.kernel.org>; Wed, 12 Sep 2012 15:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=iEXua/B8WoYpbADdVvTHslUTrBL4BJ3edRVvAO8P7nI=;
        b=OHgpqhAvL92awIcwtJUmEeYrGTkeXiaj5oO3u7esIRJkIeVrLcy9qh8xCXUGv143kI
         9Y1zzcuWxxpWXC+WwQPZdZB7V1YB/kD50X6CPWVR97Bki95KGEawLpIbDdtieYo5plAM
         lIEjiJRkT+AFvcm5cfCvBUMbGwAVEqvPmohWgwH0/jkYBiOZSkLH1zDD6sksLa73Ty3P
         CjWfSHKlXdJsUmCeV1PiT8fdPhJlhIldBBJ08Zbu73Z546FI5y1HP48wHao+IsfybY7s
         voASyTEfpSqTNW6tBDIUGIz1heJYmlfawBUAjugoRas581YXpOIwdeBFl6nr+zq9YhWF
         Po6Q==
Received: by 10.50.195.232 with SMTP id ih8mr13452igc.45.1347489663413; Wed,
 12 Sep 2012 15:41:03 -0700 (PDT)
Received: by 10.50.42.230 with HTTP; Wed, 12 Sep 2012 15:41:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205347>

Hi Junio,

The following changes since commit 16d26b168b371b2f4f86b1adb61470c6b08b27b9:

  Latter half of the second batch for 1.8.0 (2012-08-29 15:00:30 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to 9a4f34bb6d11ab47d532f7798ecc2b051f6d8893:

  l10n: Update Swedish translation (1166t0f0u) (2012-09-13 06:33:25 +0800)

----------------------------------------------------------------
Jiang Xin (3):
      l10n: Update git.pot (2 new, 4 removed messages)
      l10n: zh_CN.po: translate 2 new messages
      Merge git://github.com/vnwildman/git

Peter Krefting (1):
      l10n: Update Swedish translation (1166t0f0u)

Ralf Thielow (1):
      l10n: de.po: translate 2 new messages

Tran Ngoc Quan (2):
      l10n: vi.po & TEAMS: review Vietnamese translation
      l10n: vi.po: update to v1.7.12-146-g16d26

 po/TEAMS    |    3 +-
 po/de.po    |  712 ++++++++++++------------
 po/git.pot  |  684 +++++++++++------------
 po/sv.po    |  715 ++++++++++++------------
 po/vi.po    | 1767 +++++++++++++++++++++++++++++++----------------------------
 po/zh_CN.po |  712 ++++++++++++------------
 6 files changed, 2394 insertions(+), 2199 deletions(-)


-- 
Jiang Xin
