From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] l10n updates for 2.1.0 round 1
Date: Sat, 16 Aug 2014 19:05:03 +0800
Message-ID: <CANYiYbGwXujdPg1fQWjvWjzQ41D+v-xA_ty_MqC2FtTRjGRJYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Alexander Shopov <ash@kambanaria.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 13:05:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIbnY-0001rZ-2E
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 13:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbaHPLFH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Aug 2014 07:05:07 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:52974 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbaHPLFG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Aug 2014 07:05:06 -0400
Received: by mail-wi0-f170.google.com with SMTP id f8so1869292wiw.1
        for <git@vger.kernel.org>; Sat, 16 Aug 2014 04:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MpmQWjWEdgkruzF8aJYQpvekyf3YyIfhMTnulHKdt3I=;
        b=0U3zxrtFrbGN4sH8RLU5OHDNBt87uAsLgzhKljjZFvZzRxu9u5r9r1lJikUUl6tg6U
         JAP+ALcpH0+SI0JKjNmgFuazAjDrP8nsc3yeBPSgWGw8rj8B9kvgtyAV4PmIr4xql04Q
         /r1DOSZt8EjGUafe6Hz/fmq4v4+bfg3RDAQj99ny556jC3+KYgUeIBP99+ttDHZpNkJM
         w8s71kyw/mCFywF4nTVG5ed0JKUiBZWSTw+J+ZV+azlUHR9zbYeCJJOmm3tT0b4qiZ4m
         wbUaZnoXU+11CRjfWU/38z8U7Pf9DP92BzWtHwD3M3y2I8z/z0AJj8I2kUH+XnK+vA3a
         SuGQ==
X-Received: by 10.180.20.40 with SMTP id k8mr27856567wie.54.1408187103533;
 Sat, 16 Aug 2014 04:05:03 -0700 (PDT)
Received: by 10.194.58.200 with HTTP; Sat, 16 Aug 2014 04:05:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255322>

I'm sorry this pull request is late for git v2.1.0.  I should send it o=
ut
yesterday night using the network of my new house, but after 2
weeks' business travel and home moving, I'm a bit lazy.

And German translation is still under review, so it is not included
in this pull request.

The following changes since commit 49f1cb93a2f11845cfa2723611a729d3d7f0=
2f0d:

  Git 2.1.0-rc0 (2014-07-27 15:22:22 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po

for you to fetch changes up to f7fbc357f863ecc5323f3fcf2fc9cbf2aa2a8587=
:

  l10n: fr.po (2257t) update for version 2.1.0 (2014-08-07 09:07:18 +02=
00)

----------------------------------------------------------------
Alexander Shopov (3):
      l10n: Updated Bulgarian translation of git (2228t,0f,0u)
      l10n: Updated Bulgarian translation of git (2247t,0f,0u)
      l10n: Updated Bulgarian translation of git (2257t,0f,0u)

Jean-Noel Avila (1):
      l10n: fr.po (2257t) update for version 2.1.0

Jiang Xin (6):
      l10n: git.pot: v2.1.0 round 1 (38 new, 9 removed)
      Merge remote-tracking branch 'sv/nafmo/master'
      Merge commit 'bg/alshopov/master'
      l10n: zh_CN: translations for git v2.1.0-rc0
      Merge branch 'master' of github.com:alshopov/git-po
      Merge remote-tracking branch 'l10n/vi/vnwildman/master'

Peter Krefting (2):
      l10n: Fix more typos in the Swedish translations
      l10n: sv.po: Update Swedish translation (2257t0f0u)

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
      l10n: vi.po (2257t): Update translation

 po/bg.po    | 5134 +++++++++++++++++++++++++++++++++------------------=
--------
 po/fr.po    | 2871 +++++++++++++++++----------------
 po/git.pot  | 2804 ++++++++++++++++----------------
 po/sv.po    | 2871 +++++++++++++++++----------------
 po/vi.po    | 2853 +++++++++++++++++----------------
 po/zh_CN.po | 2822 ++++++++++++++++----------------
 6 files changed, 10320 insertions(+), 9035 deletions(-)
