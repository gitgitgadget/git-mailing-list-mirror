From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] l10n updates for 2.4.0 round 2
Date: Thu, 9 Apr 2015 08:33:32 +0800
Message-ID: <CANYiYbGubDKHgRP7VXLCdsOZ9_zVHDWfZ-QbJbjtApGq=H5Rvw@mail.gmail.com>
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
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 02:33:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yg0Pb-0008FA-7d
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 02:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbbDIAde convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2015 20:33:34 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35849 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681AbbDIAdd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Apr 2015 20:33:33 -0400
Received: by wizk4 with SMTP id k4so74000727wiz.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2015 17:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5vp2nWkVdTKKdFPJJYUv0fDgouOurZnU+ZLdsTAnPbc=;
        b=AJmKyiKkk/oN4CPrvv0y2RTHle1azIc9QLQ6cLbbTHN9kWQ4TARqA7g0Iq7yaz5rYa
         L9TeH+TYOvThn7Fi9yX94BxkhnnwLybm2CHlhahOWxd+AW7o/hGclqCi3/JZuCPJEc47
         yNXwUii7ntZpnzMoW6fLvL+ttNaUZef1DbhVkBdHZPiyl2kSkDuGIh4gmwNan3t6ACl/
         0HfHGYrR3c5sNb07C90IR5TZdVbk3dN09nlPZOe1TyQtwGFz+6aTss8jqehK+j1wM8p+
         jGqur+eMaB+crUQ8PvY8FOu8Xh5V5ZeLEaGLoCFK0rPyRZdUb6GYCDQJfN/AqhgaGy3Q
         yiJw==
X-Received: by 10.180.80.199 with SMTP id t7mr1465286wix.52.1428539612393;
 Wed, 08 Apr 2015 17:33:32 -0700 (PDT)
Received: by 10.194.234.33 with HTTP; Wed, 8 Apr 2015 17:33:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266978>

Hi, Junio

The following changes since commit 6ae0d972664134b82a6dd164a01e8adbebea=
ffe3:

  Git 2.4.0-rc1 (2015-04-02 12:46:06 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.4.0-rnd2

for you to fetch changes up to 44cc742a8ca17b9c279be4cc195a93a6ef7a320e=
:

  Merge branch 'master' of git://github.com/alexhenrie/git-po
(2015-04-09 08:21:39 +0800)

----------------------------------------------------------------
git l10n 2.4.0-rnd2

----------------------------------------------------------------
Alex Henrie (2):
      l10n: ca.po: update translation
      l10n: ca.po: update translation

Alexander Shopov (1):
      l10n: Updated Bulgarian translation of git (2305t,0f,0u)

Dimitriy Ryazantcev (3):
      l10n: ru: added Russian translation
      l10n: ru: updated Russian translation
      l10n: ru: updated Russian translation

Jean-Noel Avila (2):
      l10n: fr.po v2.4.0-rc0 round 1
      l10n: fr.po v2.4.0 round 2

Jiang Xin (10):
      Merge branch 'russian-l10n' of https://github.com/DJm00n/git-po-r=
u
      l10n: git.pot: v2.4.0 round 1 (99 new, 92 removed)
      Merge branch 'maint'
      Merge branch 'fr-v2.4.0-rc0' of git://github.com/jnavila/git
      l10n: zh_CN: translations for git v2.4.0-rc0
      Merge branch 'master' of git://github.com/git-l10n/git-po
      l10n: git.pot: v2.4.0 round 2 (1 update)
      l10n: zh_CN: for git v2.4.0 l10n round 2
      l10n: TEAMS: Change repository URL of zh_CN
      Merge branch 'master' of git://github.com/alexhenrie/git-po

Matthias R=C3=BCster (1):
      l10n: de.po: translate 'symbolic link' as 'symbolische Verkn=C3=BC=
pfung'

Michael J Gruber (1):
      l10n: de.po: fix negation for commit -a with paths

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (2305t0f0u)
      l10n: sv.po: Update Swedish translation (2305t0f0u)

Phillip Sz (1):
      l10n: de.po: add space before ellipsis

Ralf Thielow (3):
      l10n: de.po: fix messages with abbreviated hashs
      l10n: de.po: translate 99 new messages
      l10n: de.po: translate one message

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (2):
      l10n: vi.po: Updated Vietnamese translation
      l10n: vi.po(2305t): Updated 1 new string

 po/TEAMS    |     7 +-
 po/bg.po    |  2892 ++++++++--------
 po/ca.po    |  1877 ++++++-----
 po/de.po    |  1895 ++++++-----
 po/fr.po    |  1880 ++++++-----
 po/git.pot  |  1659 ++++-----
 po/ru.po    | 10633 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 po/sv.po    |  1850 +++++-----
 po/vi.po    |  1897 ++++++-----
 po/zh_CN.po |  2212 ++++++------
 10 files changed, 18704 insertions(+), 8098 deletions(-)
 create mode 100644 po/ru.po

--
Jiang Xin
