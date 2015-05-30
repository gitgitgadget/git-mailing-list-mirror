From: Quentin Neill <quentin.neill@gmail.com>
Subject: Re: [PATCH] blame: add blame.showemail config option
Date: Sat, 30 May 2015 15:31:10 -0500
Message-ID: <CACfD1vv9gFFnYmMQmX_KmZFHBbzPuNmts7FE8cJwQz-r+33BcA@mail.gmail.com>
References: <1429841612-5131-1-git-send-email-qneill@quicinc.com>
	<CAPig+cQrUPHOaKjNhsmLho+bFdAOQxb0NK2YK2QsFmdDBF6h4g@mail.gmail.com>
	<CACfD1vvaAGkx2P3yMfZPOZrRvG3-H96zQVOCevnd-O0rBJ7wjw@mail.gmail.com>
	<xmqq617bcgva.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 30 22:31:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YynPY-0005H4-Ag
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 22:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbbE3UbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 16:31:13 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36850 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932640AbbE3UbL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 16:31:11 -0400
Received: by qkx62 with SMTP id 62so63554399qkx.3
        for <git@vger.kernel.org>; Sat, 30 May 2015 13:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=onR9+q81ruqmue4HaKFb5hLqRJpxp9a6/GVURL3mar0=;
        b=sslMUbJ1WzBqsRCgaYkO/pmAr0D8FQQmzquuanv1hx3w0xcqS9Ct6WcMtPMb/ob2dG
         fwM6cpe8VJWq4vsjwTfezUcXEEJO0nScwcZmQKLm7xirU+yEcf0GUnw/7uNZx8kPBeP8
         2XjBvo9F91xjU8UNbjJHPGfypkMclN4BZjvfkd39CG9uRye4O3mq/Du2TIvx4Uykw/r3
         NZvsJ82gWJ1oS8uJnCAfEuQOXoAb5Fvph+jDriYFoXXJyRi+7TNXeKzSURhwufVHKLS9
         Jj9PKDbi3SXS9Lg7EyDw5T0LkoRhzYNW2YQyiWsOAH/AnVEkdL8HKmKwLp5MWQ7CV/UJ
         kcNw==
X-Received: by 10.140.235.77 with SMTP id g74mr17615212qhc.64.1433017870888;
 Sat, 30 May 2015 13:31:10 -0700 (PDT)
Received: by 10.140.108.130 with HTTP; Sat, 30 May 2015 13:31:10 -0700 (PDT)
In-Reply-To: <xmqq617bcgva.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270307>

On Fri, May 29, 2015 at 2:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Quentin Neill <quentin.neill@gmail.com> writes:
>
> > Thanks for the thorough review!
> > I have adjusted the commit messages and updated the documentation changes.
> > I'm in trying to add tests, I'll probably have some issues but will
> > post something that works soon.
>
> Hi, I was sweeping my old mailbox for leftover bits, and noticed
> that this thread ended without seeing the final step.
>
> Has anything further happened to this topic, did you got too busy,
> or you lost interest?
>
>

[One more time without html]

Hi Junio,

I got too busy, my free time went to zero.  And this week I am
traveling. I was tinkering with tests Thursday night and was in fact
preparing a reply. When I get back I'll post the patch.
