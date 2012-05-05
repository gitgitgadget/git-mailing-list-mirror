From: Scott Chacon <schacon@gmail.com>
Subject: Re: git-scm.com refresh
Date: Sat, 5 May 2012 15:24:19 -0700
Message-ID: <CAP2yMaJuGgowcdcySBa-qFNeaSCh8_LLv+d+g=WnGFpOf05vzw@mail.gmail.com>
References: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com>
 <m38vh7qxs3.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 00:25:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQnPo-0000ah-PF
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 00:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663Ab2EEWYl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 May 2012 18:24:41 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:35338 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610Ab2EEWYk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 18:24:40 -0400
Received: by qabj40 with SMTP id j40so2714463qab.1
        for <git@vger.kernel.org>; Sat, 05 May 2012 15:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MUyRkAq2aAcZesP3m8Onykl9J5glIYjYsG5lvKvPiz8=;
        b=j39UwzbxbHCwztY9KVtpFH5klHdNwkgMhSppg+936zxjUl8nyCIyaJ82GynHjo1ZQo
         A2CHBrJJnxwM3ULmiuLlrwvBrCZxoowH4nw3G8c4hDki0l72C7FMVtn303Dbdds0t6fd
         x6BZTol7nxMWavNN4FaEXcb53kKsxeoNeDEj1rhUSXn/0WQcRvMYFTPxkneAjG0mUFNU
         46AyZLMuBi+FWS0dmMXDYHlh7RZngrm/HeqCAtMvnLYmklNvoOUZPUoz1kCuMCB+VoTB
         aMF7mRJKnJa9M7i9JMSgtiinhVbqJjTXorL/TnGcTxTTEIVIOenPiSQn8RBtOaQSoq/f
         yGBQ==
Received: by 10.229.136.75 with SMTP id q11mr5066973qct.97.1336256680140; Sat,
 05 May 2012 15:24:40 -0700 (PDT)
Received: by 10.229.251.142 with HTTP; Sat, 5 May 2012 15:24:19 -0700 (PDT)
In-Reply-To: <m38vh7qxs3.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197137>

Hey,

On Fri, May 4, 2012 at 5:26 PM, Jakub Narebski <jnareb@gmail.com> wrote=
:
>> version of any command: http://git-scm.com/docs/git-fsck/1.5.5
>
> That's very good. =C2=A0Thank you very much for giving home to git ma=
npages
> online.
>
> It would be nice for those manpages to have the title of page to be
> set appropriately, e.g. for http://git-scm.com/docs/git-bisect to hav=
e
> "git-bisect(1)" or "git-bisect(1) Manual Page", or even perhaps
> "git-bisect(1) Manual Page - Find by binary search the change that
> introduced a bug" instead of just "Git".

Good catch - I'm pushing that out in a minute.

>> * We designed a new logo[1] - there are multiple variations availabl=
e
>> for download on the site under the most permissive CC license for an=
y
>> use.
>
> IMVHO it is too similar to Bazaar logo:
>
> =C2=A0http://bazaar.canonical.com/bzricons/bazaar-logo.png
>
> I like the [---] git logo, but I guess it is a bit cryptic.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [+++]
>

I was actually concerned with the same thing, but a) not that many
people are familiar with the Bzr logo and b) when I actually look at
the Bzr logo I don't really see that much in common.  It was done by
someone totally unfamiliar with that logo and although I can still see
similarities, I think it's a good, clean logo that would be easily
recognizable and much more versatile than what we have been using so I
decided to stick with it.


>> Let me know if you run into anything or there are any features you
>> would like to see.
>
> In my ancient 10-years old web browser (Mozilla 1.17.2, Linux) the ne=
w
> layout is seriously broken (misaligned), and much less readable than
> the old one (BTW. could you keep the old one, perhaps only the front
> page, for comparison?). =C2=A0Also the font size is too small.

I have to assume that just about any modern site looks pretty awful to
you.  I honestly don't know what to do about this - I can't even test
it really.  I am aware since the launch that a number of people have
issues with JS being turned off, which I'm working on, but there's not
a lot I can do for browsers like that and I'm not sure what the point
would be anyhow.  People with browsers like that don't need anything
on this site as far as I can think of.  It targets people that don't
know Git and possibly don't know version control and are trying to
figure it out.

I'll try to make it better, but it would be simpler if you could fix
it and send me a pull request since I have no other way to see what
you're seeing with tech that out of date.

Scott
