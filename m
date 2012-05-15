From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Please pull git-l10n update for upcoming v1.7.10.3
Date: Wed, 16 May 2012 07:41:24 +0800
Message-ID: <CANYiYbFouOgG5f+U+_vX86mqdUEXGrG7zohKV-znjG38vQT77g@mail.gmail.com>
References: <CANYiYbH1FDcFcbfH4+D8ApnMOPJZjaATu6xosxuct0+9mq8rRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Marco Sousa <marcomsousa@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 16 01:41:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SURN3-0007yZ-Pt
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 01:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967071Ab2EOXl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 19:41:26 -0400
Received: from mail-yw0-f51.google.com ([209.85.213.51]:40070 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967065Ab2EOXlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 19:41:25 -0400
X-Greylist: delayed 958 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 May 2012 19:41:25 EDT
Received: by yhnn12 with SMTP id n12so186508yhn.10
        for <git@vger.kernel.org>; Tue, 15 May 2012 16:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CenZEp0zEt/ueeflvPy71HH1lw8GDKcFQtfQu8RGhWI=;
        b=GY1+rUPxQSyx1ARGG1gVBdAmGVGt2pQnXFppMXqa5kKGvipa4TJrOKGCEkowxhZf4C
         DmL3k0BRxtlNbO3CcmYBM1HMAw+2NLUYHtOgm7TbSafoRAnYl2WgB1l7DU8g8a0nnKau
         +LVrnz8Dq6yRSXRKe+L8J5PRX0qbmID6NRcY/sr1qYtu68lyu+ivVrwddaw+zy08LhEy
         FzQ7nIgnzpTYyQEzfLphJN9XoliFTx7TG+L+FRQUNnwin06IeHQ1aAB8E+0KIYoa6S0o
         SddgKHcq5/PHhwwM6P+aZcltx0eZm/93xxuCHJt+8p/ZEUY/zDIxOtoYovSNGyx5qDxY
         0HkA==
Received: by 10.50.88.201 with SMTP id bi9mr535571igb.27.1337125284874; Tue,
 15 May 2012 16:41:24 -0700 (PDT)
Received: by 10.50.134.102 with HTTP; Tue, 15 May 2012 16:41:24 -0700 (PDT)
In-Reply-To: <CANYiYbH1FDcFcbfH4+D8ApnMOPJZjaATu6xosxuct0+9mq8rRA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197859>

Please also pull the master branch, which contains pt_PT.po translation updates
and merges from the maint branch.

The following changes since commit 6a4a4822298866ec3386a46d9d8f933b80e3a359:

  Update draft release notes for 12th batch (2012-05-14 12:20:46 -0700)

are available in the git repository at:

  https://github.com/git-l10n/git-po/ master

for you to fetch changes up to 154ca11d4b6b17fd03d0f70cb71e437708753261:

  Merge branch 'maint' into master (2012-05-16 07:32:20 +0800)

----------------------------------------------------------------

Jiang Xin (6):
      l10n: Update git.pot (3 new, 2 removed messages)
      Merge branch 'maint'
      l10n: Update git.pot (8 new, 4 removed messages)
      Merge branch 'master' of git://github.com/marcomsousa/git-l10n-pt_PT
      l10n: zh_CN.po: translate 3 new messages
      Merge branch 'maint' into master

Marco Sousa (1):
      l10n: pt_PT.po translate new messages

Ralf Thielow (1):
      l10n: de.po: translate 3 new messages

 po/de.po    |  138 ++--
 po/git.pot  |  472 ++++++-----
 po/pt_PT.po | 2625 +++++++++++++++++++++++++++++++++++++++++++++--------------
 po/zh_CN.po |  108 +--
 4 files changed, 2367 insertions(+), 976 deletions(-)

-- 
Jiang Xin
