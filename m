From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] l10n updates for 2.6 maint branch
Date: Sat, 17 Oct 2015 20:24:14 +0800
Message-ID: <CANYiYbHj5+X+FDsG9mcS5zY=4yRd4CHBe5im7u4oeXFDBj5euQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 14:24:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnQX7-0004zM-8V
	for gcvg-git-2@plane.gmane.org; Sat, 17 Oct 2015 14:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485AbbJQMYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2015 08:24:16 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36403 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbbJQMYP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2015 08:24:15 -0400
Received: by wicgb1 with SMTP id gb1so39176377wic.1
        for <git@vger.kernel.org>; Sat, 17 Oct 2015 05:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=OXVJ+Sbt+6i5+DmZJQFnGnGX71eJgZi1mt0rN1sPuMU=;
        b=V8MYZHTigr+WzJyuCE99wqnz1uXLxuM2POxR3Jzjb6fuD5OZzy8kmVotSf9Y13AI61
         sdXg0HAvBz8fMNLGCaEaOnI57nHv8b96dsclffSWPWy7Bs0RQlDCVRpSiJvcA1JgjJGs
         +v6tUvdlG/OridZ7FUMa5SiXT04Q7OkLtwqMf0Q3OLajPDdt7kg1SVBF1+B2/NVegHu3
         bhOJQNnC/gFwi7KQL3JBgFq5vDSGtYDu3JqtfRwnnZ19q6AZMbFFhkiq39vdQQnTT6DJ
         +Z7KqvMoLmVSWtSePXNSmY1QjzAMRjjg87i5Iv+p5Vp3kcsBDkNUtLZwCwsph0UcOYu8
         UUnw==
X-Received: by 10.180.182.107 with SMTP id ed11mr10417643wic.52.1445084654523;
 Sat, 17 Oct 2015 05:24:14 -0700 (PDT)
Received: by 10.194.246.193 with HTTP; Sat, 17 Oct 2015 05:24:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279787>

Hi Junio,

Please pull the following into the maint branch.  It includes l10n
updates in Russian which missed the update window for 2.6.

The following changes since commit 8d530c4d64ffcc853889f7b385f554d53db375ed:

  Git 2.6-rc3 (2015-09-21 13:26:13 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po maint

for you to fetch changes up to 82aa9b751fe96c5e55c36819aedea3d47e98bb57:

  l10n: ru.po: update Russian translation (2015-09-30 18:01:23 +0300)

----------------------------------------------------------------
Dimitriy Ryazantcev (1):
      l10n: ru.po: update Russian translation

 po/ru.po | 3550 ++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 1967 insertions(+), 1583 deletions(-)
