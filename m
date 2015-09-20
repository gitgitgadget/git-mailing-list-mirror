From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.6.0 round 2
Date: Mon, 21 Sep 2015 01:09:47 +0800
Message-ID: <CANYiYbFTz7Y1qXhYx4xc5Ly-r_MDLOuBCxh1RaUTRYAHtAiDjA@mail.gmail.com>
References: <CANYiYbHB=kNQnfpO5vuOQkZmmZs8V++NQBhER6t21saKC6OMmw@mail.gmail.com>
	<CANYiYbH_gF=T6X_SNWm-vxBrcDFDdfzOHejNKPNoZAAa+KBONA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jean-Noel Avila <jn.avila@free.fr>
X-From: git-owner@vger.kernel.org Sun Sep 20 19:09:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zdi7e-0003Co-HL
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 19:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479AbbITRJt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Sep 2015 13:09:49 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:32874 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbbITRJs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Sep 2015 13:09:48 -0400
Received: by wiclk2 with SMTP id lk2so118294861wic.0
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 10:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=12UaNfO8P8uMtJvmP6k2DSNYYP3C5SaWQRgObG620jo=;
        b=vx+0mRXhD1u5LX+lJTnA1NPzWwpegMdYUUTeCFtwelCdT3uqRAA3e/XlgM4QCM9vFL
         9khV8iPg8LB+b4cdJMgimIM9qTMUTpqXGzZVpxDhNlnHn50oEsDuxuXNB5xCzlwswH9F
         +orD7ifknYNTFSyMkU6LTtebaWP/SoIgRjqaV9snho1JHwCG7gzSPzrWPt/2Td9jVBiz
         X1ol++AmCCSY1e8AZekZjLKlmEbg9S1Hfls/u0+E7lDHhA48B6i+EYqiD9ZGDkgmvtEa
         83lrPPVtkQu6+iEQjkAra4n/We6By/0xCwCQXISwPydCtKoh6EK48Jg6mw7t88cmHTLA
         Prcg==
X-Received: by 10.180.188.211 with SMTP id gc19mr9729775wic.81.1442768987529;
 Sun, 20 Sep 2015 10:09:47 -0700 (PDT)
Received: by 10.194.76.230 with HTTP; Sun, 20 Sep 2015 10:09:47 -0700 (PDT)
In-Reply-To: <CANYiYbH_gF=T6X_SNWm-vxBrcDFDdfzOHejNKPNoZAAa+KBONA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278248>

Hi Junio,

This pull request fixes typo of commit " l10n: fr.po v1.6.0 round 1 ...=
"
(should replace 1.6.0 to 2.6.0), and also includes new updates from
Ralf.  I also create a signed tag (l10n-2.6.0-rnd2+de) for this.

Would you please pull the following git l10n updates.

The following changes since commit f4d9753a89bf04011c00e943d85211906e86=
a0f6:

  Update RelNotes to 2.6 to describe leftover bits since -rc2
(2015-09-14 15:00:41 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.6.0-rnd2+de

for you to fetch changes up to 18a21c195628cfcc2d309015c03139a29eb057d2=
:

  l10n: de.po: better language for one string (2015-09-20 18:49:09 +020=
0)

----------------------------------------------------------------
l10n-2.6.0-rnd2 plus de

----------------------------------------------------------------
Alex Henrie (1):
      l10n: ca.po: update translation

Jean-Noel Avila (2):
      l10n: fr.po v2.6.0 round 1 (2441t)
      l10n: fr.po v2.6.0 round 2 (2440t)

Jiang Xin (9):
      l10n: TEAMS: stash inactive zh_CN team members
      l10n: zh_CN: Add translations for Git glossary
      l10n: git.pot: v2.6.0 round 1 (123 new, 41 removed)
      Merge branch 'master' of github.com:jiangxin/git into master
      l10n: zh_CN: for git v2.6.0 l10n round 1
      Merge branch 'master' of github.com:jiangxin/git
      Merge branch 'master' of git://github.com/git-l10n/git-po
      l10n: git.pot: v2.6.0 round 2 (3 improvements)
      l10n: zh_CN: for git v2.6.0 l10n round 2

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (2441t0f0u)

Phillip Sz (1):
      l10n: de.po: better language for one string

Ralf Thielow (2):
      l10n: de.po: translate 123 new messages
      l10n: de.po: translate 2 messages

Ray Chen (10):
      l10n: zh_CN: Update Translation: "tag object"
      l10n: zh_CN: Unify Translation of "packfile"
      l10n: zh_CN: Update Translation of "tag"
      l10n: zh_CN: Add Surrounding Spaces
      l10n: zh_CN: Update Git Glossary: SHA-1
      l10n: zh_CN: Update Git Glossary: "dumb", "smart"
      l10n: zh_CN: Update Git Glossary: tag
      l10n: zh_CN: Update Git Glossary: fork
      l10n: zh_CN: Update Git Glossary: pickaxe
      l10n: zh_CN: Update Git Glossary: "commit message"

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (2):
      l10n: Updated Vietnamese translation (2441t)
      l10n: Update and review Vietnamese translation (2440t)

 po/TEAMS    |    8 +-
 po/ca.po    | 3949 ++++++++++++++++++++++++++++++---------------------=
----
 po/de.po    | 3776 +++++++++++++++++++++++++++++----------------------=
-
 po/fr.po    | 3746 +++++++++++++++++++++++++++++----------------------=
-
 po/git.pot  | 3547 +++++++++++++++++++++++++++----------------------
 po/sv.po    | 3723 +++++++++++++++++++++++++++++----------------------=
-
 po/vi.po    | 3762 +++++++++++++++++++++++++++++----------------------=
-
 po/zh_CN.po | 4217 +++++++++++++++++++++++++++++++++------------------=
--------
 8 files changed, 15007 insertions(+), 11721 deletions(-)
