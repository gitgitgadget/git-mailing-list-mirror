From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Wed, 17 Apr 2013 22:59:58 -0500
Message-ID: <CAMP44s0q4k+bjQDhWAiYoj2P+7PJqFRs9s0arhy+F7YDO50dZg@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
	<7vip3npet0.fsf@alter.siamese.dyndns.org>
	<CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
	<8761zm4wzg.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
	<CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com>
	<CAMP44s3pZt3QVjS7GbXqjMS4ti3p=Vs2DmFXQjsMM3rs9qURmw@mail.gmail.com>
	<7vsj2od841.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <phil.hord@gmail.com>, Thomas Rast <trast@inf.ethz.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 06:00:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USg13-00085m-Bw
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 06:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093Ab3DREAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 00:00:01 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:36634 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459Ab3DREAA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 00:00:00 -0400
Received: by mail-la0-f50.google.com with SMTP id el20so2157354lab.9
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 20:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=CMaHukM+rDBU5JDT2FKp5rQBvUUx+B3LThPw6ALherk=;
        b=nYVmM9l1UXF/rCuKglMmrN37492xePzDeCiufguAFAoWZTZExKdOvqHz9hhjtCZWfu
         WWOqiwiJZjpJp/yeCdbYGY+D8OUByjZPIkKqEWUGElqzI64cJFR1Hm/no4kJXY6XwG2f
         PnSU60zrMBZSdW/UyZaPKBl+Euwlah3NEWX5EY22hMZ7sqWM4d4VfmpJp4hScZiyZT91
         jD7VqvLxB+PChCddOkuY359DxwE/0pX4M0Dd4bPEHMPOQ+FTQ86hJjYNN+cqw1E7s9iX
         kD7sYHE3pIBsiPuXMgRJqcpbb/FNMhGKzkkZ6rUuzunu/RGmdVMItDJsZMqKQTglsCQY
         yIXQ==
X-Received: by 10.112.135.3 with SMTP id po3mr1796802lbb.103.1366257598926;
 Wed, 17 Apr 2013 20:59:58 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Wed, 17 Apr 2013 20:59:58 -0700 (PDT)
In-Reply-To: <7vsj2od841.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221600>

On Wed, Apr 17, 2013 at 6:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> And how do you know this will be part of the 1%? You don't. How many
>> times have you tracked regressions in transport helper's import/export
>> functionality? How many times in remote-hg? How many times has
>> *anybody* done so?
>
> The last point makes it all the more important to have a good
> history [*1*]. An area that no developer rarely touches with a little
> user base can stay dormant for a long time, and when people do need
> to hunt for an ancient bug or to enhance the existing feature to
> support a new use case without breaking the old use case, the
> original author may not be around, lost interest, or no longer uses
> his own creation.

You are going in circles, I said such situation was *HYPOTHETICAL*,
Phil Hord said it wasn't, and now you are bringing back more
hypothetical examples, which I would gladly address, as soon as you
accept they are HYPOTHETICAL.

Now, how about you answer the questions about the *REAL* situations
Phil Hord mentioned?

* How many times have you tracked regressions in transport helper's
import/export functionality?

Hint: zero.

* How many times in remote-hg?

Hint: zero.

* How many times has *anybody* done so?

Hint: other than me, quite possibly zero.

And then, before we consider this *hypothetical* situation, it might
be worth noticing what commit this hypothetical person would hit if
you do *not* apply this patch, and what the commit message says:

---
remote-helpers: add support for an export command

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Yeah, well, glad you didn't apply my patch, wouldn't want to mess up
the code that was clearly explained by that commit message.

And before you rationalize the above commit, because maybe the
functionality was described in the documentation, it wasn't:

 transport-helper.c | 132
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 120 insertions(+), 12 deletions(-)

If you do apply my patch, it turns out even the shortest version of my
commit message already gives more information to this *hypothetical*
developer person.

> [Footnote]
>
> *1* In this message, I am not judging if the depth of your writing
>     for the particular change is deep enough. It depends on how well
>     the reader knows the area, and there is no single right answer
>     to that question.
>
>     Incidentally that is why we tend to err on the more descriptive
>     side. The next person your commit will help may not know the
>     area as well as you do and has to figure things out on his
>     own. You are helping him by being descriptive.

I partially agree with this, but I think documenting the nuts and
bolts of transport-helper would be better in done in code,
documentation, tests, and mailing list analysis. And in all those
respects, I believe I've done a more than adequate job.

Cheers.

-- 
Felipe Contreras
