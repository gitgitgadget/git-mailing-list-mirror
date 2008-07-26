From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: git-scm.com
Date: Sat, 26 Jul 2008 11:33:49 -0700
Message-ID: <d411cc4a0807261133w6f068176y5c4a23c887da8ed3@mail.gmail.com>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
	 <6b6419750807251838h12ea4f19gdff107694e3797c4@mail.gmail.com>
	 <d411cc4a0807251928g75744b78vac2ce77bf07fbd81@mail.gmail.com>
	 <20080726023707.GX32184@machine.or.cz>
	 <alpine.DEB.1.10.0807251943280.11335@asgard.lang.hm>
	 <d411cc4a0807252230v76670d3cp2205e40826acc6e2@mail.gmail.com>
	 <F3D70DCD-E9A9-42C3-8870-ABB7EECF83CC@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 20:34:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMobT-0001di-F6
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 20:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309AbYGZSdv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jul 2008 14:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753161AbYGZSdv
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 14:33:51 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:39092 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbYGZSdu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Jul 2008 14:33:50 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2450003waf.23
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 11:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=G0iNkIbHBsArtznHtazoio33lLjOZl2aL2DuxkCfBLw=;
        b=D1v6zbKSduIgWMA+VodIJt8DT7qDqrNX/iVXknJ+FX3um3Pb04l2mSSzpnF0QbRPpN
         BlzyXI7OixuIrxwkFhsBqz/rT9MmDiUCDvmFBcvj7f/Y7MctZXQaJHC6u9cQJqPL9GCa
         AI+JvO+qQY+mN6sbpKk23r6eCz5KR/FXvrbYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IyCxkjZn5TZlA0zwgcg7hFYpn3ArjkEAIZPwY3M+ONsmcd9Ye5vKJz75HXCiwIwNaV
         4pGBO2tNwZ9355Eb29pcN+YxUsUxgubl893rsXTJPj2LkKKgMz5lV/tPN4Fp3+gmT0up
         hIC33SkktPHYWji6KUswrKoY9vRGeZd4goEyA=
Received: by 10.115.33.1 with SMTP id l1mr3355553waj.115.1217097229688;
        Sat, 26 Jul 2008 11:33:49 -0700 (PDT)
Received: by 10.115.22.20 with HTTP; Sat, 26 Jul 2008 11:33:49 -0700 (PDT)
In-Reply-To: <F3D70DCD-E9A9-42C3-8870-ABB7EECF83CC@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90270>

On Sat, Jul 26, 2008 at 8:48 AM, Wincent Colaiuta <win@wincent.com> wro=
te:
> El 26/7/2008, a las 7:30, Scott Chacon escribi=F3:
>
>> However, that being said, it's going to be difficult to have Github
>> projects not dominate the list a bit.  The fact is that it hosts far=
,
>> far more projects than any other single hosting service.  Just in
>> fully public projects, the current stats (from the website pages) ar=
e
>> something like this:
>>
>> kernel.org : 475
>> repo.or.cz : 1,553
>> gitorious   : 780
>> github       : 10,560
>>
>> It hosts far more than that if you include private projects, too.  S=
o,
>> if we want to choose totally randomly, it's going to be at least a 5=
:1
>> ratio between github projects and all other public hosting providers=
=2E
>
>
> I think those numbers are pretty meaningless seeing as GitHub encoura=
ges
> people to publish "forks" of other projects. Rails, for example, has =
about
> 270 forks at the time of writing. If I scan the list of popular proje=
cts I
> see fork counts like 129, 105, 78 and 78 (again). Are all the forks c=
ounted
> in that figure of 10,560 that you count? How many "real" projects are=
 hosted
> there?

Actually, no - I was including forked projects in the repo.or.cz count
and _not_ including forks in the github count.  The actual apples to
apples count is :

Unique Projects:
  repo.or.cz: 1553
  github: 10,560

With Forks:
  repo.or.cz : 1349
  github : 16,021

Again, that is only the free, public projects - there are far more if
you include the private projects as well.  I understand that the
commercial side that is necessitated by that is uncomforting to many
people, but it is great for the adoption of Git.  Otherwise, every
company that wants to use Git professionally, including freelancers
and consultants, would have to setup, manage and maintain their own
git servers.  It should not be a precondition that in order to use Git
on a commercial project you either have to be a) a systems
administrator capable of setting up and running your own server (and
keeping it secure, etc), or b) part of an organization large enough to
have a department to take care of that for you.  Sure, you and I can
do it, and it's easy for us, but that is not true of everyone.

> I'd like to see the "official" Git homepage as distanced as possible =
from
> GitHub. They've taken Git (free as in speech, free as in beer) and bu=
ilt a
> closed-source commercial product on top of it -- curiously for someth=
ing
> which you can do for free yourself anyway -- and as far as I can tell=
 from
> observing this mailing list and watching the commits going into git.g=
it,
> haven't ever contributed _anything_ back to the community. At least w=
ithin
> the niche that is the Ruby/Rails community, GitHub has basically done=
 a
> hijack job and managed to become synonymous with Git, supplanting it,=
 and
> it's a trend that I wouldn't like to see continue.

Again, very few of us are excellent C programmers - I'm sure you
wouldn't want any patches we have to offer there.  We have spent
considerable time and resources on things like gitcasts (which github
sponsors for me), and on libraries and tools like ticgit (which is
being included in the next Debian release) and Grit (a ruby/git
library that runs Gitorious, and probably most other web-based Git
repos), and will be contributing back improvements to ssh libraries
that allow for the sort of traffic they have to deal with.  They have
also been looking to fund further open-source git related projects (in
case any of you are interested, btw) :

http://github.com/blog/107-supercharged-ruby-git

> Just my personal opinion, but GitHub doesn't provoke any warm fuzzy f=
eelings
> here. Quite the contrary. I actively dislike it.
>
> Cheers,
> Wincent

I'm sorry you don't like us, but we're really not that bad.  If you're
in the SF bay area sometime, send me a note and I'll take you out for
a beer and we can discuss what else we can do :)

Scott
