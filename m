From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2011"
Date: Sun, 23 Sep 2012 11:47:26 +0200
Message-ID: <CANQwDwdJ0+hALB75Ckapdsz_qMO5iTYi_UkMDPqJg=6kB0Fd3w@mail.gmail.com>
References: <201107252233.02088.jnareb@gmail.com> <201109031738.11678.jnareb@gmail.com>
 <CAMP44s2ZSKx3jDZOSX7EM2bYtuUvvEctZYw6R3wNWQEbCeX4Rw@mail.gmail.com>
 <201109141939.14070.jnareb@gmail.com> <CAMP44s31xx5qfF4-f3kGsa1uEe7TMVmqSDvB9zL=prR12xwM6g@mail.gmail.com>
 <CANQwDwfVM+besf2if-z6UT6K1QYfj7A7jXsEgfyfxJ1Ww9oBdA@mail.gmail.com> <7v39292mao.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 11:48:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFinq-0003EG-KY
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 11:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551Ab2IWJrs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2012 05:47:48 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51270 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307Ab2IWJrr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Sep 2012 05:47:47 -0400
Received: by obbuo13 with SMTP id uo13so3827480obb.19
        for <git@vger.kernel.org>; Sun, 23 Sep 2012 02:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=dYt0kXxMjCq0p7v5heh1XDJ1B9t6Cw2SOHHhH6OhbeY=;
        b=mctpmmCdXya9hgf9bXWXMkC+dM9H9wRXt6QYG08iHOkYZWRTn4iRP9yUBeyFT2DCS7
         uWrz/getLuEehQN1FhgMwGSi1ocv1Um0trq9XnDhtboDYIlYvQWakH6yk11VpOC39Oud
         sLX/OGldaylaQHS90TLg819Z7ufGkEpGKMb+UFGgH7kGn35kCh6KwZXdjKmw4xobTdBT
         8LBxwNCebqmcZOZm8LwtnX3hVC5Xsb5H/DasDCgTVyJ6kC9V0MNtHEFiYEvxuQVka2jI
         G4LK5bkkj3Caz7BwNKuFoqWgfDXqPC7OSULW9i6maCqA3COHo+gJiVVpHhcrrqewjgNh
         2PZw==
Received: by 10.182.50.103 with SMTP id b7mr7602770obo.15.1348393666580; Sun,
 23 Sep 2012 02:47:46 -0700 (PDT)
Received: by 10.76.163.98 with HTTP; Sun, 23 Sep 2012 02:47:26 -0700 (PDT)
In-Reply-To: <7v39292mao.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206235>

On Sun, Sep 23, 2012 at 10:09 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>
>> I have created short (well, at least shorter than previous ones)
>> "Git User's Survey 2012" on Survs.com.  The test channel is
>>
>>   https://www.survs.com/survey/J87I3PDBU4
>>
>> Note that all answers in this channel would be deleted.
>>
>> I was thinking about running this survey for about three weeks, from
>> 24 September to 14 October 2012.  The current premium unlimited plan=
,
>> a gift from Survs.com admins, is valid till 26 October.  I don't kno=
w if it
>> would be prolonged; it usually was.
>>
>> As to what is involved in running survey: if we want and would be ab=
le to
>> use Survs.com, one should register there, and I can add them to "git=
"
>> account as a member with admin rights.
>
> Thanks for getting the ball rolling again this year.
>
> A few comments.
>
>   #5. Given that 1.8.0 will ship on Oct 21st, this may want to
>       include 1.8.0 as well.

Thanks for an information.
Done.

>   #7. Stop "backup", and leave that to 'other (please specify)'.
>       Also, "Frontend to other SCM" feels somewhat out of place.  It
>       would be interesting to see how "work vs personal" and "native
>       vs foreign" are correlated, for example, but this format does
>       not let you measure it.

I have split this question in two:

#7. What kind of projects etc. do you use Git for?
#8. I use Git for (check all that apply):

where the first question is about work..private direction, and the seco=
nd
one is now reducted to code, documentation, etc.

But now that I think of it, perhaps it might be interesting to put thos=
e
in the matrix form, where one direction would be work vs personal,
other code vs foreign.

>  #12. I am not sure why EGit applies and Eclipse doesn't.  Is it
>       like saying "vc.el applies but Emacs doesn't" (the former is
>       the interface, the latter is 'the other side' the interface
>       connects git to")?  If so it makes sense to me, but if EGit is
>       the only interface used to connect to Eclipse, perhaps it does
>       not help people who answer these questions to say this.

I have reworked / rewritten the description to this question.
What I wanted here is to not add editor/IDE which is used
only to edit files and create commit messages via core.editor,
but without any Git integration.

>  #13. This list is intelligible, at least to me.  "git add" but not
>       "git rm"?  What is "incremental add / commit"?  "git add -p"?
>       Is it worth asking about "update-index"?
>
>       It may be simpler to condense the questionaire down to the
>       following three questions:
>
>       - Do you use command line tool to build commit?
>         [Always/Often/Sometimes/Never]
>
>       - When you do, do you build the next commit incrementally with
>         "git add [-p]" and run "git commit" without the "-a" option?
>         [Always/Often/Sometimes/Never]
>
>       - What do you use if you do not commit with the command line?
>         GUI? IDE/Editor? FileManager? Web?

I have split this question in two:


#14. What tool do you use to create new commits?
#15. How do you create new commits?

The latter is about incremental commits etc.

I wonder if it would not make this survey too complicated to add
the tool vs how (i.e. rows from 14th rows, columns from 15th rows)
to complete 3rd dimension ;-)

>  #21. (nit) Isn't ProGit one of the "printed books (or ebooks)"?

I can add "other than above".

> I think the questions are designed to gauge the individual users
> (proficiency, background, etc.), but I think it would be interesting
> to see what kind of projects they are using Git for, but not in
> vague terms like #7 does.
>
> Even within "work projects - code", it would be enlightening to see
> a bit more details, e.g. Are they building phone app?  Controlling
> nuclear reactors?  Bioinformatics?

This is something hard to ask for... well, we could always use
free form question, but then the problem is with analyzing the
data, even if we don't get 10k answers like in last year.

>  How big is their team?

Do any of you have a proposal for sensible ranges? For example

 - 1
 - a few
 - several
 - 10-50
 - 50-150
 - more than 150

I think multiple choice would fit better here, with troubles analysing
and explaining how to format free-form, and people participating
in different projects.

> How is
> the project structured, e.g. a central repository where everybody
> pushes into?  Workers push to submission branches that are reviewed,
> approved and merged by the official committers?  Use of continuous
> integration?  Issue tracker integration?

Hmm... the question about workflows used could be interesting.
BTW. I have added to :kinds of tools" questions, e.g. about CI,
so this topic is more covered... I think.

--=20
Jakub Nar=C4=99bski
