From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.2.0
Date: Tue, 18 Nov 2014 12:03:55 +0800
Message-ID: <CANYiYbEx+1DAewvVhNtAMEoZt2QdVV9dmSOtfFtPDXQbv_Hw2w@mail.gmail.com>
References: <CANYiYbFXMU2HrV8B6nfN38pD6pYsWb2q-0NgXj_yAYJCJ5YnsQ@mail.gmail.com>
	<xmqqppclybwd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Alex Henrie <alexhenrie24@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 05:04:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqa1R-0003X4-V6
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 05:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbaKRED6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 23:03:58 -0500
Received: from mail-wi0-f181.google.com ([209.85.212.181]:47722 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbaKRED5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 23:03:57 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so4772195wiv.14
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 20:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Cn0NmQ5g0vUTu3TFGk4KMAVMsNOtqRmuM+g5ANeIOq8=;
        b=QgmKQCIg/gYzRdVIpIMJiQDlfLAEf3t/efT39dMXmwVgcF8VbVCGAgtvdg7WLVAmmc
         INGZfa3OWXAj2k9c25Rl5ntcwGmkYh5A8dRmLdJ1dNG2jeRkg+2EtphRxu5b5l8nNjR0
         gZq3CNpXeUBHMytcTHPGPyLFNU6PXPRrT7PjgVTqiu2nJd5NtWW42zKGvg7agBVH9TOk
         GkuEIVOL7nnpYgsbjc4lCWRyCaQE1s81kGcbEH+RP5RGJJxqpWMmwRmoO8gBJSTsMnIw
         nkBupmENtxbdZo8RSYH2XGwBTxBK65u9gDa3we4rdUHTc/f84C73EbV33Vg429i6fioC
         0LAw==
X-Received: by 10.194.81.6 with SMTP id v6mr43462844wjx.39.1416283435823; Mon,
 17 Nov 2014 20:03:55 -0800 (PST)
Received: by 10.194.56.8 with HTTP; Mon, 17 Nov 2014 20:03:55 -0800 (PST)
In-Reply-To: <xmqqppclybwd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull again in order to merge Catalan translation.

Now l10n for Git 2.2.0 is almost completed.

        bg.po     : 2296 translated messages.
        ca.po     : 2296 translated messages.
        de.po     : 2293 translated messages, 2 untranslated messages.
        fr.po     : 2296 translated messages.
        it.po     : 716 translated messages, 350 untranslated messages.
        pt_PT.po  : 306 translated messages, 687 untranslated messages.
        sv.po     : 2296 translated messages.
        vi.po     : 2296 translated messages.
        zh_CN.po  : 2296 translated messages.


The following changes since commit d544b2d495295142cb3418b13b5a106d415d2216:

  l10n: de.po: translate 62 new messages (2014-11-15 18:22:05 +0100)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to b3e4c47565711f5927d87392bd80ff1d6fb25c57:

  l10n: Update Catalan translation (2014-11-17 20:22:48 -0700)

----------------------------------------------------------------
Alex Henrie (1):
      l10n: Update Catalan translation

 po/ca.po | 4557 +++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 2392 insertions(+), 2165 deletions(-)

--
Jiang Xin
