From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull l10n updates for 1.8.4 round 1
Date: Sat, 3 Aug 2013 14:39:24 +0800
Message-ID: <CANYiYbHb7VLuf4PG+CW3aKyt2nyMPuf4AgaZmmc40nX2ggRK8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Byrial Jensen <byrial@vip.cybercity.dk>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 08:39:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5VVF-0006wS-CQ
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 08:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041Ab3HCGj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 02:39:27 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:42489 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928Ab3HCGj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 02:39:26 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so1136265wgg.24
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 23:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=uUPXyB+4m8EOkgx4KzuNfQsMqNi1w1HmPPbBugctKKo=;
        b=HFMFhjR8G+sHuogj6wNCx6mc1N1sZq3UGWMFW//9wM+pjc4vqlzMqP1Upu9jNFqlBe
         l6WUFrmYooh7uGyPy/EGLAmveVqgcCSQ8lP95ksmX+oTrQwSWHzIsdIBnLz4j8qFTMpD
         bIVRHopMRLaJ5CqpR7AQJ5ekMFQWwRrGL+9ELJrf6Hm7bAH1kp1JumNg0FDaNYuyujBW
         Oqsfq92jUOSdL8765ejoJLxEIGs/bBHOvWi4mtXVJP55ao7R4bS6sJdwjqDNFi3o4qBt
         sck6QugXUIhmFyC9uoq3EWWJUtxWdcrIX1MKiMwrEmpmvKrGNw126e61EOCafg2nGn0e
         dbDQ==
X-Received: by 10.180.94.69 with SMTP id da5mr1062136wib.3.1375511964753; Fri,
 02 Aug 2013 23:39:24 -0700 (PDT)
Received: by 10.194.176.129 with HTTP; Fri, 2 Aug 2013 23:39:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231564>

Hi, Junio

Please pull these updates for git l10n.

BTW, Ralf's updates for de.po are still in the review process in this list,
but I want to send this pull request earlier, because I find there are some
new l10n changes (5 new/modified messages) in v1.8.4-rc1. I will start
git 1.8,4 l10n rnd 2 right after gitster closes this pull request.

The following changes since commit c490a6079021a3343ca5b042b37258858fdefbfc:

  Git 1.8.4-rc0 (2013-07-24 19:29:07 -0700)

are available in the git repository at:

  git://github.com/gotgit/git-po

for you to fetch changes up to 2e8451e8602380a8a129f21da6364f3ea879e6a9:

  l10n: zh_CN.po: translate 99 messages (2133t0f0u) (2013-08-03 14:14:07 +0800)

----------------------------------------------------------------
Jiang Xin (2):
      l10n: git.pot: v1.8.4 round 1 (99 new, 46 removed)
      l10n: zh_CN.po: translate 99 messages (2133t0f0u)

Tran Ngoc Quan (1):
      l10n: vi.po (2133t)

 po/git.pot  | 3072 +++++++++++++++++++++++++++++------------------------
 po/vi.po    | 3383 +++++++++++++++++++++++++++++++++--------------------------
 po/zh_CN.po | 3300 ++++++++++++++++++++++++++++++++-------------------------
 3 files changed, 5403 insertions(+), 4352 deletions(-)

--
Jiang Xin
