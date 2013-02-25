From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Git 1.8.2 l10n round 3
Date: Mon, 25 Feb 2013 21:24:14 +0800
Message-ID: <CANYiYbHPtW0u80ojHt9xoADVS8S8mVkubb6dUDN_1uwkcTZTww@mail.gmail.com>
References: <CANYiYbHF1MAEcbhhf+PfawTzTxC06LFuZuccyeQUmtf8xXE8ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Tran Ngoc Quan <vnwildman@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 14:24:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9y2x-0002l5-9y
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 14:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759820Ab3BYNYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 08:24:18 -0500
Received: from mail-we0-f182.google.com ([74.125.82.182]:47530 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759799Ab3BYNYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 08:24:16 -0500
Received: by mail-we0-f182.google.com with SMTP id t57so2499076wey.27
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 05:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=1SThNWFR3uFa4cjNYCCsua8QhVKdecyTOs/mgi7EMw0=;
        b=QBwABwxwADtnCUA3w2lxZs0po2fqCHhJL9+oggCyzJSvduxNYsZnw70vfzM7KTZsQP
         DkO1VyacH58JPl7hkSWF7qAgmM4OKt72u1erZSqNMxJRw1DwTo0g7nijNFZp0ZHM8Jig
         DjyfeaNhhYnkZ+m4aV9cnJKJWCrxLy0zFTZ6Z3Z+qKjeOahxvIZ5nRx/QteBWzRFxZmj
         d4K/XVxQjS4evFXSBBRWAjbBbQiNaaS492F0Ko9u/UiHhtgKiKCc/YrIdoHIEKIv4JPa
         FOo5w+MqeiMoyvOqz6jAVbyBcNZFMo1ZxjE90vzcC8DitgxpBzb3ai2x68yqHAbCqQh+
         TIAg==
X-Received: by 10.180.92.39 with SMTP id cj7mr12101927wib.19.1361798654886;
 Mon, 25 Feb 2013 05:24:14 -0800 (PST)
Received: by 10.194.110.199 with HTTP; Mon, 25 Feb 2013 05:24:14 -0800 (PST)
In-Reply-To: <CANYiYbHF1MAEcbhhf+PfawTzTxC06LFuZuccyeQUmtf8xXE8ig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217056>

Hi, Junio

The following changes since commit 20a599e2c18dd5b491257d7f8aeb2d2f02221595:

  Merge branch 'jc/mention-tracking-for-pull-default' (2013-02-18
16:05:03 -0800)

are available in the git repository at:


  git://github.com/git-l10n/git-po master

for you to fetch changes up to c527acebc2071975dffbccf33f4a1c8adfc6f45f:

  l10n: vi.po: Updated 5 new messages (2009t0f0u) (2013-02-20 07:17:58 +0700)

----------------------------------------------------------------
Jiang Xin (2):
      l10n: git.pot: v1.8.2 round 3 (5 new)
      l10n: zh_CN.po: translate 5 new messages

Peter Krefting (2):
      l10n: Update Swedish translation (2004t0f0u)
      l10n: Update Swedish translation (2009t0f0u)

Tran Ngoc Quan (1):
      l10n: vi.po: Updated 5 new messages (2009t0f0u)

 po/git.pot  |  225 +++++-----
 po/sv.po    | 1434 +++++++++++++++++++++++++++++++++--------------------------
 po/vi.po    |  255 ++++++-----
 po/zh_CN.po |  234 +++++-----
 4 files changed, 1200 insertions(+), 948 deletions(-)

--
Jiang Xin
