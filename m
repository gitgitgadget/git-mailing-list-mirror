From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull git-l10n updates for git v1.7.12-rc2
Date: Thu, 9 Aug 2012 15:43:18 +0800
Message-ID: <CANYiYbGgpCsuynqTh5UoQ=AWKxGiFG726thzMFqg19Vc9kpi+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@googlemail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Riku <lu.riku@gmail.com>, Zhuang Ya <zhuangya@me.com>,
	Lian Cheng <rhythm.mail@gmail.com>,
	Yichao Yu <yyc1992@gmail.com>,
	ws3389 <willsmith3389@gmail.com>, Thynson <lanxingcan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 09:43:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzNOx-0001xI-M9
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 09:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756075Ab2HIHnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 03:43:21 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46717 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754437Ab2HIHnS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 03:43:18 -0400
Received: by yenl2 with SMTP id l2so128880yen.19
        for <git@vger.kernel.org>; Thu, 09 Aug 2012 00:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=A/C7oK1Fu5ek5XziIYCHvipvcitjO97yyTuHzpZjp/k=;
        b=kUw/Vma3FfCBTcyMphs/1kwUyt98gtcw3whJN5jhDE2ZwpJ+O7R5QsJhC0g0HxPMCf
         WJUZuRMlKmr7WajaouG6Y20b9pDN/Tt6CPRBJ19W4i6FOOsuHsdDavMwIiyV9UPORJ85
         05xci64EUHAUo86Xii5lmmixnrB9la1ZnB/BBZE3ZaeeWOgqqm915wceHEAF6foVW6Uf
         LuMAajUdIMYsia7NiHVZA0IVcls+/wVZuyVJViBXUsTNRmnhNwy4GAs3vbauIfAX2LIr
         e34FOWh3TcR6NjMfC/oqaHdMNrgHO5CL56FZvde+uKuxqbi30qgkAzBAoL+tR6JbbIot
         IxXA==
Received: by 10.42.53.208 with SMTP id o16mr1995251icg.6.1344498198188; Thu,
 09 Aug 2012 00:43:18 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Thu, 9 Aug 2012 00:43:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203153>

Hi Junio,

The following changes since commit bfbf4d477a33be413800f531c3ac0d227f46ab44:

  Merge git://github.com/git-l10n/git-po (2012-08-05 20:51:05 -0700)

are available in the git repository at:


  git://github.com/git-l10n/git-po master

for you to fetch changes up to cc2f50dafe28fda6652e1ab78034aae49b495b08:

  l10n: Update Swedish translation (1168t0f0u) (2012-08-09 06:39:17 +0100)

----------------------------------------------------------------
Jiang Xin (3):
      l10n: Update one message in git.pot
      l10n: zh_CN.po: update one translation
      Merge git://github.com/ralfth/git-po-de

Peter Krefting (1):
      l10n: Update Swedish translation (1168t0f0u)

Ralf Thielow (1):
      l10n: de.po: translate 77 new messages

Tran Ngoc Quan (1):
      l10n: vi.po: update one message

 po/de.po    |  488 +++++++++++++++++++--
 po/git.pot  |   16 +-
 po/sv.po    | 1413 ++++++++++++++++++++++++++++++++++++++---------------------
 po/vi.po    |   20 +-
 po/zh_CN.po |   18 +-
 5 files changed, 1375 insertions(+), 580 deletions(-)

--
Jiang Xin
