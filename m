From: Kyle Moffett <kyle@moffetthome.net>
Subject: Re: Branches & directories
Date: Mon, 22 Aug 2011 15:31:26 -0400
Message-ID: <CAGZ=bqLyS9tcpqztwGWFOXtDJRhugu+JYvz7wTnc0PTmECWX2g@mail.gmail.com>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
 <CABNdCrCbSqup1=D2eEbGDhw3JzZGYHWLVqZFsB6GDO4Vk7HRxg@mail.gmail.com>
 <7vvctvdf5r.fsf@alter.siamese.dyndns.org> <CAE1pOi3rqqcz_6QxB8=g2jWOF-4SRZee7t8NXN1md2C4DL7wug@mail.gmail.com>
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
 <CAGZ=bqLZoLoyMcvnppg6SyFtJU8phSquQeBZ7uhwP=+ZL3DADw@mail.gmail.com> <CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 21:31:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvaE2-0006tW-CC
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 21:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547Ab1HVTbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 15:31:50 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63502 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189Ab1HVTbt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 15:31:49 -0400
Received: by wyg24 with SMTP id 24so3726078wyg.19
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 12:31:48 -0700 (PDT)
Received: by 10.216.165.18 with SMTP id d18mr2253142wel.99.1314041506648; Mon,
 22 Aug 2011 12:31:46 -0700 (PDT)
Received: by 10.216.87.138 with HTTP; Mon, 22 Aug 2011 12:31:26 -0700 (PDT)
In-Reply-To: <CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179882>

On Mon, Aug 22, 2011 at 14:49, Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:
> On 22 August 2011 05:46, Kyle Moffett <kyle@moffetthome.net> wrote:
>> On Mon, Aug 22, 2011 at 01:36, Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:
>>> On 21 August 2011 20:01, Kyle Moffett <kyle@moffetthome.net> wrote:
>>>> Obviously the easiest way to work around that issue is "git clean",
>>>> which has options to select all untracked files or just ignored ones.
>>>
>>> As I mentioned above, I don't want to *delete* untracked/ignored
>>> files, I just want them to stick to the branch I was working on. So if
>>> I change to a different branch I get the appropriate build artifacts.
>>>
>>> Something like: git stash --everything "All artifacts for
>>> this-branch." && git checkout other-branch && git stash apply
>>> stash-for-other-branch.
>>
>> When I am in those sorts of situations I generally just use separate
>> working directories or separate checkouts entirely; if you really prefer
>> to have everything in one directory you would be better served by
>> integrating "ccache" into your workflow.
>
> Unfortunately, that seems for C/C++ code only. I use Java. Besides,
> it's not the Java compilation that takes most of the time.

Hm, that sounds like a very serious Eclipse limitation with almost all forms
of source control.  What is done with other VCSes (IE: Subversion, etc)?

>From this I believe the best option is to just make use of multiple separate
checkouts or worktrees.

>> In particular, even "git stash" intentionally does not preserve file times,
>> so you would end up rebuilding everything anyways because all of your
>> source files would be as new as your object files.
>
> Yes, I just noticed that. Why do you say "intentionally"? Is extra
> work being done to make it so? If yes, then shouldn't that be
> configurable?

Well, there's 2 reasons:

(1) The GIT data-structures simply have no place for file timestamps, and
"git stash" is simply a special way of dumping files into a temporary commit.
This is exactly the same as the

(2) You almost always *don't* want to preserve timestamps.  For example:

$ git checkout -b my-feature origin/master
$ vim some-file.c
$ make
$ git add some-file.c && git commit -m "A new feature"
$ git checkout -b my-bugfix origin/master
$ vim other-file.c
$ make

If GIT preserved timestamps, the second "make" would fail to rebuild the
product "some-file.o" because "some-file.c" is still older than it, even
though "some-file.c" has changed since the last build!!!

Really, GIT is only intended for storing source code.  If you want to store
other kinds of things (like timestamps, permissions, etc), then you need to
turn them into source code (IE: a text file and a "make install" target) and
then store them that way.

Cheers,
Kyle Moffett
