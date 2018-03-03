Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A21CC1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 17:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeCCRes (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 12:34:48 -0500
Received: from mout.gmx.net ([212.227.17.21]:58479 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752116AbeCCRer (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 12:34:47 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXUmw-1fEfjy3uVi-00WYTo; Sat, 03
 Mar 2018 18:34:41 +0100
Date:   Sat, 3 Mar 2018 18:34:40 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [RFC] Contributing to Git (on Windows)
In-Reply-To: <xmqq606ee89v.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803031721590.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <176408fc-3645-66d3-2aa3-30ca3fa723e7@gmail.com> <20180302044409.GC238112@aiede.svl.corp.google.com> <xmqq606ee89v.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aMjSzSuHcfR6YAESGNGSeXkLWgtUxCzToyT/1EKj1zzp3TWu4yH
 GE6tFvj9Dpaw7zpmHy3n1RRZ7ZXDDi4/sQjaxznpsQy3e8u2Ekox7XvvPwQWs637903X58L
 syllrC6CCBtiAMJfdAzHh9tsuSdEybB5OluKDQ+Qu9KC/Z6PrI1ZF1eUwzPsPnQz2bDzrZ8
 loD+m0PfyAE3unqH522XQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MK491dj5C/Q=:eKifpSC6TnufPbx87eE3V+
 MG8cP6U9x8HzKs9szzGeZ9VIOoD/X2o7GI+WWA+z6TSrTRzWWCBX0jHvExRijNL9wRueyaKmr
 Q9mh1jUUIF5r1IpSS+EbUFUhJJHSX+4vPQXisoA+PjRysSybm76JThRKPiHvt0JqcrFIFtIFs
 elnWQBZeHOEE4AyFUIqf+PljfNvG175ZhDzIw7Fvmi+eTqmpkBXrsUym7fbb+1IVcRCLjFion
 58N4nUSOKXL8hdIEpY6LO48becxGJ8vklVtAZNLJlHAJoQPvO9RaKyusB2+BOwh1wLoQNOJ2N
 c0pafyCzijDI0zlE1yWsD//L0uF5XSI/1GtekLM8a3ig8+Egkpxbi/tvvSJrjPAOZGhM2I4zW
 Oupvu7qy3V2rzMnyFCniQHVB19ajzGbD90bEZU96kOhHK22R0zrROJ0V40yIA3BzJYbLKUy6F
 20gf/tBBh4quJqMdX5X0r+XgKTZE4JfhHBxYiL5D892LqCTOFXo9RMJT8+/pvirepdWfQVqek
 Vneck1G1benBL2e77xM16Ljf2EsPUcW3RvsVT6Zqbvz2+O9VEm8f84S0ATKFIc/ha6/djTRwb
 AHS/wJyrnPgWt+HQpvrinN8UBy8ARKuvXC0TDRfse24fIRCVgLRL44yVVyJX7YrXpQnOGCsAJ
 P4OygzD0Joh6BEmkbol/Ix3f0OnjRASRl7Z87WHe2cCox7DlpSOHpl8Jar/iCYSc1+bzcrljb
 T7CRm78mQ2eqWCOitjs5hqBQqfAx9gQ4IbVxyP6worSfihU78w8/DW3R6woJUDhc3G+bg9rbD
 /ByUqCxI6hSlnFfTl6SOuF1nbA6AKBgTUEwCZcFSrY++HDEhE7baFL5KZE3rc4FtnsgBQE/DR
 R5vxS1FBvUMrAY+jk3BK4sp0VO3ALIQj3i95CqDjoCLBinC4sI+db5OT0tyzIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 2 Mar 2018, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> >> +Test Your Changes on Linux
> >> +--------------------------
> >> +
> >> +It can be important to work directly on the [core Git
> >> codebase](https://github.com/git/git), +such as a recent commit into
> >> the `master` or `next` branch that has not been incorporated +into
> >> Git for Windows. Also, it can help to run functional and performance
> >> tests on your +code in Linux before submitting patches to the
> >> Linux-focused mailing list.
> >
> > I'm surprised at this advice.  Does it actually come up?

Yes.

I personally set up the automated builds on Windows, Linux and macOS for
our team, and as a rule we always open an internal Pull Request on our
topic branches as we develop them, and you would probably not believe the
number of issues we caught before sending the patches to this list. Issues
including

- scripts not being marked executable (on Windows, we don't care, but you
  Linux folks do),

- use of symbols that are only available on Windows, but that were not
  guarded by appropriate `#ifdef`s,

- printf formats available only on Windows,

- EOL_NATIVE differences,

- differences between BSD and GNU tools, such as the white-space in the
  output of `wc`, the syntactic differences of `sed`'s `-i` option,
  different options of the `stat` utility to do the same thing, etc
  (granted, this would not be caught when only testing on Windows and
  Linux, as both development environments would only use the GNU variety)

Of course, these builds also catch problems by setting DEVELOPER=1 which
developers might have forgotten to specify when building locally (it
really is too easy to forget).

> > When I was on Mac I never worried about this, nor when I was on
> > Windows.

I commend your boldness.

Of course, you are an old-timer. These instructions are intended for
new-timers, even first-timers, who may very well be very scared of reviews
criticizing them for, say, not marking a new test script as executable.

If you ever spoke to potential contributors who decided not to contribute
after all, and you dig a little deeper, you might get the same impression
as I got: they are (rightfully) scared of receiving answers with tons of
comments what they did wrong.

Most contributors seem to prefer to be "criticized" by tools, preferably
even during the build process, where they can fix things before anybody
sees their patches.

This is, for example, the reason why the cURL project has this really nice
`lib/checksrc.pl` script that they recommend you run to verify that the
code you wrote abides by a few of their source code conventions they have.
Developers run it, see what is wrong, fix it, and no human judges them.
They submit the code, and the discussions revolve about how to improve the
patch to cover more cases or some such.

For that same reason, namely to make it less harsh for new contributors, I
also tried to set up an automated job that tries to reformat patches using
`clang-format` (without forcing any contributor to try to set up a
bleeding-edge CLang, which can get very involved, very quickly) and pushes
an updated topic branch if changes were needed. Sadly, this job is broken
because I seem to be unable to get the `apt-get` commands right to get
CLang's nightly builds (this job runs on Linux).

To my chagrin, this idea of making most of the boring stuff (and I include
formatting in that category, but I am probably special in that respect) as
automatable, and as little of an issue for review as possible, leaving
most brain cycles to work on the correctness of the patches instead, did
not really receive a lot of traction on this mailing list.

We still have no satisfactory automated way to check contributors' patches
against our (quite fuzzy) coding style. Until that happens, contributors
will be constantly faced with reviews about overly long lines, about
grammar issues, about commit messages missing Signed-off-by: lines, about
commit messages that are too short, etc. Those are all comments that
not exactly make contributors feel welcome. And that comments also
distract from more interesting use of reviewers' time (such as suggesting
helper functions or data structures that the contributor could use to
simplify the patches).

But one thing that we *can* recommend to contributors (in particular
Windows-based ones) is to verify that their patches work also on Linux, so
that they can avoid receiving comments about that class of avoidable
issues.

> > I'm personally happy to review patches that haven't been tested on
> > Linux, though it's of course even nicer if the patch author mentions
> > what platforms they've tested on.

Jonathan, I don't want this to sound harsh... but... this contributors'
guide cares a little more about the feelings of the contributors than
yours? ;-)

Seriously again, you might not mind pointing out that a newly-added test
case is not marked executable. The emotional effect of such a comment on
an eager, first-time Open Source contributors is very different, though.
It is something that can turn a first-time contributor into a
one-time-only contributor.

> s/Linux/other platforms/, perhaps?

No, this advice comes straight from my personal observation that the
reviewers on the Git mailing list are Linux-centric.

And this advice served my colleagues very well, before we had set up the
automated Windows/Linux/macOS builds on our internal Pull Requests.

Plus. We need to stay reasonable. This guide is trying to guide first-time
contributors how to contribute to the Git project, with a slight bias
towards Windows-based contributors. It is very easy for them to get access
to a Linux VM: they simply use the Hyper-V Manager (or obtain VirtualBox)
and install a freely-downloadable Ubuntu .iso.

Now, how reasonable do I think it is to ask those contributors to purchase
an Apple machine to test their patches on macOS (you cannot just download
an .iso nor would it be legal to run a macOS VM on anything but Apple
hardware)? You probably guessed my answer: not at all.

And it does not make sense to suggest testing e.g. on FreeBSD:

1) there had been known breakages of our test suite on FreeBSD, and

2) historically, Linux, macOS and Windows are the most important Operating
Systems when it comes to reviews on the Git mailing list, in that order.
(I would actually disagree that this reflects the number of respective Git
users, but that is another story, and it would be very hard to obtain
trustworthy evidence either.)

