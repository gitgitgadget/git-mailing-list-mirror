From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Fri, 6 Sep 2013 10:14:45 -0700
Message-ID: <CAE1pOi1epmm2ESb0ocAhPFCfs6LVctFOXnt2vwPNp2Lxuq2=+w@mail.gmail.com>
References: <20130829180129.GA4880@nysa> <CABjHNoR637ecLnnLwhj59ddnhy8Lcyk+2YzAqN=nxWN7-BkivA@mail.gmail.com>
 <CACSwcnR+rHVDVHu8rwATU+VbGE-9zP=xB8Y-udPGoP6KvhprCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: William Swanson <swansontec@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 19:15:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHzcp-0004Kv-M3
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 19:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913Ab3IFRPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 13:15:07 -0400
Received: from mail-ve0-f176.google.com ([209.85.128.176]:62674 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304Ab3IFRPG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 13:15:06 -0400
Received: by mail-ve0-f176.google.com with SMTP id jx11so1819331veb.35
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 10:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Luc7ZPahkw7xW2eYfSzcfRDADHnBhZn42X1Px57Exek=;
        b=xWIx8g6f29SeS6uIQ1T273zh7mfPCnRVY80P5upR/aR2ZZBrOU/NLB8ZYshxcADKLO
         CZcM2E1xu2/5FhXWzMYFghdSrKc1EhEtmbZcz5vHyHvzvy15aK1CqL048rmAqwenPdBX
         3VsJcHLxtznpBsrgEF2MxzvodEwEMPEK+7rQ81YNlYEfbRSps8DDEePcbyEESFGx7t/w
         De+YYhuP4bJo6XhVGxCUyLKA9nFbKxLnPwz9sKqZcWsx7FwXjqfPslbo1s5BkMZGwXZa
         SnSlqm9dPVxCWciPhpDamrpS5uYSs+rBXuxu1DWJwS1fhjYjvQGwHZI4N3s5wa/p4zDm
         elbw==
X-Received: by 10.52.164.16 with SMTP id ym16mr1916862vdb.32.1378487705564;
 Fri, 06 Sep 2013 10:15:05 -0700 (PDT)
Received: by 10.58.65.70 with HTTP; Fri, 6 Sep 2013 10:14:45 -0700 (PDT)
In-Reply-To: <CACSwcnR+rHVDVHu8rwATU+VbGE-9zP=xB8Y-udPGoP6KvhprCA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234064>

On 6 September 2013 08:45, Ping Yin <pkufranky@gmail.com> wrote:
> On Wed, Sep 4, 2013 at 2:08 PM, William Swanson <swansontec@gmail.com> wrote:
>> On Thu, Aug 29, 2013 at 11:01 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> It has been discussed many times in the past that 'index' is not an
>>> appropriate description for what the high-level user does with it, and
>>> it has been agreed that 'staging area' is the best term.
>>
>> I realize Git is not a democracy, but if the vote of a humble user
>> counts for anything, I agree that "index" is a terrible name.
>
> +1 for staging area

As yet another "just a user", I'd like to add my enthusiastic support
for "to stage" and "staging area".

I'm guessing that a lot of Git devs/long time users are simply so used
to its interface that they may not see its sharp corners any more. :-)
That's quite natural and bound to happen to anyone who works with a
particular tool for a long time. Still, (e.g.) "git add -A" removing
files (as useful as that is) is just weird. And, in general, the user
should not need to know how Git is implemented.

>> I was very excited when Felipe first started this thread, since I
>> thought Git might finally fix one of it's biggest long-standing
>> usability problems.
>
> the same feeling.

Ditto. :-)
