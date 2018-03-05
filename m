Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6A001F404
	for <e@80x24.org>; Mon,  5 Mar 2018 16:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbeCEQmb (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 11:42:31 -0500
Received: from mout.gmx.net ([212.227.15.19]:44641 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbeCEQma (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 11:42:30 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LaXIV-1ePZyL2UYB-00mO2H; Mon, 05
 Mar 2018 17:42:22 +0100
Date:   Mon, 5 Mar 2018 17:42:21 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [RFC] Contributing to Git (on Windows)
In-Reply-To: <20180303182723.GA76934@aiede.svl.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1803051711210.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <176408fc-3645-66d3-2aa3-30ca3fa723e7@gmail.com> <20180302044409.GC238112@aiede.svl.corp.google.com> <xmqq606ee89v.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803031721590.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180303182723.GA76934@aiede.svl.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:CPiFvDNfHYKfF/RmLTnmOdbW7YK+KLDSuBoZNiM5GM0OZ5N3qUD
 neSS+88BRgTuO+vdvO0+iaLExlRpvsS43zBswaRttoDrhtPDvL+tiObOybf9MRVrgqyhnFZ
 xPoytIft8veBak2J7Kp1wbJp2u9nblYOYRAcszmPY1NTuEdxyD12PTK5re1Ca0Vg3BSkybK
 kvtwrhi3WNZwi6BmYCSUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:El2sZMtOzE8=:sIrR8Ddv6IIUd8TM3bs/nX
 0i1xd8p2usr5bP3Ai34VaEQuwoW4WnoMByiUKswoA6JBdtr0yAruuPqNKAe28o5wILHChffCs
 ZK1qpZMSomiW4lnfUHV8wTuYypBjKWvi7QXxOm2rPf/WfuvlQMupIxWrrkn5bqUrqoV51sxmI
 lmW58eRjtRQ5mWlvNr/sYgd96BD7V07cLSyWoU2QyPSmpK7vkTyAgGr1Oq/07uVQL9p/gaPrm
 44LgDQTxcyRUFZwLbTD6LRVyK5KCPD/0bttuzFKD2b4P+VPhcZtJe2ENQNN9y2CyUP4tBsTI5
 zxAy9hs/IkGbEp5yENmTw/E6gkzx1MZADFW8E+ADEBmYW6h/tvOgcUaPgdRjjauvIb6R0vkoZ
 Mgt6cnbXUAymaL4j+YA9Vqs4ZSwkt3ytAju7dBBWVCzDGmoO0nLs2+nhK+eqrGKr2UZVwpJc+
 xVBlwxInwbwrBkYqV/pwWsokhD0xQFcqgouivBdHJA7sf73v3vxUX/RV4ShAHOqvptZgv5AJ/
 zCukL15kTAToqQp+ILmAE/KXhbXueq7XzmF3N1fCcR4R4bEkovABV+/TIY0JMJf+RZl0eckVC
 lDXOoIsD/Ay5AI90SU3ZBfsgH42rANPvzXr5jE/D0l5gtO5Qp7I9i/MnU2hEvpfZ1g3cjSx1E
 qht3mDLxyAXoNwc0o1GI0kDTN/4DELnFuWOHG+4z+y084Kjy2xwZCLxYASP7VOlqlXpmF/7IO
 nfFQeH3VOaqYhXsjYVsqpN0oeYnh7ZzM5Zyn12qEEb/bc5xrywcZu+iKVFnRB4R3aqGX9mgPP
 8mOdkDsFSO+Lx0nQ4stLiTw6A7HkGlGnF5We63kuWOuY6UJz30bgv4sImmX2cppwwhi7zWo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Sat, 3 Mar 2018, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> >> Jonathan Nieder <jrnieder@gmail.com> writes:
> >>> Dereck Stolee wrote:
> 
> >>>> +Test Your Changes on Linux
> >>>> +--------------------------
> >>>> +
> >>>> +It can be important to work directly on the [core Git
> >>>> codebase](https://github.com/git/git), +such as a recent commit into
> >>>> the `master` or `next` branch that has not been incorporated +into
> >>>> Git for Windows. Also, it can help to run functional and performance
> >>>> tests on your +code in Linux before submitting patches to the
> >>>> Linux-focused mailing list.
> >>>
> >>> I'm surprised at this advice.  Does it actually come up?
> >
> > Yes.
> >
> > I personally set up the automated builds on Windows, Linux and macOS for
> > our team, and as a rule we always open an internal Pull Request on our
> > topic branches as we develop them, and you would probably not believe the
> > number of issues we caught before sending the patches to this list. Issues
> > including
> [nice list snipped]
> 
> Thanks for explaining.  I still am going to push back on the wording
> here, and here is why:
> 
>  1. Approximately 1/2 of the differences you describe apply to Mac as
>     well as Windows.

No. The executable bit, the native line endings, most of the issues I
listed do not catch macOS-based developers off guard.

> The advice certainly does not apply on Mac.

That is true.

Stolee agreed in the PR to mention alternatives to Hyper-V, such as
VirtualBox, which would help macOS-based developers here.

>     You might object: Mac readers would not be reading this text!  But
>     that is not how humans work: if project documentation (e.g. the
>     CONTRIBUTING.md on GitHub!) says that the project is Linux-focused
>     and if you don't test on Linux then you might as well not bother,
>     then people are going to believe it.

I thought the document encourages to test on Linux. It does not claim that
you can forget about getting your patches accepted if you don't test on
Linux.

>  2. It is not unusual for Linux users to make portability mistakes that
>     are quickly pointed out on list.  If anything, the advice to test on
>     other platforms should apply to contributors on Linux even more.
>     This happens especially often to new contributors, who sometimes use
>     bashisms, etc that get quickly pointed out.

True. Maybe this document is not for Linux-based developers, then. I might
over-generalize here, but in my experience, Windows-based developers were
particularly uneasy about getting what they perceived as criticized, and
for those developers it is that I want tools to tell them what is wrong.
It makes it much easier to accept.

>  3. I do not *want* Git to be a Linux-focused project; I want the code
>     to perform well on all popular platforms and for people not to be
>     afraid to make it so.

Me, too.

Realistically, though, way more than half of the reviewers on the Git
mailing list use Linux, and rarely switch to any other OS even for
testing.

The Google gang (you & Junio included) uses Linux. Peff uses Linux. From
what I can see Duy, Eric and Jake use Linux. That covers already the most
active reviewers right there.

So in order to get patches accepted (and that is the goal of a
contributor), chances can be improved by making stuff work on Linux.

>     If the docs say that all we care about is Linux, then people are
>     likely to be too scared to do the necessary and valuable work of
>     making it work well on Mac, Windows, etc.  The actual mix of
>     contributors doesn't bear it out anyway: a large number of
>     contributors are already on Mac or Windows.

This document targets Windows-based developers. So they will already have
made sure that it works well on Windows.

Also, putting the burden of testing portability on first-time contributors
is really what will scare them away. So don't pretend that you want to
avoid scaring them if you talk about portability.

> Fortunately this is pretty straightforward to fix in the doc: it could
> say something like "to the multi-platform focused mailing list", for
> example.

You know what? I'd rather not. Seriously. I am already uneasy with
suggesting to install a full-fledged Linux VM, but I think it will
ultimately help contributors *not* to get scared away already by the first
volley of reviewer comments.

> [...]
> > To my chagrin, this idea of making most of the boring stuff (and I include
> > formatting in that category, but I am probably special in that respect) as
> > automatable, and as little of an issue for review as possible, leaving
> > most brain cycles to work on the correctness of the patches instead, did
> > not really receive a lot of traction on this mailing list.
> 
> Huh?  I'm confident that this is a pretty widely supported idea within
> the Git project.
> 
> I get the feeling you must have misread something or misinterpreted a
> different response.

So where is that formatter call that fixes your code? Where is that
statement that says that we have a consistent code formatting, and don't
let taste override automatic formatting settings?

As long as you allow taste to rule the coding style where automated tools
could prettify code consistently, you will always have those discussions
(that I personally really dislike, as I find that they distract from my
*code*).

> [...]
> > No, this advice comes straight from my personal observation that the
> > reviewers on the Git mailing list are Linux-centric.
> 
> Hopefully the clarifications and suggestions higher in this message
> help.  If they don't, then I'm nervous about our ability to understand
> each other.

Okay, let me state what I think the goal of this document should be:

	To help Windows-based developers who want to contribute their first
	patch to the Git project.

Whatever makes it easier to contributors and is easily explained, should
go in, in my opinion.

Wishful thinking, and philosophical considerations, should probably stay
out.

Yes, in an ideal world contributors would read this document and then
understand what it takes to contribute to this heterogenous project. But
that is impractical. Already you and me disagree on many issues. Those
disagreements do not need to be part of that document.

> [...]
> > Now, how reasonable do I think it is to ask those contributors to purchase
> > an Apple machine to test their patches on macOS (you cannot just download
> > an .iso nor would it be legal to run a macOS VM on anything but Apple
> > hardware)? You probably guessed my answer: not at all.
> 
> Agreed, this is something that needs to be automated (and not via a
> CONTRIBUTING.md file).  As a stopgap, having a section in the
> contribution instructions about testing using Windows's Linux
> subsystem is a valuable thing, and thanks for that; I never meant to
> imply otherwise.

For the moment, we have Travis CI. Since it leaves out Windows, it does
not help my job one bit, and whatever I did to get Windows testing into
our Continuous Testing (it is *not* Continuous Integration, you probably
agree with me on *that*) is but a stop-gap measure.

I am part of the organization developing Visual Studio Team Services
(VSTS), the integrated DevOps solution also used to develop Windows using
the largest repository on this planet, and as such have the privilege of
being able to use it to my heart's extent.  It has build agents for
Windows, Linux and macOS. I hope to get a bit more time soon to play with
them and get some more robust testing in place by copy/editing the build
definitions I already use for our internal PRs.

The downside is that the logs are not public.

However, VSTS is free for teams up to five, meaning that any developer can
register a project, and once I manage to get build definitions in shape, I
can make them public and anybody can test their code on the major three
platforms, in their personal VSTS account.

> [...]
> > On Fri, 2 Mar 2018, Junio C Hamano wrote:
> 
> >> In fact, portability issues in a patch originally written for a platform
> >> is rather quickly discovered if the original platform is more minor than
> >> the others, so while it is good advice to test your ware before you make
> >> it public, singling out the portability issues may not add much value.
> >> The fewer number of obvious bugs remaining, the fewer number of
> >> iterations it would take for a series to get in a good shape.
> [...]
> > For you, Junio, however, the task *now* is to put yourself into the shoes
> > of a Computer Science student in their 2nd year who wants to become an
> > Open Source contributor and is a little afraid to talk directly to "the
> > core committers", and quite scared what negative feedback they might
> > receive.
> >
> > "What if they say my code is not good enough?"
> 
> Sure, though there is something implied in what is Junio is saying
> that is useful for such people.
> 
> It is patience.  It is the message that if you miss a portability bug,
> we won't be disappointed in you, and it in fact happens all the time
> to the best of contributors.
> 
> If there's a straightforward way to convey that in the text, I agree
> with Junio that it's worth conveying.

That is not how I read Junio's statement. I read it more like "If your
code is flawed, we'll let you know."

But I like your idea of conveying in the document that you can expect
kind and patient help in improving your patches. To somehow stave off the
feeling of getting criticized, and reframing it instead to tell
contributors that this is intended as helping.

Maybe you can write something to that end?

> [...]
> >>>> +When preparing your patch, it is important to put yourself in the
> >>>> shoes of the maintainer.
> >>>
> >>> ... and in the shoes of other users and developers working with Git down
> >>> the line who will interact with the patch later!
> >>>
> >>> Actually, the maintainer is one of the least important audiences for a
> >>> commit message.  But may 'the maintainer' is a stand-in for 'the
> >>> project' here?
> [...]
> > Is this not missing the point of this sentence? Those "senior reviewers"
> > also put themselves into the shoes of the maintainer, because considering
> > future readers is kind of the typical responsibility of the maintainer.
> 
> Only in the sense that what the project does is to "maintain".
> (Aside: is developing, deploying, supporting users part of
> maintenance?  I don't actually think so!  We can call it that if you
> like, though.).
> 
> To put this discussion on a more practical footing: I see new
> contributors confusing the maintainer for the audience for their
> changes all the time, and it hurts them.  They get some useful (and
> some unuseful, sadly) replies from the project and none from the
> maintainer and they end up confused: does this mean that the person
> that matters doesn't even care about my patch?

Ah! I really did misunderstand you. To me, that "put yourself in the shoes
of the maintainer" thing was only intended to write the code in a certain
way, not to raise expectations who would answer on the mailing list.

> Clarifying that the audience is *not* the maintainer can help.
> 
> I would not be surprised if the Git for Windows project works
> differently: maybe you have the time, inclination, and ability to
> respond to every contributor directly early in the process.  There's
> nothing wrong with that, and it probably helps to make the process
> easier for contributors with this particular confusion.  Having a
> single person that is ready to talk to them and can stand in for what
> the entire project needs can make their life easier.
> 
> But that's not sustainable in the Git project.  Larger projects either
> need multiple maintainers or a decrease in scope of the maintainer's
> role.  Junio uses the latter, which seems fine to me.
> 
> Even something as simple as s/maintainer/maintainers/ would make this
> text less misleading for people contributing to upstream Git.

Sure. Works for me.

> [...]
> >>>> +* Make sure the commits are signed off using `git commit
> >>>> (-s|--signoff)`. This means that you testify to be allowed to
> >>>> contribute your changes, in particular that if you did this on
> >>>> company time, said company approved to releasing your work as Open
> >>>> Source under the GNU Public License v2.
> >>>
> >>> Can this either point to or quote the relevant legal text from
> >>> Documentation/SubmittingPatches?  It feels dangerous (in the sense of,
> >>> potentially leading to misunderstandings and major future pain) to ask
> >>> people to sign off without them knowing exactly what that means.
> >>
> >> When you can point at an existing test in legal context, it is safer
> >> to do so rather than attempting to "rephrase" it yourself (unless
> >> you are a lawyer, of course, in which case you can assess the best
> >> course of action yourself).
> >
> > Please note: Documentation/SubmittingPatches is not a legal text. At least
> > I have not seen any accredited lawyer commenting on the validity of this
> > document, or how much sense it makes.
> 
> This seems to reflect a misunderstanding of how law works, at least in
> the United States.
> 
> I don't know how one would define what a legal text means.  I assume
> you mean "a contract", and I certainly don't care to evaluate whether
> some particular text is a contract: I am not a lawyer.
> 
> But there are all kinds of other actions or words with legal
> implications:
> 
>  - promises
>  - injuries
>  - etc, etc, etc
> 
> Basically anything someone ever does has potential legal implications.

So everything is a legal text.

> The developer's certificate of origin has been reviewed by plenty of
> lawyers.  You can have your own lawyers review it too if you like.
> 
> That's all side-stepping what I was saying, which is that it's bad for
> the project for people to be signing off without knowing what it
> means.

Yes, and I agree that the link needs to be there.

> [...]
> > Even so, Git for Windows' own wiki
> > (https://github.com/git-for-windows/git/wiki/Good-commits) links to a
> > particular version of Documentation/SubmittingPatches so that it can
> > specifically mark the DCO:
> >
> > https://github.com/git/git/blob/v2.8.1/Documentation/SubmittingPatches#L234-L286
> 
> Great.  That's the sort of thing I'm asking for in this new
> contributors document.  Why in the world is it useful to push back
> against such a request?

Oh, I was just taking exception with the expression "legal text" being
applied to something I consider a bit informal.

Put another way: I indulged in veering off on a tangent. You know, like we
do for fun here ;-)

Ciao,
Dscho
