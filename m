From: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] pull request of git-l10n/git-po
Date: Mon, 12 Mar 2012 16:48:06 +0800
Message-ID: <1331542086-66644-1-git-send-email-worldhello.net@gmail.com>
References: <7vwr6qtiu7.fsf@alter.siamese.dyndns.org>
Cc: Git Mailing List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	Thynson <lanxingcan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 09:48:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S70vw-0002qz-EW
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 09:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832Ab2CLIsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 04:48:45 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41761 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab2CLIsn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 04:48:43 -0400
Received: by yhmm54 with SMTP id m54so2273898yhm.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 01:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DQA5OoX/7HO8xcoS0YnQEbZxBze+toJmDqNAYAlTdJU=;
        b=AJ51C0qDrYjIn2NPKHDlcbKR2YGlbd0cjICfNlLrV/FW60ixVndDmK1tJq8dnoejvs
         1ZA5XcR2c3ZADMkv3kgfME1CnPu8BXWUB3YVZYHXUF8QSrf5YrabdMYv0/+Oax06e+VT
         8xLx59RAtw0kJ8RqV8eGVZbRfeHdRP6Nze9VNswm96cgP+2qjKSSTWLpR/3RJbGrpshu
         3da6/AGr0uYSN5R2wumIN29kjgtF6KHEJZKhyCm5IimsydH2ibrcU66UFgAEjUTWvUrP
         4UF/fhm0X5FKekfx1gK5PnbDEKlJK9KU7KdzLZvKtYsj0b4yo0u/xDT4EOSREKcJ3E+m
         l6bA==
Received: by 10.68.244.99 with SMTP id xf3mr515169pbc.154.1331542122863;
        Mon, 12 Mar 2012 01:48:42 -0700 (PDT)
Received: from localhost.localdomain (li381-10.members.linode.com. [106.187.38.10])
        by mx.google.com with ESMTPS id l1sm9660376pbs.34.2012.03.12.01.48.39
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 01:48:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc0.33.g9678d
In-Reply-To: <7vwr6qtiu7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192847>

Hi gitster,

Git l10n updates in the git-l10n/git-po repo is ready for you to review and pull.
Another round of l10n update will begin when 1.7.10-rc1 released.

The following changes since commit 56a33c8f1bb5cef11ddf046f7b570f527ea77d37:

  Git 1.7.10-rc0 (2012-03-07 12:51:55 -0800)

are available in the git repository at:

  https://github.com/git-l10n/git-po master

for you to fetch changes up to 6672dc8e694f412090417a95cd6cd4b2b5be6da1:

  l10n: Improve zh_CN translation for msg "not something we can merge" (2012-03-09 00:22:56 +0800)

----------------------------------------------------------------
Jiang Xin (4):
      l10n: Update zh_CN translation for 1.7.9.2
      Merge v1.7.10-rc0 for git l10n update
      l10n: Update git.pot (1 new message)
      l10n: Update zh_CN translation for 1.7.10-rc0

Peter Krefting (2):
      po/sv.po: add Swedish translation
      Update Swedish translation (732t0f0u).

Thynson (7):
      l10n: Improve zh_CN translation for lines insertion and deletion.
      l10n: Improve zh_CN translation for msg about branch deletion deny
      l10n: Improve zh_CN translation for empty cherry-pick msg.
      l10n: Improve zh_CN translation for msg that make empty commit when amend.
      l10n: Improve commit msg for zh_CN translation
      l10n: Improve zh_CN trans for msg that cannot fast-forward
      l10n: Improve zh_CN translation for msg "not something we can merge"

 po/TEAMS    |    3 +
 po/git.pot  |  344 +++---
 po/sv.po    | 3860 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 po/zh_CN.po |  390 +++---
 4 files changed, 4239 insertions(+), 358 deletions(-)
 create mode 100644 po/sv.po