> In fact, portability issues in a patch originally written for a platform
> is rather quickly discovered if the original platform is more minor than
> the others, so while it is good advice to test your ware before you make
> it public, singling out the portability issues may not add much value.
> The fewer number of obvious bugs remaining, the fewer number of
> iterations it would take for a series to get in a good shape.

You put yourself into the shoes of the maintainer, I see, as asked for by
Stolee's document.

For you, Junio, however, the task *now* is to put yourself into the shoes
of a Computer Science student in their 2nd year who wants to become an
Open Source contributor and is a little afraid to talk directly to "the
core committers", and quite scared what negative feedback they might
receive.

"What if they say my code is not good enough?"

The document we are discussing here is intended to be useful for these
potential contributors.

To you, it may very well look like a great thing if they used a "minor"
platform (such as Windows, you clearly thought ;-)) so your review would
make their code portable enough to work even on Linux. To the first-time
contributors *I* know, it looks like a very terrifying thing. "The
maintainer hates my patches!"

So. I would rather want to be nice to contributors who have not yet
contributed code to the Git mailing list.

> >> +When preparing your patch, it is important to put yourself in the
> >> shoes of the maintainer.
> >
> > ... and in the shoes of other users and developers working with Git down
> > the line who will interact with the patch later!
> >
> > Actually, the maintainer is one of the least important audiences for a
> > commit message.  But may 'the maintainer' is a stand-in for 'the
> > project' here?
> 
> I tend to agree.  The reviewers all comment on the proposed log
> messages and code changes to help making the patch understandable by
> future readers (i.e. the most important audicences).  The maintainer
> and senior reviewers may happen to be good at putting themselves in
> the shoes of future readers to spot potential problems than other
> reviewers can, simply because they have been working on the project
> longer than others.  But we should stress that the patch should be
> written for future readers of the code and history.

