From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] l10n updates for 2.0.0 round 1
Date: Wed, 30 Apr 2014 09:12:33 +0800
Message-ID: <CANYiYbG_DYkesMiMpQETdF_ors_90H6pDCsxKSySpi8+FcFxHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Alexander Shopov <ash@kambanaria.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 03:12:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfJ4g-00009a-Tj
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 03:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452AbaD3BMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 21:12:35 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:42451 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754253AbaD3BMe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 21:12:34 -0400
Received: by mail-we0-f173.google.com with SMTP id w61so981269wes.4
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 18:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=Sb0Kx4FNS4DlXyrQ4shAELbNum2HJJcjiUTmnjAdY5s=;
        b=gATEUw5BNhGkd48lBUNfWpJ3pEZ41hhk6kGH4rVbAY2kyVX2XmqHpWnTpvXid2gDly
         3dc/jvXhKN7MvIRNsPPfPnlarb5TsS6Z97J4i7r9scGYahBJQP9lCddM/QYCGg2ihbH1
         Rfo9bPEDyLpOmYor8eguTjlvGo2guRZuZs0xB2lFb+V0faGwhyJbsffKpdsqBvt6kqAM
         qV7itBsnnfi0s+vszP1cd88wmqPrEVwDSXgfHQwzhQN3c1xiw+Boj2UpDnOWdmfLEDqi
         +AOY3AfzIWk06sJ4H7KaUHQWAqfmlWy0vlZLErusRrB6TfrGN2Kx/5GPiMyDNoe+1rbK
         zwCw==
X-Received: by 10.180.77.8 with SMTP id o8mr893272wiw.23.1398820353246; Tue,
 29 Apr 2014 18:12:33 -0700 (PDT)
Received: by 10.217.57.202 with HTTP; Tue, 29 Apr 2014 18:12:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247671>

Hi Junio,

The following changes since commit cc291953df19aa4a97bee3590e708dc1fc557500:

  Git 2.0-rc0 (2014-04-18 11:21:43 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po

for you to fetch changes up to 94f94fcbf2b1009da358fbe06edffbd206d9fa7a:

  l10n: de.po: improve hint for autocorrected command execution
(2014-04-29 06:12:31 +0200)

----------------------------------------------------------------
Jean-Noel Avila (1):
      l10n: fr translation for v2.0.0rc0 (2228t)

Jiang Xin (3):
      l10n: git.pot: v2.0.0 round 1 (45 new, 28 removed)
      Merge branch 'fr-po' of git://github.com/jnavila/git
      l10n: zh_CN.po: translate 46 new messages (2229t0f0u)

Peter Krefting (1):
      l10n: Update Swedish translation (2228t0f0u)

Ralf Thielow (3):
      l10n: de.po: correct translation of "completed" after resolving deltas
      l10n: de.po: translate 45 new messages
      l10n: de.po: improve hint for autocorrected command execution

Tran Ngoc Quan (1):
      l10n: vi.po (2228t): Update and minor fix

 po/de.po    | 2771 +++++++++++++++++++++++++++++----------------------------
 po/fr.po    | 2749 +++++++++++++++++++++++++++++----------------------------
 po/git.pot  | 2527 ++++++++++++++++++++++++++--------------------------
 po/sv.po    | 2710 +++++++++++++++++++++++++++++---------------------------
 po/vi.po    | 2843 ++++++++++++++++++++++++++++++-----------------------------
 po/zh_CN.po | 2705 +++++++++++++++++++++++++++++---------------------------
 6 files changed, 8342 insertions(+), 7963 deletions(-)

--
Jiang Xin
