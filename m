From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] Git User's Survey 2010 (resend)
Date: Sat, 10 Jul 2010 14:31:33 +0300
Message-ID: <AANLkTike2cKMtrHA12vsFjTI9MFne3oaRQoj1BQKoTrM@mail.gmail.com>
References: <201007032158.57700.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 10 13:31:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXYHb-00043S-AJ
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 13:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667Ab0GJLbk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Jul 2010 07:31:40 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61093 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015Ab0GJLbf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jul 2010 07:31:35 -0400
Received: by bwz1 with SMTP id 1so1604925bwz.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 04:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hO+s1TFxAO7g1OxvG45ft+/pipbmGp6MnTfZJBVevc0=;
        b=swouPDFIgfF9itss7uKFP8o/CrB6973Botl4Jsqkz+c1EIncP2a1bUrSwWmTntOffp
         6r9LjgFwMy1iXGJQgSeyoajetIfLe8B2bnjL/M7DmqsD8E5lzD/gW7n6/Ir4xJd++lMp
         HXep+BDAm05uDD7R40mc2KfQAEmPiXdmSAvVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cl78uB22gE/LGUnjrQBanxGT1Oh2RtCzVqwkwjlvHnEtDeWWWOA1N5BKAT4M/yXFia
         K83GBA4a/LkStS1GXmJ+8v/4tM/87jLph+ph5ZVzBysjoSwtH+5tShkGPv+biLavdwpE
         123EMCoU9qOxwvL7/4Ah/kwyh8ex/asUZGAOg=
Received: by 10.204.71.8 with SMTP id f8mr4103285bkj.81.1278761493685; Sat, 10 
	Jul 2010 04:31:33 -0700 (PDT)
Received: by 10.204.60.73 with HTTP; Sat, 10 Jul 2010 04:31:33 -0700 (PDT)
In-Reply-To: <201007032158.57700.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150720>

2010/7/3 Jakub Narebski <jnareb@gmail.com>:
> I guess it is time for annual (so far) Git User's Survey. =C2=A0Shoul=
d
> there be one? =C2=A0When should it start, and how long should it last=
?

Yes, I think there should definitely be one! IMO one month is enough.

> With more that 3000 responses in 2008 and 2009 survey, analysing
> free-form data was hard. =C2=A0That is why in this proposal there is =
only
> single one free-form response (about missing features).

That's a good idea.

> =3D=3D About you =3D=3D
>
> NOTES:
> ^^^^^^
> This section gives us a bit of demographical information about survey
> responders. =C2=A0Is it useful? =C2=A0Should we leave it in survey, o=
r remove it?
>
> Should we for example include 'gender' as one of questions? =C2=A0Per=
l Survey
> 2010 did.

I don't see the point of 'gender'. What does that tells us?

> =3D=3D=3D 02. How old are you (in years)? =3D=3D=3D
> (free-form single line)
>
> NOTES:
> ^^^^^^
> Instead of unconstrained free-form response it might be better to hav=
e
> single choice (or menu) of age ranges. =C2=A0What do you think? =C2=A0=
Of course with
> ranges there is question what ranges to use (how to quantize age); go=
o
> solution would be to chose ranges corresponding somewhat to the level=
s of
> education.

What's wrong with a free-form? I think that's easy and it works.

> =3D=3D=3D 10. What do you use to edit contents under version control =
with Git? =3D=3D=3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0What kind of editor, IDE or RAD you use wo=
rking with Git?
> (multiple choice, with other)
[...]
> NOTES:
> ^^^^^^
> Is this question useful, or should it be removed from survey?

I think this is useful to correlate communities.

> =3D=3D=3D 15. How do you publish/propagate your changes? =3D=3D=3D
> (multiple choice, with other)
[...]
> NOTES:
> ^^^^^^
> Should it stay, or should it be removed? =C2=A0I guess it can be
> interesting for git hosting sites... =C2=A0Should we have separate an=
swrs
> for different kinds of push (ssh, "dumb" HTTP(S) with WebDAV, "smart"
> HTTP - if it is possible, git:// protocol with push enabled)?

I think this question should stay. It would also help projects to
decide how to accept patches based on what most git users are familiar
with.

> =3D=3D=3D 16. Which of the following features do you use? =3D=3D=3D
> (multiple choice, with other)
[...]
> NOTES:
> ^^^^^^
> The problem is come up not with exhaustive list of features: there ar=
e
> too many of them to list. =C2=A0The problem is coming up with list of
> important and used enough often features.
>
> So: what features should be included in this list? =C2=A0What feature=
s
> should be removed from above list of answers?

I propose to add:
 + git stage/cache/index

We really are not sure how many people are actually aware of it, are we=
?

And IMO new features should go on the top.

> =3D=3D=3D 19. Overall, how happy are you with Git? =3D=3D=3D
> (single choice)
[...]
> NOTES:
> ^^^^^^
> I'm not sure if this question is at all useful.

I think it is. Otherwise how do we know that people are happy with it?

> =3D=3D=3D 20. In your opinion, which areas in Git need improvement? =3D=
=3D=3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Please state your preference.
> (matrix)
[...]
> NOTES:
> ^^^^^^
> Are there any general areas that are missing from this list?
> What are they?

How about:
 + communication channels

I think if users have trouble reporting issues, asking questions, we
should catch that.

> =3D=3D=3D 22. How do you compare the current version with the version=
 from one year ago? =3D=3D=3D
> (single choice)
[...]
> NOTES:
> ^^^^^^
> This question was mainly excuse for providing list of main changes
> from the year ago. =C2=A0I think that this question should be removed=
, as
> it doesn't bring any important information.

Yeah, and I think many people don't even notice the changes as they
come, but learn slowly features that have been there since a long time
ago.

> =3D=3D=3D 28. How did you hear about this Git User's Survey? =3D=3D=3D
> (single choice, with other)
[...]
> NOTES:
> ^^^^^^
> This list would of course be updated to reflect the list of (planned)
> announcement channels.

> Should I try to post announcement on mailing list for projects that
> use git? =C2=A0There are entirely too many such projects nowadays, an=
d such
> announcement can be considered spamming by some...

I still maintain that we need an official blog (not planet). Last year
the most popular way of finding about the survey was through blog
posts, but you argued that it was because you didn't spam mailing
lists.

http://article.gmane.org/gmane.comp.version-control.git/124609

I still think it's unnecessary to spam mailing lists, but if it helps
us reach considerably more people, we should do it.

Hopefully after this year's result we will know for sure ;)

Thanks for doing this. Cheers.

--=20
=46elipe Contreras
