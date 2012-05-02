From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull git-po maint branch
Date: Wed, 2 May 2012 10:44:45 +0800
Message-ID: <CANYiYbGEkeS2_a59PTDTJ2ZvDmsG1e1a+VrsswuZM7a=SgOBOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 02 04:44:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPPYg-0002pL-VQ
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 04:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758409Ab2EBCoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 22:44:46 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38907 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757388Ab2EBCop (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 22:44:45 -0400
Received: by yhmm54 with SMTP id m54so176060yhm.19
        for <git@vger.kernel.org>; Tue, 01 May 2012 19:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=QmjFAK294iGakYH8NPDVS1neHDCb6YO/KjBJLhow1NU=;
        b=dMVAhunGjMs1OTmVQ9dRIuXfuEkhcyHUROcfQ8HFdnDquQ6nDLkV4n0b3+zr54LC2J
         opas6GMH/UWpnv+2lNn+Y2yu1SqoikVCrAT6DrYWTL8H080mmZXEe1280xj2Yv87i59+
         UUyQM0Hm+K9rfyFrLPt2FXrRjNdOZJUsUaV8a3jlHaYw+TubFG/NjYrrwRXYe8KzVt4K
         1wNrRJHCYaOBWE54c+0PdyTtRPcHhDr8ihdkb5D4+cDqklN+rXO2vh4lK4x0cXU4XagF
         P8TcmLp2I9ISnApvFYhjTPAJZQPGWq224aYr1b2U/swkAByKpR79HSXiQfMWNlX8ppW4
         LtuQ==
Received: by 10.50.189.135 with SMTP id gi7mr3477506igc.37.1335926685107; Tue,
 01 May 2012 19:44:45 -0700 (PDT)
Received: by 10.50.207.40 with HTTP; Tue, 1 May 2012 19:44:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196778>

Hi, Junio

The following changes since commit 868d662399786462f87df45c3d68bd5390311a6e:

  Start preparing for 1.7.10.1 (2012-04-26 10:53:55 -0700)

are available in the git repository at:

  https://github.com/git-l10n/git-po/ maint

for you to fetch changes up to 720e309bf6a5d46e1a6d5ee929d24869a329b838:

  l10n: Initial German translation (2012-05-01 16:28:58 +0200)

----------------------------------------------------------------
Byrial Jensen (2):
      l10n: New da.po file with 0 translations
      l10n: Add Danish team (da) to list of teams

Jiang Xin (3):
      Merge maint branch for tracking l10n updates of git stable version
      l10n: Update git.pot (2 new messages)
      l10n: Update Simplified Chinese translation

Marco Sousa (1):
      l10n: Updated pt_PT language

Ralf Thielow (2):
      l10n: Add the German translation team and initialize de.po
      l10n: Initial German translation

 po/TEAMS    |    8 +
 po/da.po    | 3503 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 po/de.po    | 3771 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 po/git.pot  |  179 +--
 po/pt_PT.po |  242 ++--
 po/zh_CN.po |  184 +--
 6 files changed, 7605 insertions(+), 282 deletions(-)
 create mode 100644 po/da.po
 create mode 100644 po/de.po
