From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Jonathan gives feedback --> flamewars inevitable? (Re: [PATCH v3]
 completion: add new _GIT_complete helper)
Date: Sat, 5 May 2012 20:23:33 +0200
Message-ID: <CAMP44s1SLb6CXMKxRDFUbxkg56dU3=ObZPZh7XxQC3vovNnvdw@mail.gmail.com>
References: <1336231400-6878-1-git-send-email-felipe.contreras@gmail.com>
	<20120505155423.GA14684@burratino>
	<CAMP44s1dhAjKt3mxVmg2+0qp-QTyjYb1knhxf+m177Cg2ZBC1Q@mail.gmail.com>
	<20120505164736.GC14684@burratino>
	<CAMP44s2NRMxuvQXk4RyqFYR=oQw_vrJhmbdwtXsrg=eHhGBS2w@mail.gmail.com>
	<20120505173327.GE14684@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 20:23:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQjdr-00022v-Nh
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 20:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757687Ab2EESXf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 May 2012 14:23:35 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35425 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757463Ab2EESXf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 14:23:35 -0400
Received: by wibhj6 with SMTP id hj6so2276214wib.1
        for <git@vger.kernel.org>; Sat, 05 May 2012 11:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=T8uXyZJI2+G6NVPLpO6GOEEQVID2zneKZwLurNZtcW4=;
        b=w5WlFZnCPr8AZzMkrScJQNa3rxi1vU3TBnTFtUVxoeXSf/O5xntAKM+S3SqDOUEksx
         Ca3nCro/lqak/CSBGLSQ7y1CFHjrJliK9oAi6/y5L6YxdVECKAZroCXg8Ti9xJ4DAR32
         SuBj6VICy2sCmytirEc9UZoyV/hZzx62gCH14zSgY3gmVrX9MgAZLn2/W++cuhxzTQx5
         JW8pBa0E2mbvP2DKvCCVRtOrzGhlF6LUgJiwtqQjiXukj5n0Zr7kALwsSDppSMGqeFPB
         lr5mTkVo9+a1o/PXw/BTaFjWyKROM+Lx2KjvPc+VAYHXx6Ln05Jvy+o4QR85bxnnj8k4
         TeJg==
Received: by 10.180.24.7 with SMTP id q7mr22108289wif.11.1336242213852; Sat,
 05 May 2012 11:23:33 -0700 (PDT)
Received: by 10.216.124.197 with HTTP; Sat, 5 May 2012 11:23:33 -0700 (PDT)
In-Reply-To: <20120505173327.GE14684@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197132>

On Sat, May 5, 2012 at 7:33 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Felipe Contreras wrote:
>
>> And I'd like to think that when you filibuster a discussion there's =
a
>> good reason for it.
>
> Kind other people on the list, please enlighten me. =C2=A0What did I =
say to
> trigger this crap?

You said "Because our completion scripts are already using this
convention, which happens to come from bash-completion's guidelines
and here are the reasons behind those", so their guidelines are not
essential, only the reasons behind the guidelines, but:

http://article.gmane.org/gmane.comp.version-control.git/195685
http://article.gmane.org/gmane.comp.version-control.git/195689
http://article.gmane.org/gmane.comp.version-control.git/195691
http://article.gmane.org/gmane.comp.shells.bash.completion.devel/3877

You could have skipped this, apparently it was not relevant for the
discussion, it's not feedback for the patch, and the abrasiveness
unnecessary.

http://article.gmane.org/gmane.comp.version-control.git/195719
http://article.gmane.org/gmane.comp.version-control.git/195723
http://article.gmane.org/gmane.comp.version-control.git/195737
http://article.gmane.org/gmane.comp.version-control.git/195742

And more irrelevant bash-completion stuff, and then you even get angry
when I suggest those guidelines were not there, but isn't supposed to
be irrelevant?

http://article.gmane.org/gmane.comp.version-control.git/195744

And then you finally assume that because I say the guidelines were not
there, I must not like namespace conventions. I don't see how that
helps in any way.

So the discussion about whether bash-completion actually had public
API guidelines or not took basically the whole thread, and barely
anything else got discussed. And now you say whether or not they had
this guidelines is not relevant.

If you had said "You know, I think they have this guideline, but it's
not really relevant, what is relevant is X" right when the topic of
bash-completion guidelines popped up, this thread would have looked
much different.

In addition to that you are saying that I shouldn't have took all
those mails as some kind of impediment from you, just feedback, even
though you say: "you refuse to put two and two together", or "OK, you
win", or "it isn't my responsibility to waste time arguing with you"
because I counter-argue your feedback.

I honestly don't know what to think. I guess I will think three times
before replying to your feedback... hopefully you won't take offense
in my silence as well =3D/

Cheers.

--=20
=46elipe Contreras
