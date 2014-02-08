From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] l10n updates for 1.9.0 round 2
Date: Sat, 8 Feb 2014 08:01:22 +0800
Message-ID: <CANYiYbGV7aPd300Bwkm9yWAZR-crtk8Jk2TCckuGvkmrQGe+rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Alexander Shopov <ash@kambanaria.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?ISO-8859-1?Q?Jean=2DNo=EBl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 08 01:01:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBvMP-0007Yy-PL
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 01:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbaBHABY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 19:01:24 -0500
Received: from mail-we0-f169.google.com ([74.125.82.169]:46503 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbaBHABX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 19:01:23 -0500
Received: by mail-we0-f169.google.com with SMTP id t61so2814464wes.14
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 16:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=yArnyECXG+EYNC9911uqFFNPLyE0o1F4BnH3Xw0Acwg=;
        b=sSvRFuhzP1kKwHJIw5IriVbNmMS8QSJco7F8N2ygGd6ErtC7wwHE42+FgTAnImJPLr
         3Jdt0+G1w/PIEytJtiJtBj6/0rQQpClN3Yc9fVvKCO1z2JfqvsO6qGUMZdItQ6Br2e8z
         1CYY1G8K9xFOfxiqpAnZtF9kOFpHzIqjMLzZHkn0067HOfr8nf8i0IWwBtNRnIU6K+QA
         lvyL+TSVrol6F+CG5330tPpa8tznIqFHUr0zYwENgInFcXfkD7KjnxojM4dw3UaRhFyi
         7bfmjnJIuzhAI7W5rBiZvpe9ihnIqwMe1lQpZUfHDZfGiYNmAOpI4IuLQfMuyGxD1ku7
         hZEQ==
X-Received: by 10.180.91.164 with SMTP id cf4mr1761903wib.37.1391817682839;
 Fri, 07 Feb 2014 16:01:22 -0800 (PST)
Received: by 10.194.71.162 with HTTP; Fri, 7 Feb 2014 16:01:22 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241816>

2014-02-08 Junio C Hamano <gitster@pobox.com>:
> A release candidate Git v1.9.0-rc3 is now available for testing
> at the usual places.  Hopefully this will be the last one before the
> final, scheduled to happen sometime late next week.
>

The following changes since commit be961c292f1d36097afa1690df68cf90f655c855:

  Git 1.9-rc2 (2014-01-31 14:16:06 -0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to 98b2761d5efaf559d67e7ed5694f3a2bddf3e868:

  l10n: zh_CN.po: Disambiguation for rebase (2014-02-06 23:15:33 +0800)

----------------------------------------------------------------
Jean-Noel Avila (1):
      l10n: fr: 1.9rc2 2211t

Jiang Xin (5):
      l10n: git.pot: v1.9 round 2 (1 new)
      Merge branch 'master' of git://github.com/vnwildman/git
      Merge branch 'master' of git://github.com/nafmo/git-l10n-sv
      l10n: zh_CN.po: translate 1 new message (2211t0f0u)
      l10n: zh_CN.po: Disambiguation for rebase

Peter Krefting (1):
      l10n: Update Swedish translation (2211t0f0u)

Tran Ngoc Quan (1):
      l10n: vi.po (2211t): Updated one new string

 po/fr.po    |  58 ++++++++++++++++------------
 po/git.pot  |  29 ++++++++------
 po/sv.po    |  31 ++++++++-------
 po/vi.po    | 123 ++++++++++++++++++++++++++++++------------------------------
 po/zh_CN.po |  63 +++++++++++++++++--------------
 5 files changed, 165 insertions(+), 139 deletions(-)


-- 
Jiang Xin
