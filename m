From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] Git User's Survey 2010 (resend)
Date: Sun, 11 Jul 2010 12:57:13 +0300
Message-ID: <AANLkTikQF_tMHz28k2pdpVdtbnE6EDZiKQbwmMTlp-c9@mail.gmail.com>
References: <201007032158.57700.jnareb@gmail.com>
	<AANLkTike2cKMtrHA12vsFjTI9MFne3oaRQoj1BQKoTrM@mail.gmail.com>
	<201007102158.25961.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 11 11:57:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXtHt-00021O-Ps
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 11:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040Ab0GKJ5S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Jul 2010 05:57:18 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64463 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574Ab0GKJ5R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jul 2010 05:57:17 -0400
Received: by bwz1 with SMTP id 1so1866750bwz.19
        for <git@vger.kernel.org>; Sun, 11 Jul 2010 02:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JkfOIEN2kGHueLy8fcbwSm2ewtT3zZV1zXnFcBr9yoQ=;
        b=CWm1OeKWZWIutnp3XN2vH7eCDKrbOwG6GRtEiFUzfIQ94aJGR7z3B6+Hu6AaXqbKu5
         F95zWnykqb4yi2ruuVdxWo+RFvYCfZk+MOBPzw7sjY9ks3NqohalbjJwATA1NxdcswRC
         c4n43yB1chA53FCGF1go76RdVTHOl4fWyvl24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nktz//3FFg5kMyQLZk70GhihsWkreaSsDbiJYNpWCKwmm20kVdRZROSBh9Sab+vcyk
         S/tKIY+hoPqrasBHXLYMXaNpEz8SxfgA99sMVTfw86d2gRTeN02Kqc0NxBd9p05inQbb
         rTx9tfSqN9EwHXVbjOLMiElmE97an/GtW/00g=
Received: by 10.204.16.82 with SMTP id n18mr9524038bka.212.1278842233239; Sun, 
	11 Jul 2010 02:57:13 -0700 (PDT)
Received: by 10.204.60.73 with HTTP; Sun, 11 Jul 2010 02:57:13 -0700 (PDT)
In-Reply-To: <201007102158.25961.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150772>

On Sat, Jul 10, 2010 at 10:58 PM, Jakub Narebski <jnareb@gmail.com> wro=
te:
> On Sat, 10 July 2010, Felipe Contreras wrote:
>> 2010/7/3 Jakub Narebski <jnareb@gmail.com>:
>
>> > I guess it is time for annual (so far) Git User's Survey. =C2=A0Sh=
ould
>> > there be one? =C2=A0When should it start, and how long should it l=
ast?
>>
>> Yes, I think there should definitely be one! IMO one month is enough=
=2E
>
> By the way, I think it is important that Git User's Survey 2010 lasts
> past the holidays, i.e. into September or even October, even at the
> cost of lasting two months, and not one month.
>
> What do you think about this?

My feeling is that the longer it is, the easier it's for people to
postpone it, and then forget about it.

But I don't have a strong opinion either way.

>> > =3D=3D About you =3D=3D
>> >
>> > NOTES:
>> > ^^^^^^
>> > This section gives us a bit of demographical information about sur=
vey
>> > responders. =C2=A0Is it useful? =C2=A0Should we leave it in survey=
, or remove it?
>> >
>> > Should we for example include 'gender' as one of questions? =C2=A0=
Perl Survey
>> > 2010 did.
>>
>> I don't see the point of 'gender'. What does that tells us?
>
> Well, one can say that 'age' doesn't tell us much either.

I disagree. I think younger people, specially the ones who have not
been tainted by CVS, might find git easier to learn. Without this
question it's not possible to find that correlation.

>> > =3D=3D=3D 10. What do you use to edit contents under version contr=
ol with Git? =3D=3D=3D
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0What kind of editor, IDE or RAD you use=
 working with Git?
>> > (multiple choice, with other)
>> [...]
>> > NOTES:
>> > ^^^^^^
>> > Is this question useful, or should it be removed from survey?
>>
>> I think this is useful to correlate communities.
>
> Hmmm...

Sorry, I thought the answers would be the actual application used:
Vim, Eclipse, MS Visual Studio, etc. If not, then I don't see the
point.

At least I remember finding out that most people use vim in some
previous survey, and I found that interesting.

>> > =3D=3D=3D 19. Overall, how happy are you with Git? =3D=3D=3D
>> > (single choice)
>> [...]
>> > NOTES:
>> > ^^^^^^
>> > I'm not sure if this question is at all useful.
>>
>> I think it is. Otherwise how do we know that people are happy with i=
t?
>
> Well, I think there is rather heavy bias that if people are unhappy
> with Git, they wouldn't be using it (well, unless they have to), and
> they wouldn't be responding to this Git User's Survey (because they
> didn't found it, for example).

There's people that would rather be using something else for various
reasons, but need to use git. Also, there's people that think that git
is the best option, but not particularly ecstatic with it.

--=20
=46elipe Contreras