Is this not missing the point of this sentence? Those "senior reviewers"
also put themselves into the shoes of the maintainer, because considering
future readers is kind of the typical responsibility of the maintainer.
And considering how maintainable the code is. And how correct it is. How
easy it will be to spot regressions.

So "put yourself into the shoes of the maintainer" is a pretty good advice
here, because it will automatically also catch all those other groups of
people you mentioned, without mentioning them.

> > [...]
> >> +* Make sure the commits are signed off using `git commit
> >> (-s|--signoff)`. This means that you testify to be allowed to
> >> contribute your changes, in particular that if you did this on
> >> company time, said company approved to releasing your work as Open
> >> Source under the GNU Public License v2.
> >
> > Can this either point to or quote the relevant legal text from
> > Documentation/SubmittingPatches?  It feels dangerous (in the sense of,
> > potentially leading to misunderstandings and major future pain) to ask
> > people to sign off without them knowing exactly what that means.
> 
> When you can point at an existing test in legal context, it is safer
> to do so rather than attempting to "rephrase" it yourself (unless
> you are a lawyer, of course, in which case you can assess the best
> course of action yourself).

Please note: Documentation/SubmittingPatches is not a legal text. At least
I have not seen any accredited lawyer commenting on the validity of this
document, or how much sense it makes.

I could imagine that it would not hold up in court, given that there is no
required consent to the "terms" of Documentation/SubmittingPatches before
anybody sends any patches, and every contributor could claim that they
meant something different by "Signed-off-by:", that they had not even read
Documentation/SubmittingPatches. It *would* probably be different if the
contribution process required opening a Pull Request on GitHub and the
.github/PULL_REQUEST_TEMPLATE.md stated explicitly what we mean by the
"Signed-off-by:" line.

Even so, Git for Windows' own wiki
(https://github.com/git-for-windows/git/wiki/Good-commits) links to a
particular version of Documentation/SubmittingPatches so that it can
specifically mark the DCO:

https://github.com/git/git/blob/v2.8.1/Documentation/SubmittingPatches#L234-L286

I would probably want to update that to v2.16.2's version and link to that
from the guide, but definitely keep the current wording (as a preview of
the full Developers' Certificate of Origin).

Please note also: there is a seemingly authoritative site at
https://developercertificate.org/ but it does not even talk about
"Signed-off-by:", so we cannot really link there instead.

Ciao,
Dscho
