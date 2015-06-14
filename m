From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] l10n updates for 2.4 maint branch
Date: Sun, 14 Jun 2015 21:56:44 +0800
Message-ID: <CANYiYbGGd_1jFhcFD4=A5QWatsEwrBczPSiXEbJnJ=pHtQTLcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 15:56:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z48P4-0008DJ-E6
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 15:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbbFNN4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 09:56:46 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34227 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbbFNN4p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 09:56:45 -0400
Received: by wicnd19 with SMTP id nd19so3169412wic.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 06:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=kp2atRmWAfJO+A08U5h/yliRsl4yGG0jSwjl/AAFLc8=;
        b=s7vC2jEvsBTs9iowu2BVXuIjzfmjUothFFWheUyTaXsKFowXAbx4fouwKxigUftVrL
         sbX7lY5DdgU2a6hfeCk+Ap3VTx0zxQc4KynFkeAOzMZeGNs6pVMqQVBtqJQu+ByRCMCJ
         Y2m/X0eFSpL0lgWgxyJJcuYJnpsZhXMhm7BfxUUp6142I73d3NdxxzPyOh3bg2QfFWYF
         faX1z2cHZCeN4lDC9dcue7wq/Gb0DZVWY5x9KdZ2Vf7nz+8Mvm2QOSJwHxI86+UgysYx
         JHggd3lAqclXXliz0HYm1f+9T+EEGiKWPt9cxV/ACPXtnicOlesaxJFTO78RSWJzHtks
         R28A==
X-Received: by 10.180.100.74 with SMTP id ew10mr23941908wib.12.1434290204229;
 Sun, 14 Jun 2015 06:56:44 -0700 (PDT)
Received: by 10.194.123.7 with HTTP; Sun, 14 Jun 2015 06:56:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271639>

The following changes since commit 9eabf5b536662000f79978c4d1b6e4eff5c8d785:

  Git 2.4.2 (2015-05-26 13:49:59 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.4-maint-de-updates

for you to fetch changes up to a9845c5f504498644abcb5f6fd6adc2ffd076f2b:

  l10n: de.po: translation fix for fall-back to 3way merge (2015-06-12
20:40:04 +0200)

----------------------------------------------------------------
l10n-2.4-maint-de-updates

----------------------------------------------------------------
Michael J Gruber (3):
      l10n: de.po: grammar fix
      l10n: de.po: punctuation fixes
      l10n: de.po: translation fix for fall-back to 3way merge

Phillip Sz (1):
      l10n: de.po: change error message from "sagen" to "Meinten Sie"

 po/de.po | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--
Jiang Xin
