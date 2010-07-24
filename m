From: skillzero@gmail.com
Subject: Re: Avery Pennarun's git-subtree?
Date: Sat, 24 Jul 2010 12:40:11 -0700
Message-ID: <AANLkTikx5EtQ0yvdkqN1Q1QAudFZfbd+_jpoa9ztLrz1@mail.gmail.com>
References: <4C472B48.8050101@gmail.com>
	<AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com>
	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com>
	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com>
	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com>
	<4C4778DE.9090905@web.de>
	<AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com>
	<m31vavn8la.fsf@localhost.localdomain>
	<AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com>
	<4C49B31F.8000102@xiplink.com>
	<AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com>
	<AANLkTinhd2DYh7WXzMvhMkqp98fYtTWWuQi0RSL9Rome@mail.gmail.com>
	<AANLkTimLayG_HFxGdq+Tt8hU_MApBpSdHHiYPxcakpRJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 21:46:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ockg6-0008Rj-QF
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 21:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756312Ab0GXTqT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 15:46:19 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56664 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756286Ab0GXTqS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jul 2010 15:46:18 -0400
Received: by gxk23 with SMTP id 23so513619gxk.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 12:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iJBnB2GgiSMp3etpbdbzVIOGCSzHvoJN04f91RtsId8=;
        b=Jpc+sxrK36t700OfDdmB2OfFpQIKZy09SuOK2zUiZusdC0DCPMTKxDVBkvEqvd64Mo
         X1iOEBi1x0Rw+t4K8+KyREUqUtwaFt3UpAnFu+oj3Om9w9/7h9CthzpJQ8m4wzauY0kW
         8//qjs9ATPMTJEkCEG48RgR+eqnCEwNmgNr5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nby7/S2vUmQ7Oq6JuRmkChnyr1/eTkjVxKArQHXH5o9r2TxijMnVLzUP/Z7TqUZvlX
         BdagcR4QgnUEoO55fKkd6tD/tNDbxlZWuAkWFp9rtTArzKvA2o5wcCg0Rgt4XBTGyscq
         +vFUYK3bZBeU+ZRjlS2RBKA5uwXwwBq9I8q1k=
Received: by 10.90.89.8 with SMTP id m8mr1555961agb.47.1280000411425; Sat, 24 
	Jul 2010 12:40:11 -0700 (PDT)
Received: by 10.90.177.3 with HTTP; Sat, 24 Jul 2010 12:40:11 -0700 (PDT)
In-Reply-To: <AANLkTimLayG_HFxGdq+Tt8hU_MApBpSdHHiYPxcakpRJ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151665>

On Fri, Jul 23, 2010 at 6:20 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> On Fri, Jul 23, 2010 at 8:58 PM, =C2=A0<skillzero@gmail.com> wrote:
>> On Fri, Jul 23, 2010 at 3:50 PM, Avery Pennarun <apenwarr@gmail.com>=
 wrote:
>>> Honest question: do you care about the wasted disk space and downlo=
ad
>>> time for these extra files? =C2=A0Or just the fact that git gets sl=
ow when
>>> you have them?
>>
>> I have the similar situation to the original poster (huge trees) and
>> for me it's all three: disk space, download time, and performance. M=
y
>> tree has a few relatively small (< 20 MB) shared directories of comm=
on
>> code, a few large (2-6 GB) directories of code for OS's, and then
>> several medium size (< 500 MB) directories for application code. The
>> application developers only care about the app+shared directories (a=
nd
>> are very annoyed by the massive space and performance impact of the =
OS
>> directories).
>
> Given how cheap disk space is nowadays, I'm curious about this. =C2=A0=
Are
> they really just annoyed by the performance problem, and they complai=
n
> about the extra size because they blame the performance on the extra
> files? =C2=A0Or are they honestly short of disk space?

I think it's both space and performance. When you're using SSD drives,
storage still pretty expensive. A 128 GB or less SSD is pretty common
in a laptop so you can run out pretty quick, especially when you're
working concurrently on a few different branches at the same time.
It's useful to keep multiple working copies (e.g. git-new-workdir)
because rebuild time can be significant when switching branches.

> Similarly, are all your developers located at the same office? =C2=A0=
If so,
> then bandwidth ought not be an issue.

Bandwidth isn't a big problem because you don't need to re-download
the repo very often. However, people work at home a lot where
bandwidth is more limited. The biggest complaint I hear about
bandwidth is that people tend to re-download when something goes wrong
(i.e. inexperience with git resulting in a repository they can't
recover due to git resets, etc).

> I'm pushing extra hard on this because I believe there are lots of
> opportunities to just improve git performance on huge repositories.
> And if the only *real* reason people need to split repositories is
> that performance goes down, then that's fixable, and you may need
> neither git-submodule nor git-subtree.

Performance degradation is my biggest complaint with large
repositories. Your inotify/FSEvents/etc daemon idea sounds interesting
to deal with the stat issue.

> This is indeed a problem with large repositories. =C2=A0Of course,
> splitting them with git-submodule is kind of cheating, because it jus=
t
> makes git-status *not look* to see if those files are dirty or not.
> If they are dirty and you forget to commit them, you'll never know
> until someone tells you later. =C2=A0It would be functionally equival=
ent to
> just have git-status not look inside certain subdirs of a single
> repository.

I think it's only cheating if you're using all of the submodules. The
main purpose of submodules for me (although I don't currently use
submodules) would be so I don't need to keep modules on disk that I
don't care about. If a developer is working on an app, they don't need
the OS directories/modules so they get much faster git status/etc and
there wouldn't be other directories to have dirty files in. That said,
if I was using git submodule, I'd want git status to show me all the
submodules that were checked out.

>> (although just having all those objects in
>> the .git directory still slows it down quite a bit).
>
> You're the second person who has mentioned this today (the first one
> was to me in a private email). =C2=A0I'd like to understand this bett=
er.

What I'm basing this on is that even when I'm using a sparse checkout
such that I have only a small subset of the files in my working
directory, git status seems singifncantly slower for me than an
equivalent git repository that only has that subset of files. That's
not very scientific, but that's what made me think just having a large
=2Egit directory with lots of objects/history slows down git status eve=
n
if the working copy doesn't have a lot of files.

I will try to experiment and see if I can narrow it down with some real=
 numbers.

BTW...what's the policy on CC'ing people on git mailing list replies?
Should it be trimmed or not? I've received complaints in the past, but
I was never really clear what the recommended policy is.
