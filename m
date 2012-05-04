From: Nathan Gray <n8gray@n8gray.org>
Subject: Re: Newbie grief
Date: Fri, 4 May 2012 09:46:04 -0700
Message-ID: <CA+7g9Jx20q6C8JqrcrmbWhYNH1K35Gwp_BAckjM=8qg1kMwU4Q@mail.gmail.com>
References: <4F9F128C.5020304@palm.com>
	<201204302331.q3UNVo7o032303@no.baka.org>
	<4F9F28F5.2020403@palm.com>
	<201205010137.q411bxaU002449@no.baka.org>
	<4F9F52B9.9060508@palm.com>
	<08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>
	<4FA2D8EA.7030809@palm.com>
	<87obq5ggpu.fsf@an-dro.info.enstb.org>
	<7vehr1dl2z.fsf@alter.siamese.dyndns.org>
	<4FA307C5.102@palm.com>
	<4FA3090D.5080406@palm.com>
	<4FA32A6A.4070007@blizzard.com>
	<CA+7g9Jxp859st6SrViizwOMrU9vsnmfy6P64SK9y_-ZEzEB6Mw@mail.gmail.com>
	<1167779eee7d442b9db0eecb347d5516-mfwitten@gmail.com>
	<7vmx5ocyc3.fsf@alter.siamese.dyndns.org>
	<1336126182.3490.28.camel@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Witten <mfwitten@gmail.com>,
	Illia Bobyr <ibobyr@blizzard.com>,
	Rich Pixley <rich.pixley@palm.com>,
	Ronan Keryell <Ronan.Keryell@hpc-project.com>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri May 04 18:46:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQLe2-0005Xp-GK
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 18:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048Ab2EDQqJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 12:46:09 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61781 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab2EDQqH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 12:46:07 -0400
Received: by bkcji2 with SMTP id ji2so2376035bkc.19
        for <git@vger.kernel.org>; Fri, 04 May 2012 09:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=x5vYU7+xkNex03hIL+0N9sZssBGhU/KD+tSzTmMn9Xg=;
        b=MfMDAeCtaarxcCvs43XVyMWSVGZ2yydqKMzsw7w8kWXTJkhDV3Gk6stHpkP0MxMBkN
         rIELyATKKA9UiFlNBmbfalqVgxcurSCM+hUm6ZfQ7vHXw+r9uq06EXXfMYZYdoffYdjs
         4mn2ugNofOT1iGue4zn45KVsPvlGDg0Bs1mTK1SorbwGSi4SeNfrVUcERq7fwRTCV1cP
         bRNfXsEAj5KKk8LMp9xWwB1pl9JKbGLABXH/3Iq6FdgUXJRmNGP2g7S9qpwvhgD3LC9x
         C39Vb/D7c3/OnR+YehqtKc7q5QXP5+5cRnVKfnxVPHOPwzBuHsSdppFfcdn8sPjf4aea
         xh7w==
Received: by 10.204.150.92 with SMTP id x28mr2370380bkv.61.1336149965098; Fri,
 04 May 2012 09:46:05 -0700 (PDT)
Received: by 10.204.224.141 with HTTP; Fri, 4 May 2012 09:46:04 -0700 (PDT)
X-Originating-IP: [184.182.186.242]
In-Reply-To: <1336126182.3490.28.camel@beez.lab.cmartin.tk>
X-Gm-Message-State: ALoCoQnJNaHYCnmPuhhTuYlwTsWNTYAaYbPTsD3KwNdEmDH89Dmz1dp5fLGDG+XNo6xrS7up1bK5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197037>

On Fri, May 4, 2012 at 3:09 AM, Carlos Mart=EDn Nieto <cmn@elego.de> wr=
ote:
> On Thu, 2012-05-03 at 22:25 -0700, Junio C Hamano wrote:
>> Michael Witten <mfwitten@gmail.com> writes:
>>
>> > As for a seemingly conservative suggestion, how about using a litt=
le
>> > more structural white space:
>> >
>> > =A0 To $uri_for_central_repo
>> > =A0 =A0! [rejected] =A0 =A0 =A0 =A0HEAD -> feature_0 (non-fast-for=
ward)
>> >
>> > =A0 error: failed to push some refs to '$uri_for_central_repo'
>> >
>> > =A0 To prevent you from losing history, non-fast-forward updates w=
ere rejected
>> > =A0 Merge the remote changes (e.g. 'git pull') before pushing agai=
n. =A0See the
>> > =A0 'Note about fast-forwards' section of 'git push --help' for de=
tails.
>> >
>
> Most of the first sentence repeats what we can see above. Restating t=
hat
> non-ff updates were rejected doesn't add information and doesn't help
> people who don't already know what a non-ff update is, so it's either
> redundant or not helpful[0]. So lets see if we can come up with a
> friendlier way of saying it. Maybe something like:
>
> =A0 =A0To $uri_for_central_repo
> =A0 =A0! [rejected] =A0 =A0 =A0 =A0HEAD -> feature_0 (non-fast-forwar=
d)
>
> =A0 =A0error: failed to push some refs to '$uri_for_central_repo'
>
> =A0 =A0Some updates which might rewrite history and lose someone else=
's
> =A0 =A0changes were rejected. Merge those changes (e.g. 'git pull') t=
o
> =A0 =A0incorporate that history. See the 'Note about fast-forwards' s=
ection
> =A0 =A0of 'git push --help' for details.
>
> It may be a bit longer, but if you don't know what a non-ff is or why
> it's a problem, this text should help you a lot more than the previou=
s
> one did. Not reading the documentation (specially when the error mess=
age
> points you to a specific section for a longer explanation) is still n=
o
> excuse for not known what's going on, but if you've been working on y=
our
> own for a while, you might have forgotten what this is all about.[1]

The whitespace that Michael introduced is a big help, for starters,
and this rewording is also a nice step forward.  I'm still not
thrilled about the "rewriting history" verbiage -- that makes it sound
like the user did something super risky and was rescued by the system.
 Here's my suggestion for replacing the last paragraph:

  Some of your branches are out of date.  Merge the remote changes
(e.g. 'git pull') then try again.

It's short and easy to scan.  It has no git-specific jargon that new
users would be unfamiliar with.  There's no reference to fast-forward
updates so no need to refer the user to that help section.  What do
you think?

Cheers,
-n8

--=20
HexaLex: A New Angle on Crossword Games for iPhone and iPod Touch
http://hexalex.com
On The App Store: http://bit.ly/8Mj1CU
On Facebook: http://bit.ly/9MIJiV
On Twitter: http://twitter.com/hexalexgame
http://n8gray.org
