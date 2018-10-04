Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58CB41F453
	for <e@80x24.org>; Thu,  4 Oct 2018 11:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeJDR4L (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 13:56:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:53327 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbeJDR4K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 13:56:10 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBIAz-1fxofG1eVB-00AEoy; Thu, 04
 Oct 2018 13:03:23 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBIAz-1fxofG1eVB-00AEoy; Thu, 04
 Oct 2018 13:03:23 +0200
Date:   Thu, 4 Oct 2018 13:03:27 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Chris Jeschke <chrisjberlin@googlemail.com>
cc:     sbeller@google.com, git@vger.kernel.org
Subject: Re: inside the git folder
In-Reply-To: <CADWf5z4DNRj=+X5pUF-Pe4vTq01OmFLk7KMP-=_hWWOEmsJg4A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810041257010.73@tvgsbejvaqbjf.bet>
References: <CADWf5z4pAR20qeoT1RnYENBB7Q5fA2fVVTNqPzMzvOE5Dq02qA@mail.gmail.com> <CAGZ79kZ=FXEgTgZ7hO_7O2Qo-ze9ykQW0_Vgr=m7MFe8mc9+Mg@mail.gmail.com> <CADWf5z4DNRj=+X5pUF-Pe4vTq01OmFLk7KMP-=_hWWOEmsJg4A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LFVhPGzJtt2oLssuvRhgR0HSc9G+Jgb8klXPjDGrBCQ5sexr4eV
 QCbSsVNrop7bf3yy42RTxJ/s1EnP4MpCiaYR9VIKkyldqiaQSEwj5mLZCsK0iGlz0J5SEGQ
 WFHY6rQOjOPE38bxGyBta3g048kJy5ozjWh4Gl7rjyKBTiWwjPeSIjVL+IAD7TlCWsgW4nd
 8kdsiqOEiOvjj0d0DjMHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:s3s18Zj9klA=:tS2ITkNQwPw1R61mA9kBQo
 BOQ8OTiVnieZrPCgc/1fWhvInROjUWO/IiP0XjOgmUpCpjni5+KmRgg0KQ6BFovuF/9Wklst5
 bV9FkYWX2h+HLq6Bk32pFY2+5rW764kf8V1+hztToR0wrHAKBt5QZK0sYAbjynxCUOMm/K30k
 nufa3EhoXWiYhvVYbipFxm4oKIluy/iKmdHePT1Obi1mbWSzm5Ss2yv0JlKMvMCCQ/edD/jMc
 904AepuRTF8No3XFMQZukvmPSTjRFJh1AQ9JNw9WIt/fQpZTa3MuWDZbiDGRXdTUeqm1ZQers
 W7X6ROPJzINiEkTuGu3irELvtmuiZ7EV/GPKv05K3GrnWM70mqrUUO3j801N4w/Dq1MVP1ZAw
 12OBLWvR/+4mKWfbtG1h0VAxMOl6QOXLaUi2BUoFv8mwzU9J5dXYiPvlwy5CJAfipBb0hQwsl
 RmBXw6iVxYb+5PitjupxHAxh7jkxmUc7sVtnTkMtipRWVxyZlhDQvbCO6q8qXtqLm1tijpbJS
 lB94eg1T9ZED1Iq8GcXIDkOJhVs/aahRXxtdEGpjJDH6fTl0k0I5dUTV/RB4f+8a4+dOxoGmy
 DPzIlMp6P0T+JYQc3C+OyD19oPNakQQS6pm5DZsHhFaIR94vfLODfueT+E4tZHoleiBL3Ahtw
 m2IQ24XJ1IEuag4Y1g+Qiarukd9QHeFCmPJmCkKCuMiWMN86ZAuRGQw3vCtSIvaiEVxxOGr6T
 YQ+Ni+00f5GrRhW0F7hR+wCkCdm1grzopAfv0FG01+/xjNdHpe4uRZ/52yVWJ4BYBH97Dui33
 NlF0u4E8oiJQwz4NZiTfcAh8c17wzYEFMrtNWKzxYCGWBETs8k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,

as mentioned by Stefan (who is a respected, active core Git contributor,
if you need any more arguments to listen to him), it is inappropriate to
copy the contents of the .git/ directory wholesale to another user's
machine.

For one, it would horribly break in case the user overrode `user.email` in
`.git/config`. That's one setting that should not be copied *anywhere*.
And that's just one, there are *plenty* more examples. Just think of
absolute paths referring to files that probably do not even exist on
another machine! Like, worktrees, etc.

Of course, you could start a list of exceptions (files, config keys, etc)
that should not be copied. But that's very fragile a solution.

So no, copying the .git/ directory is always the wrong thing to do, as
Stefan pointed out.

I could imagine that a much better idea is to identify a *positive* list
of things you want to copy over. The output of `git rev-parse
--symbolic-full-name HEAD`? Sure. Maybe even the output of `git rev-parse
--symbolic-full-name HEAD@{u}`? And then the URL of the corresponding
remote? Sure. `.git/objects/alternates/`? Absolutely not.

It is tedious, alright, but you simply cannot copy the contents of .git/
to another machine and expect that to work.

Ciao,
Johannes

On Thu, 4 Oct 2018, Chris Jeschke wrote:

> Hi Stefan,
> 
> thanks for your answer.
> 
> The Goal after sending the files is to have a copy on the remote site.
> This includes that the working directory is the same (what we already
> guarantee with our tool) and that git is at the same 'state' (that
> means that we have the same history and that we checkout at the same
> branch/commit).
> My idea:
> Send the working directory with our  tool
> Initialize a Git directory on the remote side
> Send the 'objects','refs', 'HEAD' and the 'gitignore' with our tool
> 
> Is there anything else I should take care of?
> 
> Am Mi., 3. Okt. 2018 um 20:51 Uhr schrieb Stefan Beller <sbeller@google.com>:
> >
> > On Wed, Oct 3, 2018 at 5:26 AM Chris Jeschke
> > <chrisjberlin@googlemail.com> wrote:
> > >
> > > Hey git-team,
> > > I am working on a plug-in for a distributed pair programming tool. To
> > > skip the details: I was thinking about sending parts of the git folder
> > > as a zip folder with our own Bytestream instead of using the git API.
> > > Is there a common sense about what should and what shouldn't be done
> > > when working with the files inside the git folder?
> >
> > This contradicts the security model of git.
> > Locally I can do things like:
> >     git config alias.co "rm -rf ~"
> >     echo "rm -rf ~" >.git/hooks/{...}
> > and I would experience bad things, but that is ok,
> > as I configured it locally (supposedly I know what
> > I am doing); but if I have the ability to send these
> > tricks to my beloved coworkers, hilarity might ensue.
> >
> > What stuff do you need to send around?
> >
> > objects? Fine, as the receive could check they are
> > good using fsck.
> >
> > refs/ ? Sure. It may be confusing to users,
> > but I am sure you'll figure UX out.
> >
> > local config, hooks ? I would not.
> >
> > Not sure what else you'd think of sending around.
> >
> > Cheers,
> > Stefan
> 
