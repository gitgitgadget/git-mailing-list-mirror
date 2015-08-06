From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: Draft of Git Rev News edition 6
Date: Fri, 7 Aug 2015 01:44:33 +0200
Message-ID: <CAHYJk3QkMM40_HA7MO-h9z8f69rsPLmuKt1bkR+iuz75A+uQZA@mail.gmail.com>
References: <CAEcj5uXXe19APhNaV6Kfm_3SNpRmFHToooo07T0_r6McJOrsaQ@mail.gmail.com>
	<xmqqfv4087b8.fsf@gitster.dls.corp.google.com>
	<CAEcj5uUmsV5xzONaahkEEp7R80_zunSAiwTE2UeSxdS6wo1xmg@mail.gmail.com>
	<CAEcj5uXJnZ+3R+CWoUnpqixrKiiWMQMVjq2YrXYd2brbP9URQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Thomas Ferris Nicolaisen <tfnico@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 01:44:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNUq0-0008Bj-55
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 01:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbbHFXog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 19:44:36 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:35740 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbbHFXof (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 19:44:35 -0400
Received: by labkb6 with SMTP id kb6so36597004lab.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 16:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=W8cNOk7N7t9Ael1cz8f50HlR1vWn0GA0wnQYyYvlAMc=;
        b=q+LnZMo3o/ZlANH4nTY2Qyd7feORKo2ofFgMHpKIBHrftRgOCs4bwG4fsVS0rKTbYx
         7UpZ7VBc/xxUhFSZIwoRjvjLHssifLl6TZa1eryIEs65FzmiUVVE+dQULkJvLTT4Q5Ts
         Kc4I8krCmXzM2+KyjZIwNfKtXN04k31qGbv8G/D7hG7NtUsAbK3WeyHL0UkHsf8iJDXB
         oGscgE1xL9yz6eB2vEiJVFz2dB2EGyt6NA+tJhUA/PrVXFX/vUsAwr2AXSz3I6nVGRaL
         HFWU3UHQBWzxCdFLvQR0/FCFeWQmXIF30cjitHlrXVcOJhWKrOcY3M9HRZoY7Qa6hH5i
         H3Ag==
X-Received: by 10.152.18.232 with SMTP id z8mr4885640lad.66.1438904673771;
 Thu, 06 Aug 2015 16:44:33 -0700 (PDT)
Received: by 10.112.2.234 with HTTP; Thu, 6 Aug 2015 16:44:33 -0700 (PDT)
In-Reply-To: <CAEcj5uXJnZ+3R+CWoUnpqixrKiiWMQMVjq2YrXYd2brbP9URQg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275451>

On Fri, Aug 7, 2015 at 12:18 AM, Thomas Ferris Nicolaisen
<tfnico@gmail.com> wrote:
> On Mon, Aug 3, 2015 at 10:49 PM, Thomas Ferris Nicolaisen
> <tfnico@gmail.com> wrote:
>> I hope we can attract more contributors in the future, so the weight
>> of this doesn't lie too much on his shoulders. Perhaps we should send
>> out the draft earlier next time, and beckon for more contributions
>> from the list.
>
> Just to follow up on this point: The draft for the next edition is
> available here (still empty):
>
> https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-7.md
>
> Suggestions and comments can go here:
> https://github.com/git/git.github.io/issues/94
>
>> We could also add a call-for-help at the bottom of the respective
>> section, asking people who are trawling the mailing list to
>> contribute.
>
> You may have spotted that I added this in the recently published
> edition, but I think it can bear repeating here for git@vger:

It is surprisingly difficult to get to the actual post of edition 6
from this thread. The link in the original post is just a 404, and to
get to it from the link in this mail, which you might not have sent at
all, I had to click like 5 things, and a few of those turned out to be
dead ends. I suppose once you know where they are published, it is
easy to find, but I did not :).

-- 
Mikael Magnusson
