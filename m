From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull git-l10n update
Date: Tue, 27 Mar 2012 17:46:25 +0800
Message-ID: <CANYiYbGUaKzg1KjjK_oAQgnDQg31uuvx65JyyK5p8dExfvk9JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 11:46:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCSz1-0006Hw-KI
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 11:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757917Ab2C0Jq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 05:46:27 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48779 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757802Ab2C0Jq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 05:46:26 -0400
Received: by vcqp1 with SMTP id p1so5008542vcq.19
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 02:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=iut604/y3tX8ncylsj12/yXFftrYj5A4re39uBJwQqQ=;
        b=mmWtWr56Sm4C/EIGEjp9Cz7MHJEUuL9rH8tV4W4/vWtHprdM01TVBJqOzhIDAkQi6V
         HyCBeo2yok2pvLzkd97dDwCsMD4oPIbPwKrpkbF5aMvpmNPDPPyROzaHkFcD4O1nMGVG
         +DH+/0328Qe44kCHdrqXPBUPVMmi5LiE6khz+QyOciBnIJjqBoCPftIF+h3IjHTVuQe3
         yMvkgvzA1jblx/aECPbo19YBY18H21IMuoERXz18djOdQ4wuArf8FelV2waP7DtXaRTP
         fuRLrzKFQL3FMn1k9a/WveM2fgiV4Feolvv2d7x9eVbLnS3lIGuNfeCVwHb2P0eVI8Vj
         n4Mg==
Received: by 10.52.179.165 with SMTP id dh5mr9702460vdc.30.1332841585658; Tue,
 27 Mar 2012 02:46:25 -0700 (PDT)
Received: by 10.52.96.38 with HTTP; Tue, 27 Mar 2012 02:46:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194035>

Hi, Junio

This pull request includes updates of sv and zh_CN translations.
Vincent's commit
(create new l10n team on Dutch) is withdrawed last minute when I
create this pull
request: https://github.com/git-l10n/git-po/pull/6#issuecomment-4712718 .

The following changes since commit 0e2d57fd50f61e668be3180bc8f25991ea88aa8c:

  Git 1.7.10-rc1 (2012-03-14 15:47:45 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po.git master

for you to fetch changes up to 3601b1d3593cbe856ea79fa554233b7d6fe52b2e:

  Add url of Swedish l10n team in TEAMS file (2012-03-27 17:11:34 +0800)

----------------------------------------------------------------
Jiang Xin (5):
      Merge v1.7.10-rc0 for git l10n update
      l10n: Update git.pot (1 new message)
      l10n: Update zh_CN translation for Git 1.7.10-rc1
      l10n: Review zh_CN translation for Git 1.7.10-rc1
      Add url of Swedish l10n team in TEAMS file

Peter Krefting (1):
      Update Swedish translation (724t0f0u).

 po/TEAMS    |    1 +
 po/git.pot  |   29 ++++----
 po/sv.po    |   41 ++++++-----
 po/zh_CN.po |  531
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------------------
 4 files changed, 310 insertions(+), 292 deletions(-)
