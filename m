From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Branches & directories
Date: Mon, 22 Aug 2011 11:49:07 -0700
Message-ID: <CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
	<CABNdCrCbSqup1=D2eEbGDhw3JzZGYHWLVqZFsB6GDO4Vk7HRxg@mail.gmail.com>
	<7vvctvdf5r.fsf@alter.siamese.dyndns.org>
	<CAE1pOi3rqqcz_6QxB8=g2jWOF-4SRZee7t8NXN1md2C4DL7wug@mail.gmail.com>
	<CAMOZ1BsZvXsnnWAPXR7UGKdqOMwuGB-ffaAPk55U_1dcjZUcDw@mail.gmail.com>
	<CAE1pOi2r9DT3Y-GxivTZRaNVi=qLOy5=QpQ-_YysOkgqy3iGRQ@mail.gmail.com>
	<CAMOZ1BvpnP_729YOHrrPW3B8wa5c4cLyD_qAQ5rTuy0JqNiiXg@mail.gmail.com>
	<CAE1pOi3OEFg7-OeQM0fvD69gf-5oPQ239CGy9nN0Waas8EM3Bg@mail.gmail.com>
	<CAMOZ1BvHKTPPmfB7Jx+y4OeRv-uwjmQkscXaRr-vEEy30G_Kdw@mail.gmail.com>
	<CAE1pOi0b2w8t53U7PSvVwVxZF9O0HTyfCR4vy+-baBjqCDeNJA@mail.gmail.com>
	<CAMOZ1BtOkwVbC3RyJVQb7K1DRMnJf3_omn7zrkzoE48Ayu7HBg@mail.gmail.com>
	<CAE1pOi0jZT_HCEV8UDzEOQeuCcDeqxoKGUEk3bJm=O2eJSHfkg@mail.gmail.com>
	<CAMOZ1Bu5pPeviyZD-e6aHbv-+tSaBDyyKb5vHA132K_3=1gD-g@mail.gmail.com>
	<CAE1pOi0dL2qNMksuY_=gyGSRsfr6e9AmzgJUNB=jEz85sjuiUw@mail.gmail.com>
	<CAGZ=bqK7H3zc8LK7EP8+uV8DpWW+czK2POfceGtcBF8Vmkhkow@mail.gmail.com>
	<CAE1pOi1J5DKtnyUQzu1K7G1+HLsWWCN7thCf6W8MwSzt4_vtOw@mail.gmail.com>
	<CAGZ=bqLZoLoyMcvnppg6SyFtJU8phSquQeBZ7uhwP=+ZL3DADw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Kyle Moffett <kyle@moffetthome.net>
X-From: git-owner@vger.kernel.org Mon Aug 22 20:49:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvZYp-0006dS-Po
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 20:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288Ab1HVStM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Aug 2011 14:49:12 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:62102 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840Ab1HVStI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Aug 2011 14:49:08 -0400
Received: by yie30 with SMTP id 30so3792879yie.19
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 11:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=TA7LPRUrNf8GuAS1Bw7COpEktdMKmf1o1Go+KPo+qfw=;
        b=IlpqsfE8eNkASCaNtmCm6pJckCITVVk4QWFzZYVeO1W+S66VL/mXiaqWLCeaWQdIja
         h36Dzpm5YzqdpnYe/E9Fb/nqgTc7LcIPMXfZELJC4rQvLyL1+4Umf6rQzW5pRnieMF8m
         x6QjZbi9uNQEAyYWRcA6oxAHn871L+IdVYqoA=
Received: by 10.236.136.135 with SMTP id w7mr17258967yhi.51.1314038947985;
 Mon, 22 Aug 2011 11:49:07 -0700 (PDT)
Received: by 10.236.207.67 with HTTP; Mon, 22 Aug 2011 11:49:07 -0700 (PDT)
In-Reply-To: <CAGZ=bqLZoLoyMcvnppg6SyFtJU8phSquQeBZ7uhwP=+ZL3DADw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179879>

On 22 August 2011 05:46, Kyle Moffett <kyle@moffetthome.net> wrote:
> On Mon, Aug 22, 2011 at 01:36, Hilco Wijbenga <hilco.wijbenga@gmail.c=
om> wrote:
>> On 21 August 2011 20:01, Kyle Moffett <kyle@moffetthome.net> wrote:
>>> On Sun, Aug 21, 2011 at 22:13, Hilco Wijbenga <hilco.wijbenga@gmail=
=2Ecom> wrote:
>>>> Thanks for sticking it out. :-) That all makes sense. I think it's=
 all
>>>> pretty clear now.
>>>
>>> It's worth mentioning that in most cases you DON'T want to delete u=
ntracked and
>>> ignored files when switching branches.
>>
>> For the record, I don't want them deleted but replaced with the
>> artifacts in the other branch. A bit wasteful but it saves a lot of
>> build time.
>>
>>> For example, when I'm doing kernel development, I will frequently d=
o this:
>>>
>>> $ git checkout -b my-new-feature origin/master
>>> [...hack hack hack...]
>>> $ make -j16 && make install && reboot
>>> [...find unrelated bug...]
>>> $ git checkout -b my-new-bugfix origin/master
>>> [...fix the bug...]
>>> $ make -j16 && make install && reboot
>>> $ git commit -m 'I fixed this bug'
>>> $ git checkout my-new-feature
>>> $ git rebase my-new-bugfix
>>> $ make -j16 && make install && reboot
>>>
>>> To avoid wasting time I don't want to completely rebuild the kernel=
 each
>>> and every time I switch branches, I just want to rebuild the files =
that
>>> changed when I switched. =C2=A0The way GIT works lets me do that qu=
ite
>>> easily, and the kernel Makefiles detect the changed files and rebui=
ld
>>> the minimum amount necessary.
>>>
>>> GIT's behavior when you switch between branches is effectively the
>>> same as applying a patch generated by diffing between the two
>>> branches. =C2=A0Any files which would not be changed are left alone=
, their
>>> timestamps completely unchanged.
>>
>> For small changes that makes perfect sense. I'm at a stage where API=
s
>> are still evolving and changing an API means rebuilding lots of code=
=2E
>> I'd like to avoid that.
>>
>>> It sounds like Eclipse is simply not detecting changes to your work=
ing
>>> tree by outside programs, and as a result it's not rebuilding files=
 and
>>> indexes the way that it should.
>>
>> While Eclipse isn't great at detecting such changes, this isn't real=
ly
>> an Eclipse problem. It's just that lots of things are still changing
>> and that leads to lots of building.
>>
>>> Obviously the easiest way to work around that issue is "git clean",
>>> which has options to select all untracked files or just ignored one=
s.
>>
>> As I mentioned above, I don't want to *delete* untracked/ignored
>> files, I just want them to stick to the branch I was working on. So =
if
>> I change to a different branch I get the appropriate build artifacts=
=2E
>>
>> Something like: git stash --everything "All artifacts for
>> this-branch." && git checkout other-branch && git stash apply
>> stash-for-other-branch.
>
> When I am in those sorts of situations I generally just use separate
> working directories or separate checkouts entirely; if you really pre=
fer
> to have everything in one directory you would be better served by
> integrating "ccache" into your workflow.

Unfortunately, that seems for C/C++ code only. I use Java. Besides,
it's not the Java compilation that takes most of the time.

> In particular, even "git stash" intentionally does not preserve file =
times,
> so you would end up rebuilding everything anyways because all of your
> source files would be as new as your object files.

Yes, I just noticed that. Why do you say "intentionally"? Is extra
work being done to make it so? If yes, then shouldn't that be
configurable?

Cheers,
Hilco
