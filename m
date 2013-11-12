From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] l10n updates for 1.8.5 round 1
Date: Tue, 12 Nov 2013 15:23:28 +0800
Message-ID: <CANYiYbHjAtgeFAHwq3rOz8CN1CQ_PLFkoMYNA-TGKqjDytc-Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Jean-Noel Avila <jn.avila@free.fr>,
	Jiang Xin <worldhello.net@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	Sebastien Helleu <flashcode@flashtux.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Tran Ngoc Quan <vnwildman@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 08:23:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg8Jy-0007A8-PH
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 08:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541Ab3KLHXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 02:23:31 -0500
Received: from mail-we0-f181.google.com ([74.125.82.181]:40131 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab3KLHXa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 02:23:30 -0500
Received: by mail-we0-f181.google.com with SMTP id w61so2155639wes.26
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 23:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=4QEV1niksUvcrpa0/TFpXt5FyIvx2q/5/tlQCHIsLoU=;
        b=sxyOSg7L2ZfoZYSCI1wy5EbOhTeKLP818krkWrOET8ln+mpBqXMpp2p1W07+pPEhEf
         ULJz8gMplUhOyu/H+DPGafA7zmg0Y0seYG8zRjTIXGb1xkZqriSosUfKtvgn9nRjUI+S
         GtC3D0ezbMHsiGep54mRfhTIyqrEvWJiBmepGSaHEtVr9iAD6LOp9vywsteJg8FC9ChY
         7g4ot87o3vSeCKL5IWPM8/3EuDd20GRZZY8EoUNQ4PhybBOVRRDqpnKcePllIhAS4H7f
         iVgkNA8jXdswPxwXEhuAN8/KdbWzloKH1/gVopSDPBTkKnLsUA80bnMCIwIco8HwwlCI
         4pUg==
X-Received: by 10.180.74.15 with SMTP id p15mr1464460wiv.63.1384241008621;
 Mon, 11 Nov 2013 23:23:28 -0800 (PST)
Received: by 10.216.122.202 with HTTP; Mon, 11 Nov 2013 23:23:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237700>

Hi, Junio

Please pull l10n updates for Git 1.8.5 round 1.

The following changes since commit aa2706463fdeb51d6f9d0e267113b251888cf7f5:

  Update draft release notes to 1.8.5 (2013-11-01 08:14:52 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to 1f6fb7ffc344e59589ac794ce7ae47ae7c2cff42:

  l10n: de.po: improve error message when pushing to unknown upstream
(2013-11-12 06:31:15 +0100)

----------------------------------------------------------------
Jean-Noel Avila (1):
      l10n: fr.po 2194/1294 messages translated

Jiang Xin (3):
      l10n: git.pot: v1.8.5 round 1 (68 new, 9 removed)
      l10n: zh_CN.po: translate 68 messages (2194t0f0u)
      Merge remote-tracking branch 'sv/nafmo/master'

Peter Krefting (1):
      l10n: Update Swedish translation (2194t0f0u)

Ralf Thielow (3):
      po/TEAMS: update Thomas Rast's email address
      l10n: de.po: translate 68 new messages
      l10n: de.po: improve error message when pushing to unknown upstream

Tran Ngoc Quan (1):
      l10n: vi.po (2194t): Update and minor fix

 po/TEAMS    |    2 +-
 po/de.po    | 2716 +++++++++++++++++++++++++++++++-------------------------
 po/fr.po    | 2743 +++++++++++++++++++++++++++++++--------------------------
 po/git.pot  | 2664 ++++++++++++++++++++++++++++++-------------------------
 po/sv.po    | 2716 +++++++++++++++++++++++++++++++-------------------------
 po/vi.po    | 2838 ++++++++++++++++++++++++++++++++---------------------------
 po/zh_CN.po | 2778 +++++++++++++++++++++++++++++++--------------------------
 7 files changed, 9045 insertions(+), 7412 deletions(-)
