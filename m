From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] some updates from German l10n team
Date: Sat, 27 Sep 2014 21:58:23 +0800
Message-ID: <CANYiYbGiAg6i3TNDzQsEBss+avvm=Ai_mHFJ5fph3bzGAq7crQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 27 15:58:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXsWD-0005lb-Pf
	for gcvg-git-2@plane.gmane.org; Sat, 27 Sep 2014 15:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbaI0N6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2014 09:58:24 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:48568 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbaI0N6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 09:58:24 -0400
Received: by mail-qg0-f54.google.com with SMTP id a108so10107368qge.41
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 06:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=9rLEneUo3byPjxEzMzoKeJmYQMFsM3frVmGNjwXkZqw=;
        b=asxnueVMGS+YUyZyiNS3hgenUnr25HYaeLlkJsb6/8BTIKsTpwRI93VcCvi4TzR1dS
         ACFBJGLSjmaBPKCooV+hvNDYArgmokOr1jo3z+B2JzMxZFMkAY7ctj1zHzWgEiuuEVsS
         se8Cdga41i1XHXafs9Jp2v/LA2/fr5wT6agVNe4UXa99UlfEw2DLiuCY95aeOMnVONh3
         LlyJq0xkrzNSgufkCqRxrvFJH48kQu32M2bjKSMl+rzUEh3OyGC/iiFkUvAPbHOH0Dtb
         82i86hqXK2zb+duxD/WomL3td7veDjElxsc+f6McoEuOpsRjAbusYSehaOUkzFQGTW5D
         Lf1A==
X-Received: by 10.229.140.70 with SMTP id h6mr36441228qcu.3.1411826303201;
 Sat, 27 Sep 2014 06:58:23 -0700 (PDT)
Received: by 10.140.29.35 with HTTP; Sat, 27 Sep 2014 06:58:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257557>

Hi Junio,

Please pull German l10n updates to the maint branch, and
merge them back to the master branch later.

The following changes since commit 96db324a73fdada6fbe7b63221986f8f18cc63b0:

  Merge git://github.com/git-l10n/git-po (2014-08-29 10:18:22 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po maint

for you to fetch changes up to 061540fcf7a4dba5392462bc5b07d6c12d3afc61:

  l10n: de.po: use comma before "um" (2014-09-25 20:26:27 +0200)

----------------------------------------------------------------
Phillip Sz (2):
      l10n: de.po: change Email to E-Mail
      l10n: de.po: use comma before "um"

Ralf Thielow (1):
      po/TEAMS: add new member to German translation team

 po/TEAMS |   1 +
 po/de.po | 100 +++++++++++++++++++++++++++++++--------------------------------
 2 files changed, 51 insertions(+), 50 deletions(-)
