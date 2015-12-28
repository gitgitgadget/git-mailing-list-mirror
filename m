From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] l10n updates for Git 2.7.0
Date: Mon, 28 Dec 2015 23:36:27 +0800
Message-ID: <CANYiYbFyWYAGXkwuUCvemWCNnppLNLc3ndhBXYKb2c4N6oiP-g@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Dec 28 16:36:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDZqb-00015z-Pn
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 16:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbbL1Pga convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Dec 2015 10:36:30 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38531 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbbL1Pg2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Dec 2015 10:36:28 -0500
Received: by mail-wm0-f41.google.com with SMTP id l126so272939511wml.1
        for <git@vger.kernel.org>; Mon, 28 Dec 2015 07:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HCITJCdkjr9oq6jzm6i2wezBZZDNe5zUnOHI1chRUKY=;
        b=mhxtnQ2kfNln4RDxIpqW7rr4MAqQ9cAnj/ETDanHZNtUGvPRvNLQzUMlrNZz6qg00c
         tQV1+0qcobssHXSh9Z4SoVUNnn21nUF4HL0JPUlNCeOiMdR1EqPntUOpJ8cKsEZq0xM6
         Zy2FjEkGj26PyXPKZUFFluwVSluJHHTCRjr0iZ3qVOffCtNH6nDOVQhciUe86Q2vG9AT
         WE+yCxLrpf9ZnadVNwj9/523oxmr2Z7YkyoDKJL3/CfJC1paDKhZMQszq47VJBNU8qV+
         4u9WVAymkOeH5hD/17FxW1+P59bC5FXBNNwhrJsRaY+3qhC16sPlfrvahpGL80goOtyo
         lZeQ==
X-Received: by 10.28.21.19 with SMTP id 19mr1725578wmv.43.1451316987513; Mon,
 28 Dec 2015 07:36:27 -0800 (PST)
Received: by 10.194.61.43 with HTTP; Mon, 28 Dec 2015 07:36:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283037>

Hi Junio,

The following changes since commit 1d88dab47aaa32d134b9bfe1cda09f1b5552=
8b24:

  Update release notes to 2.7 (2015-12-21 11:08:20 -0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.7.0-rnd2

for you to fetch changes up to 5fa9ab808033c081b69c54db3cca029f76a23efd=
:

  l10n: ru.po: update Russian translation (2015-12-28 23:16:00 +0800)

----------------------------------------------------------------
l10n-2.7.0-rnd2

----------------------------------------------------------------
Alex Henrie (2):
      l10n: ca.po: update translation
      l10n: ca.po: update translation

Alexander Shopov (2):
      l10n: Updated Bulgarian translation of git (2477t,0f,0u)
      l10n: Updated Bulgarian translation of git (2477t,0f,0u)

Audric Schiltknecht (1):
      l10n: fr.po: Fix typo

Dimitriy Ryazantcev (1):
      l10n: ru.po: update Russian translation

Jean-Noel Avila (2):
      l10n: fr v2.7.0 round 1 (2477t)
      l10n: fr.po v2.7.0 round 2 (2477t)

Jiang Xin (11):
      Merge branch 'master' of git://github.com/git-l10n/git-po
      l10n: git.pot: v2.7.0 round 1 (66 new, 29 removed)
      Merge branch 'master' of git://github.com/alshopov/git-po
      Merge branch 'fr_v2.7.0' of git://github.com/jnavila/git
      Merge branch 'master' of git://github.com/alexhenrie/git-po
      l10n: zh_CN: for git v2.7.0 l10n round 1
      Merge branch 'master' of git://github.com/git-l10n/git-po
      l10n: git.pot: v2.7.0 round 2 (2 new, 2 removed)
      Merge branch 'master' of git://github.com/nafmo/git-l10n-sv
      l10n: zh_CN: for git v2.7.0 l10n round 2
      Merge branch 'master' of git://github.com/alshopov/git-po

Peter Krefting (3):
      l10n: sv.po: Update Swedish translation (2477t0f0u)
      l10n: sv: Fix bad translation
      l10n: sv.po: Update Swedish translation (2477t0f0u)

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
      l10n: vi.po: Updated translation (2477t)

=C3=89lie Bouttier (1):
      l10n: fr.po: Fix typo

 po/bg.po    | 5415 ++++++++++++++++++++++++++++++++-------------------=
--------
 po/ca.po    | 3186 ++++++++++++++++++-----------------
 po/fr.po    | 3223 +++++++++++++++++++----------------
 po/git.pot  | 3106 ++++++++++++++++++----------------
 po/ru.po    | 3155 ++++++++++++++++++----------------
 po/sv.po    | 3221 ++++++++++++++++++-----------------
 po/vi.po    | 3159 ++++++++++++++++++----------------
 po/zh_CN.po | 3199 +++++++++++++++++++----------------
 8 files changed, 14836 insertions(+), 12828 deletions(-)

--
Jiang Xin
