From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2010 (resend)
Date: Mon, 5 Jul 2010 09:19:00 +0200
Message-ID: <201007050919.01490.jnareb@gmail.com>
References: <201007032158.57700.jnareb@gmail.com> <201007041314.50591.jnareb@gmail.com> <AANLkTim0HypdTEwsTUQ-G8C3mAoZ-7Ro3zB4z7-hpFq2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Bainbridge <david.bainbridge@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 05 09:19:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVfxo-00067u-3S
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 09:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544Ab0GEHTS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Jul 2010 03:19:18 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41453 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816Ab0GEHTP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 03:19:15 -0400
Received: by fxm14 with SMTP id 14so3378403fxm.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 00:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=m3IOUgFrKrciEQpff1T84wCw5MEgx0GaYpRmYqynHE4=;
        b=KdN8NtoZxXVKYCohJZ76O1W7OekEtWZfsUvh1NUxW8VsZ1tt0adow3U1JFRt8FmYhD
         D1c88siwzvbO1Ut4h8zW6ccxmapCFEWInqVyzjrL13KEAtylR0IXCMWHQgGM+eDqsI+d
         +ZViYT9mfqraigVwuWoXbxFxPgYljXoeyy9bw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Ob5mWkIZ5Nd9O6f1fvXmuAGSrBbyG+zGr9N2NXcQPc7Z8/DJNYmXjRHliAVAJUxPxl
         lWy6twexeWD0p+wqByoxyE7rLKRZSmPQzA4XCyNnhh4YyT6ga58yiItJEi+VmvhiAXJF
         9GillfuOlJUFqAJzBJeFayceMCkY51mXN2AxY=
Received: by 10.223.105.70 with SMTP id s6mr1813036fao.67.1278314353146;
        Mon, 05 Jul 2010 00:19:13 -0700 (PDT)
Received: from [192.168.1.15] (abvy158.neoplus.adsl.tpnet.pl [83.8.222.158])
        by mx.google.com with ESMTPS id h3sm8428123faj.44.2010.07.05.00.19.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Jul 2010 00:19:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTim0HypdTEwsTUQ-G8C3mAoZ-7Ro3zB4z7-hpFq2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150247>

On Sun, 4 July 2010, David Bainbridge wrote:

> It sounds like I was revisiting old territory in some cases :-)

Nevertheless the discussion is interesting.
>=20
> The thoughts about free text analysis were interesting though ...

Sidenote: analysis of free-form questions and of 'other, please specify=
'
responses was done with the help of program anyway.  But it only did
counting, and you had to categorize by hand.
>=20
> On 4 July 2010 13:14, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Sun, 4 July 2010, David Bainbridge wrote:
>>
>>> Have you considered the question: 'How long have you been using Git=
?'.
>>> This combined the expertise level might yield some useful informati=
on,
>>> and could provide some weighting for the 'Getting started' question=
s
>>> too. There are some problems with the question in that it could be,
>>> say, 2 years intermittent use, or 2 years continuous use, and these
>>> are different, of course.
>>
>> Well, such question was replaced by the question about one's own
>> proficiency in Git in 2009 survey (IIRC).
>>
>>>> =3D=3D=3D 06. Rate your own proficiency with Git: =3D=3D=3D
>>>> (single choice)
>>>>
>>>> =C2=A0* 1. novice
>>>> =C2=A0* 2. casual, needs advice
>>>> =C2=A0* 3. everyday use
>>>> =C2=A0* 4. can offer advice
>>>> =C2=A0* 5. know it very well
>>
>> The problem with question "How long have you been using Git?" (besid=
e
>> what you have mentioned) is that it is hard to answer correctly / in
>> detail for longer times.
>>
>> Perhaps something like this:
>>
>> =3D=3D=3D xx. How long have you been using Git? =3D=3D=3D
>> (single choice, with other)
>>
>> =C2=A0* less than week
>> =C2=A0* between a week and a month
>> =C2=A0* a few months
>> =C2=A0* a few years
>> =C2=A0* duration (please give units)
    * I don't remember
>>
>> What do you think?
>=20
> I think that the granularity is about right. I think we could imagine
> where we would expect people to be proficiency-wise with those
> periods. Not sure about the last option ... You have everything from
> days, to weeks to months to years in the main options. What did you
> have in mind?

Scratch last option.  What I had in mind that when people more or less
remember when the started using git, they could write e.g. "7 weeks",
or "5 months".  Let's leave only pre-defined answers... but leave
question about proficiency in git too; this would help distinguish
between continuous use and sporadic (intermittent) use.

>>> The demographic information is useful if you want to understand
>>> whether Git is (for example) considered less usable in countries wh=
ere
>>> English is not the native language. But then if you want to know th=
e
>>> native language of the user rather than where they live then perhap=
s
>>> this should be asked? (I was born in the UK, but now live in Sweden
>>> ... so I am perhaps more conscious of this!). Where you are born do=
es
>>> not necessarily identify your native language either.
>>
>> The problem with this question in the past was twofold: first, peopl=
e
>> sometimes mistok it for question about _programming languages. =C2=A0=
Second
>> should this question be about primary language / languages, or about
>> language ones prefer the computer to communicate with?
>=20
> Obviously you have been though this loop before! But perhaps if you
> are using drop-down lists then this makes it obvious what is required=
=2E
> I guess both the programming language, and the preferred interaction
> language could be relevant.
>=20
> We may want to know whether Git is more 'acceptable' to the Java
> community or the C/C++ community for example, or whether certain
> suggestions for improvement are coming from a community around a
> particular language.

I can bring back the question about programming languages, with or
without 'other, please specify' free-form answer.  I wonder about
wording: should it be (as before) about being "proficient" in the
programming language, or about simply "using with git"?  Should it
perhaps be matrix form, asking about proficiency in given programming
language?
=20
> Then with the human languages this could drive the localization of th=
e
> commands, as well as the documentation localization. Interesting ...

Yes, it would be interesting, as the localization is back (!) thanks
to =C3=86var's work on adding i18n infrastructure to git (C, shell, Per=
l)
for localizing command messages.

If this question is back, then perhaps also question about what
one would like to have localized: GUI tools (gitk, git-gui - they
are localized, but perhaps not in one's preferred language), command
messages (porcelain), documentation i.e. manpages (here for us is
a question about technology to use), commit message templates
(e.g. "Merge foo into bar", "Revert nnn").  Have I missed something?

By the way, the important question is also which questions to remove,
not only what questions to add.

>>> Do you want to separate work usage and 'non-work' usage at all? The
>>> two experiences may be completely different. If I am working at hom=
e I
>>> can use what ever I want, and work how I want. This will probably n=
ot
>>> be the case in a corporate environment, so I would report one set o=
f
>>> results for 'work' and another for 'non-work'. This could generate =
two
>>> survey returns for a single user. Is this intended?
>>
>> Hmmmm... food for though. =C2=A0It can be mentioned somewhere close =
to
>> beginning that one can fill this survey more than once (from differe=
nt
>> computers if using default version with cookies) for different roles
>> one plays. =C2=A0Perhaps with checkbox "additional role" (aka. "I ha=
ve already
>> filed this survey" ;-))...
>=20
> Thats sounds reasonable ... I think it is probably useful to capture =
a
> user-role response. The priorities of users and their needs may be
> completely different in a work situation.

Well, the version with specifying roles might be overly complicated.
I think it would be enough to have checkbox saying

  I have already filled this survey in different role

to catch number of responders as opposed to number of responses.

--=20
Jakub Narebski
Poland
