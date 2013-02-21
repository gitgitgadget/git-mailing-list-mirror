From: John Szakmeister <john@szakmeister.net>
Subject: Re: Credentials and the Secrets API...
Date: Thu, 21 Feb 2013 14:27:47 -0500
Message-ID: <CAEBDL5UkCLwqn6JBkfu_sfWifh-7K9v6GfSAhhRzx7WaUaRovA@mail.gmail.com>
References: <CAEBDL5Udooim_3Za76Q1Rt_aGXtsSv76nxRegGWRBE=WJQzfZA@mail.gmail.com>
	<87halochci.fsf@lifelogs.com>
	<CAEBDL5VQxhnL+wdkf_5=MmG4ptBr4TFyyAvbMWxRom9SRxJ6Lg@mail.gmail.com>
	<87k3q2yl4y.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 20:28:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8boU-00021H-WB
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 20:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890Ab3BUT1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 14:27:50 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:43456 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678Ab3BUT1t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 14:27:49 -0500
Received: by mail-wi0-f173.google.com with SMTP id hq4so44044wib.12
        for <git@vger.kernel.org>; Thu, 21 Feb 2013 11:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=ka/pFts/1FfFsI6Fu2lKCuMs35j02LpKwV0BX9nGuGU=;
        b=Ikwt4ujFqa5AZ8dqjK9KO1tQxy+sRwlOIxboiQGyoYHzEuWPez0ixtfC6yBppOAxlg
         CLlM31ZCr+m5fKdCLIltdIgpi7nZ0dSO8YZQE/g5c+LyBgULMMxMjxoxhIQLTrkQ+0gY
         3OkNFrxUILbporBTo555OFF8p9sMqG2hpl6ZcEad75yS7NOr8C+ast0u/Jk3x7x695wN
         sk39t/cgZ/Kk6O2r/wYyhDfR3Q2/cT+9dr3BybtZyp5XMBB3M16kZ7BN1+sOZiyCktjY
         BSXFaATPpFlABNYh6WDofxDuQtpXFBHp1iy+4oKXsihWaZLhm7EeG/39XXCFKLy6pQAQ
         nqlg==
X-Received: by 10.180.84.165 with SMTP id a5mr44442946wiz.6.1361474867857;
 Thu, 21 Feb 2013 11:27:47 -0800 (PST)
Received: by 10.180.14.137 with HTTP; Thu, 21 Feb 2013 11:27:47 -0800 (PST)
In-Reply-To: <87k3q2yl4y.fsf@lifelogs.com>
X-Google-Sender-Auth: gPyQNQGi0ZHbHmb9UJ2Po18-vWk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216788>

On Wed, Feb 20, 2013 at 12:01 PM, Ted Zlatanov <tzz@lifelogs.com> wrote:
> On Sat, 9 Feb 2013 05:58:47 -0500 John Szakmeister <john@szakmeister.net> wrote:
[snip]
>
> JS> Yes, I think it has.  Several other applications appear to be using
> JS> it, including some things considered "core" in Fedora--which is a good
> JS> sign.
>
> Wonderful.  Do you still have interest in working on this credential?

I do, but I'm a bit short on time right now.  So if you or someone
else wants to pick up and run with it, please feel free.  If I get
some cycles over the next couple of months, I'll give it a go though.

-John
