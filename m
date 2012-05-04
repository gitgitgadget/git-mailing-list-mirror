From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Newbie grief
Date: Fri, 4 May 2012 19:22:27 +0000
Message-ID: <CAMOZ1BtoEPJfBRobLv6Vq9ACec718HX3qxm60cuWJ_oSguFw=Q@mail.gmail.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org>
 <4F9F28F5.2020403@palm.com> <201205010137.q411bxaU002449@no.baka.org>
 <4F9F52B9.9060508@palm.com> <08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>
 <4FA2D8EA.7030809@palm.com> <87obq5ggpu.fsf@an-dro.info.enstb.org>
 <7vehr1dl2z.fsf@alter.siamese.dyndns.org> <4FA307C5.102@palm.com>
 <4FA3090D.5080406@palm.com> <4FA32A6A.4070007@blizzard.com>
 <CA+7g9Jxp859st6SrViizwOMrU9vsnmfy6P64SK9y_-ZEzEB6Mw@mail.gmail.com>
 <1167779eee7d442b9db0eecb347d5516-mfwitten@gmail.com> <4FA418A7.2050100@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nathan Gray <n8gray@n8gray.org>,
	Junio C Hamano <gitster@pobox.com>,
	Illia Bobyr <ibobyr@blizzard.com>,
	Ronan Keryell <Ronan.Keryell@hpc-project.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Fri May 04 21:23:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQO5q-0002bM-9n
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 21:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138Ab2EDTXB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 15:23:01 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:46131 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997Ab2EDTW7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 15:22:59 -0400
Received: by qcro28 with SMTP id o28so860712qcr.19
        for <git@vger.kernel.org>; Fri, 04 May 2012 12:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=umXtc1SehExyXa2QBauI7kT0ZIUeLzxcjOo9DUAuUTY=;
        b=jj5Du+YjVIVUO81vYvglv+7Od222K1XXzDnTrhol9bBQq+4iRV9wQa/fianohi6NNV
         8WA7QOrZkDWWZDOb3Dm5T/wnxlvw8Fkfv19f6H2P6iT51Ij3X+X/UJCTmocIF1fGGWMd
         shUZ5TXQ8Ph31UFjrIdOcfIJ60LTrJYIqiLrt7+LLYfdbVMdQPGSbcmI7hek7iLLOt8D
         uP5+cEmHIQf3ICTzB7fN8cKk74acM23Xzg09qO6kkZUFBhxXPF8NA1rpCrMKjlUM1aio
         18wn2J/Xw8f55HrCTzBybRa0Ia4fSqRKMJL4/vW0RP2H19WRgTmZJ4Et9iccySbdvkYh
         2b1g==
Received: by 10.224.190.68 with SMTP id dh4mr12027175qab.5.1336159378983; Fri,
 04 May 2012 12:22:58 -0700 (PDT)
Received: by 10.229.122.13 with HTTP; Fri, 4 May 2012 12:22:27 -0700 (PDT)
In-Reply-To: <4FA418A7.2050100@palm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197055>

On Fri, May 4, 2012 at 5:57 PM, Rich Pixley <rich.pixley@palm.com> wrot=
e:
> On 5/3/12 21:35 , Michael Witten wrote:
>>
>> On Thu, 3 May 2012 20:13:01 -0700, Nathan Gray wrote:
>>
>>> On Thu, May 3, 2012 at 6:01 PM, Illia Bobyr<ibobyr@blizzard.com> =C2=
=A0wrote:
>>>>
>>>> It is just a "non-fast forward" move of a branch tip. =C2=A0This t=
erm
>>>> describes what happens precisely :)
>>>>
>>>> It is true, that the term is non obvious to the new comers.
>>>> One may google and get an explanation of the error pretty quickly.
>>>> First hit for "git non fast forward error" gives an explanation fr=
om a
>>>> new comer point of view for the simplest case.
>>>
>>> I just led a team of reasonably bright people through a transition
>>> from SVN to git. =C2=A0Not one of them understood this message. =C2=
=A0Every one
>>> of them thought something was broken. =C2=A0This is a very common
>>> occurrence, so a short, simple message without jargon for this erro=
r
>>> would be a big, big win.
>>
>> Well, what is your suggestion?
>>
>> Nobody in this thread has yet provided an explicit improvement becau=
se
>> the actual complaint is that the vast majority of people (including
>> supposed "professionals") don't RTFM; it never even occurs to them!
>>
>> Let's look at the message in question:
>>
>> =C2=A0 To $uri_for_central_repo
>> =C2=A0 =C2=A0! [rejected] =C2=A0 =C2=A0 =C2=A0 =C2=A0HEAD -> =C2=A0f=
eature_0 (non-fast-forward)
>> =C2=A0 error: failed to push some refs to '$uri_for_central_repo'
>> =C2=A0 To prevent you from losing history, non-fast-forward updates =
were
>> rejected
>> =C2=A0 Merge the remote changes (e.g. 'git pull') before pushing aga=
in. =C2=A0See
>> the
>> =C2=A0 'Note about fast-forwards' section of 'git push --help' for d=
etails.
>>
>> Not only does this already spoonfeed the reader with a suggested
>> command for getting back on track (i.e., 'git pull'), but it also
>> explicitly points out the relevant documentation and HOW to gain
>> immediate access to that information from the command line!
>
> Let's take it line by line.
>
> "Rejected - mumble" - the tool did not do what you asked.
> "error: failed to mumble" =C2=A0- your data is corrupt.
> "To prevent you mumble mumble" - you're not allowed to do what you wa=
nt
>
> I stopped reading there.

You are not somebody worth helping.

> I'm not saying this is a correct interpretation. =C2=A0I'm offering i=
t as a data
> point from a sophisticated, although new, user.

LOL
