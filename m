From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] l10n updates for Git 2.1.1
Date: Fri, 29 Aug 2014 18:12:35 +0800
Message-ID: <CANYiYbGV_CFAOHzrEvyr+juNd3XmB_5t_fhNdCMWsFQwnTrujw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 12:12:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNJAf-0003m1-1w
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 12:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbaH2KMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 06:12:37 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:61958 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbaH2KMg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 06:12:36 -0400
Received: by mail-wg0-f41.google.com with SMTP id l18so1892406wgh.0
        for <git@vger.kernel.org>; Fri, 29 Aug 2014 03:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=jwPO+mYqOJV61cApcTu3a534eamcXHqyDMMj47VtY+M=;
        b=tERYDNUXftajHg1bf9EGjNjqiWQCOADcRTMnZjLSnGpet90h73c5Lct3J143nOIM7/
         2lRfTfzpPM78jN9Qf5LM/lyFOVl6GlKqoJ/6HsePct42duCsgB0zypRguQ4iwkyrnD14
         UFweNBMan/4XQqa5Ax42YUI5VQdXW5blyEJqSFGt9xusdlYl16NPnJ221+KZQ1E/a3mC
         77vmC6q/EGukcUC/rckJFBOplxx6QhXLfLqY1t9+8hoBflQ2FVn46OFSi6ckdqJqUY5X
         ZbRLPKzLmgEjgCi/XtNjCxwMeNfcTE+Eat2vn0q+xa/BnXd1SuIVS606gzDnRUtK1vvs
         I6QA==
X-Received: by 10.194.7.136 with SMTP id j8mr12065055wja.62.1409307155052;
 Fri, 29 Aug 2014 03:12:35 -0700 (PDT)
Received: by 10.194.58.200 with HTTP; Fri, 29 Aug 2014 03:12:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256140>

Hi Junio,

Please pull the following l10n updates to the maint branch.

The following changes since commit 869951babc24fef5c5cd58f86baefc25b6ed3765:

  l10n: de.po: improve message when switching branches (2014-08-23
19:17:38 +0200)

are available in the git repository at:

  git://github.com/git-l10n/git-po

for you to fetch changes up to 782ac539ea6fd069ede52917f047ffa9a81947e5:

  po/TEAMS: add new members to German translation team (2014-08-29
07:08:17 +0200)

----------------------------------------------------------------
Ralf Thielow (2):
      l10n: de.po: translate 38 new messages
      po/TEAMS: add new members to German translation team

 po/TEAMS |    2 +
 po/de.po | 2872 +++++++++++++++++++++++++++++++++-----------------------------
 2 files changed, 1515 insertions(+), 1359 deletions(-)

--
Jiang Xin
