From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] l10n updates for 2.5.0 round 2
Date: Tue, 21 Jul 2015 07:40:33 +0800
Message-ID: <CANYiYbHOg+Xyive7PacvSDR9fzMWQY-S03fF=m69Y15A-jiYTw@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Jul 21 01:40:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHKfp-0008Nm-OD
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 01:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756510AbbGTXkg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jul 2015 19:40:36 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:36188 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756057AbbGTXkf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2015 19:40:35 -0400
Received: by wgbcc4 with SMTP id cc4so49238452wgb.3
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 16:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8q2qYWRFJdWayF299Q025RyE64WLgleyNv/jHjsfoqQ=;
        b=s+GDK+1q5eH0PRxWXra1ZDuyxa0NzbBIZJVZap0BEk0932HY38RKyWp4HBf05St0Y3
         gG0vUQ+UOEEQN/7HAMEzkBU3tWI1QJ5UhEBhlgH+ZqdXj/JGwVq8ImP7rkWIyINrelio
         SutC7cIJso6o9M3BhEU2CeXhwe6jJ+mCKehMxOyHTXdjD/q66TrQX4kcolzRZmAC+Dok
         oJ3qfKuBoXZ0q9mfdpbzk3ThtREaE9ti8LUTt0l5T7glhWTwSOisegfS5Zxa9nQoIO9V
         5jbYj94HA/P6Bk4G5iHGh/95Vb2vcW6ASA7feimfpaQSYo0EyQekmgK4D8/ITVH9X3nW
         nCqA==
X-Received: by 10.194.179.167 with SMTP id dh7mr63548887wjc.15.1437435634002;
 Mon, 20 Jul 2015 16:40:34 -0700 (PDT)
Received: by 10.194.76.230 with HTTP; Mon, 20 Jul 2015 16:40:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274363>

Hi Junio,

The following changes since commit 961abca02c532626df631c851688ec433095=
d93d:

  Merge tag 'l10n-2.5.0-rnd1' of git://github.com/git-l10n/git-po
(2015-07-13 15:37:24 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.5.0-rnd2

for you to fetch changes up to cdab3cacf643b290e423335e8e04b62fbd24b08c=
:

  l10n: ca.po: update translation (2015-07-20 11:54:40 -0600)

----------------------------------------------------------------
l10n-2.5.0-rnd2

----------------------------------------------------------------
Alex Henrie (1):
      l10n: ca.po: update translation

Alexander Shopov (1):
      l10n: Updated Bulgarian translation of git (2359t,0f,0u)

Dimitriy Ryazantcev (1):
      l10n: ru.po: update Russian translation

Jean-Noel Avila (1):
      l10n: fr v2.5.0 round 2 (2359t)

Jiang Xin (5):
      l10n: git.pot: v2.5.0 round 2 (9 new, 5 removed)
      Merge branch 'russian-l10n' of https://github.com/DJm00n/git-po-r=
u
      Merge branch 'fr_v2.5.0-round2' of git://github.com/jnavila/git
      l10n: zh_CN: for git v2.5.0 l10n round 2
      Merge branch 'master' of https://github.com/ralfth/git-po-de

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (2359t0f0u)

Ralf Thielow (1):
      l10n: de.po: translate 9 new messages

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
      l10n: Updated Vietnamese translation (2359t)

 po/bg.po    |  398 +++++-----
 po/ca.po    |  391 ++++-----
 po/de.po    |  440 ++++++-----
 po/fr.po    |  451 ++++++-----
 po/git.pot  |  381 ++++-----
 po/ru.po    | 2531 +++++++++++++++++++++++++++++++++------------------=
--------
 po/sv.po    |  402 +++++-----
 po/vi.po    |  465 ++++++-----
 po/zh_CN.po |  400 +++++-----
 9 files changed, 3179 insertions(+), 2680 deletions(-)

--
Jiang Xin
