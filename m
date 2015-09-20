From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] l10n updates for 2.6.0 round 2
Date: Mon, 21 Sep 2015 00:21:19 +0800
Message-ID: <CANYiYbHB=kNQnfpO5vuOQkZmmZs8V++NQBhER6t21saKC6OMmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 20 18:21:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdhMj-0007WL-FP
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 18:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365AbbITQVV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Sep 2015 12:21:21 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35280 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405AbbITQVU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Sep 2015 12:21:20 -0400
Received: by wicge5 with SMTP id ge5so86998096wic.0
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 09:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=114cztqpmrsSVb0AItBmMl4ruPJmdTl5UqRIl9v3V40=;
        b=SxgqY/fbUJhAJribV5yvi6/3ipuMqG3b4p4KSBeiYIvgOwakaUQpEaxjYF0LXVoVyv
         7TbDuhYm9Q8gfyFo0WC0FzIh4DyJs/2IOvCunpnGSX8NeLjZR2xuPqtF3NURiG+Dj1Iv
         N9KsqyTgBr34AX/H7U7kIh0qA6xSzAlrznUUMax2uhw0g20pvnZJmmkOSC5r4YUmms+9
         U+/HQDPU/wb5G3mn8e4XRmX9ATbrBIFneAScbFEjzYepa1RT5yzSPw/XIK+f1MygzANB
         qxCyaVk53H6PADjk9D3FlPDVRzM5MsDZ2PK2TXP6kjw/L835auyNf/6K8wMqKOj0irf5
         M0Qg==
X-Received: by 10.180.86.136 with SMTP id p8mr8629926wiz.52.1442766079170;
 Sun, 20 Sep 2015 09:21:19 -0700 (PDT)
Received: by 10.194.76.230 with HTTP; Sun, 20 Sep 2015 09:21:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278243>

Hi Junio,

Would you please pull the following git l10n updates.

The following changes since commit f4d9753a89bf04011c00e943d85211906e86=
a0f6:

  Update RelNotes to 2.6 to describe leftover bits since -rc2
(2015-09-14 15:00:41 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to 7e4bed9570f518b0d375db1109dcf797b3989cd3=
:

  l10n: Update and review Vietnamese translation (2440t) (2015-09-16
07:06:03 +0700)

----------------------------------------------------------------
Alex Henrie (1):
      l10n: ca.po: update translation

Jean-Noel Avila (2):
      l10n: fr.po v1.6.0 round 1 (2441t)
      l10n: fr.po v2.6.0 round 2 (2440t)

Jiang Xin (10):
      l10n: TEAMS: stash inactive zh_CN team members
      l10n: zh_CN: Add translations for Git glossary
      l10n: git.pot: v2.6.0 round 1 (123 new, 41 removed)
      Merge branch 'master' of github.com:jiangxin/git into master
      l10n: zh_CN: for git v2.6.0 l10n round 1
      Merge branch 'master' of github.com:jiangxin/git
      Merge branch 'fr_v2.6.0-rc0' of git://github.com/jnavila/git
      Merge branch 'master' of git://github.com/git-l10n/git-po
      l10n: git.pot: v2.6.0 round 2 (3 improvements)
      l10n: zh_CN: for git v2.6.0 l10n round 2

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (2441t0f0u)

Ralf Thielow (1):
      l10n: de.po: translate 123 new messages

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
 po/de.po    | 3767 +++++++++++++++++++++++++++++----------------------=
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
 8 files changed, 14999 insertions(+), 11720 deletions(-)

--
Jiang Xin
