From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] l10n updates for 2.3.0
Date: Thu, 22 Jan 2015 23:21:28 +0800
Message-ID: <CANYiYbFJfx1Sc+ync-Np11qBV6Zb3_mZFPaiQw5EwVa=3TG73g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 16:21:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEJZe-0004ty-F5
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 16:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbbAVPVa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jan 2015 10:21:30 -0500
Received: from mail-wg0-f52.google.com ([74.125.82.52]:46111 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbbAVPV3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2015 10:21:29 -0500
Received: by mail-wg0-f52.google.com with SMTP id y19so2316258wgg.11
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 07:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4F//nyRsWllAldhDJXCyFFRGk1euvvDnOyWQBMlQ8xQ=;
        b=kYE7Q3DOxn72sPtR/khmJoMyWlRe5Fh9A91m7T9SAsjUhjH9uNByy/2DRmhXe4kqQS
         RM3dmRLhlElllupjd547+zax/CzmhvOdI+wC39DofcXX/zUU+wmQI8dfsElbA5hhSkY2
         Rx82IpbGxclO0rOQpukWELmPiKpA9mKJAfNUc9RPH38rJ3o9M504vOlBfW/Tkckf3rwh
         UXKKvgG1sXzPX7frjvN4nQvDt9tJKux9KYY2vMG6Q8bZs/KSGFdjzKBaN8XPmY4tHuQu
         jl4XBCuRFvE/BA6Xjb8czakMCx09NujxUM2Cb5X9jZbOe+PpjscOrgjbOESHrDeWbzU+
         YzFw==
X-Received: by 10.194.236.1 with SMTP id uq1mr4311460wjc.28.1421940088195;
 Thu, 22 Jan 2015 07:21:28 -0800 (PST)
Received: by 10.194.80.131 with HTTP; Thu, 22 Jan 2015 07:21:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262840>

Hi Junio,

The following changes since commit 627736ca799edacf13881da7e671964a0afb=
94b8:

  Git 2.3.0-rc1 (2015-01-20 17:35:41 -0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to 1e607449135792dd117bd528432fc1fbc1115667=
:

  l10n: correct indentation of show-branch usage (2015-01-21 15:35:37 +=
0800)

----------------------------------------------------------------
(from the branch description for master local branch)

Git l10n for git.git master branch

----------------------------------------------------------------
Jean-Noel Avila (2):
      l10n: fr.po v2.3.0 round 1
      l10n: fr.po v2.3.0 round 2

Jiang Xin (10):
      Merge branch 'master' of git://github.com/alexhenrie/git-po
      l10n: git.pot: v2.3.0 round 1 (13 new, 11 removed)
      l10n: zh_CN: translations for git v2.3.0-rc0
      Merge branch 'master' of git://github.com/git-l10n/git-po
      l10n: git.pot: v2.3.0 round 2 (3 updated)
      Merge branch 'master' of git://github.com/nafmo/git-l10n-sv
      Merge branch 'v2.3.0' of git://github.com/jnavila/git
      l10n: zh_CN: various fixes on command arguments
      Merge branch 'master' of git://github.com/git-l10n/git-po
      l10n: correct indentation of show-branch usage

Joan Perals (1):
      l10n: ca.po: various fixes

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (2298t0f0u)
      l10n: sv.po: Update Swedish translation (2298t0f0u)

Ralf Thielow (4):
      l10n: de.po: translate "track" as "versionieren"
      l10n: de.po: fix typo
      l10n: de.po: translate 13 new messages
      l10n: de.po: translate 3 messages

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (2):
      l10n: vi.po(2298t): Updated and change Plural-Forms
      l10n: vi.po(2298t): Updated 3 new strings

 po/ca.po    | 1617 ++++++++++++++++++++++----------------------
 po/de.po    | 1872 +++++++++++++++++++++++++--------------------------
 po/fr.po    | 1813 +++++++++++++++++++++++++-------------------------
 po/git.pot  | 1771 +++++++++++++++++++++++++------------------------
 po/sv.po    | 1815 +++++++++++++++++++++++++-------------------------
 po/vi.po    | 2139 +++++++++++++++++++++++++++++----------------------=
--------
 po/zh_CN.po | 1902 ++++++++++++++++++++++++++-------------------------=
-
 7 files changed, 6506 insertions(+), 6423 deletions(-)

--
Jiang Xin
