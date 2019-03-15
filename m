Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0CF920248
	for <e@80x24.org>; Fri, 15 Mar 2019 14:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfCOOvo (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 10:51:44 -0400
Received: from mout.gmx.net ([212.227.15.18]:48731 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbfCOOvo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 10:51:44 -0400
Received: from [192.168.0.129] ([37.201.192.41]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDyFr-1hG1Vq39DD-00HNWX; Fri, 15
 Mar 2019 15:51:33 +0100
Date:   Fri, 15 Mar 2019 15:51:17 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: GitGitGadget on github.com/git/git?, was Re: [RFC/PATCH] point
 pull requesters to Git Git Gadget
In-Reply-To: <20190315033020.GE28943@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903151443420.41@tvgsbejvaqbjf.bet>
References: <20190312213246.GA6252@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1903141235390.41@tvgsbejvaqbjf.bet> <20190315033020.GE28943@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zhwJYDTuaIAG4q5ggjR/bwb58RSUDiopv9lGYsFzf6vafAtGlVf
 imWMS57dfl1XiX0K76uR9JZd87V5avzSbVSvmFiswGRnBXeAwXtjQ2zEBca9fnlJcNt7xGL
 5SaQoRzxLL1SyvfKHo0CAYzG8W15zW2g75RWxNTmmY4WfjtCflslV53sn3QTb5I34xVYcaG
 dMEnzSJPLBQLJ2IhcDVhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LSM7TdZax98=:tu9Jo1h86T6hLRVsESW2c2
 AhpjW2LluzfF3zbsMclRrItiMMtjUpMAmo7jhju4+RIuo9q+KygyJhUSjnAjh2e9La302rnhB
 cuSuDph+9XzGaQBkEwyJgzl99G3qkIdQ7XJvF2nXTYb50Hva0EmN2A6lSijLvCRWkMXpIbv12
 31bhSUD0u3o0VU5Gb/RRioDoHcF/Y3q1un6xAXs3MpwZJLI7HrH+LvXmSryqAOjraZW85PHZ8
 Oa2BqiBLP/JN0EO6KJN2bg39zDJIdtdb02jjfo8bLiavmPc0KuckhXgz3Z/aWvBxXpEcHSFje
 ZIQwSQagTn88NJ6iv8Y7wGSfbK82JycINt+Fg0+Lj0X8pS9VcJhthkM9kwCqVceWwQDlCxzNC
 y7HJWVg7GYGBFndCn9dnTqlVIwWLFu/2Ww55pWKiEgMFNQ651O70Tv5b9LxviJs4KEMBebzuc
 8UtLdfFRdKQhWCx3PukyjT4eYEYcbVeR+OFoVLg84BUTkpVHBVZHyf6SxN3dS5M/HoMlEV9x8
 u+jnAyga0dimfMqt5JOpvhqdkbmtLdIf4Gr8a/Y8aOkY5/rDIdWAUDuYxab/TYLrVoPus2+27
 0Tnw8Hrb5psIC2nZg1BoJk/ck6BSlQzvWZP1+TmoJRtn6QJFrOrzMufT79jkONB649riTysTa
 ZZNcS2t7YgGMmZZxXhC2x58/oHh2UVVvLRoBtTXjPSieFvbdnjRmG/nRXO0/cNWFESz6OqpDv
 xmvIzspzPR9nhlafmfvn7SfpKlpwJZwW/7QfUYZjQuPDxyiDG5El1S6spfzxAT3EScI6MNEvJ
 13WgcjrAywi0GmGkp1DXaPeezV2sFxGS2NVPhj1mC++5SBf58ybso90828zS2+m9XkiqrfzXb
 +GmXXOGoSb9dzEBBX3u4Ar5VF8KAu1i+wMgRftmr68xF6lrdb3JvlkkxJIyIsQtLv3TQJZBc6
 rfkVtNxZCWs6QFAN2N2jE5J3tLrwiTqE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 14 Mar 2019, Jeff King wrote:

> On Thu, Mar 14, 2019 at 01:04:51PM +0100, Johannes Schindelin wrote:
> 
> > > One thing that I think submitGit can do that GGG cannot (yet), is just
> > > take PRs straight on git/git. If we're going to start recommending it,
> > > then I think we'd probably want to configure that, since it's one less
> > > confusing step for first-timers, who right now might have to go re-make
> > > their PR on gitgitgadget/git.
> > 
> > I just realized that I had not responded to that yet. It is not *quite*
> > that easy, unfortunately.
> > 
> > I did design GitGitGadget to have a state. For example, to avoid spamming
> > the Git mailing list with bogus patch series, GitGitGadget maintains a
> > list of GitHub user names for users allowed to send patch series. (I saw
> > my share of bogus PRs in the Git for Windows fork, and had no desire to
> > facilitate similar patch series on the list.) This information, together
> > with information about the Message IDs to monitor, and about the PRs that
> > are still open, are maintained in a JSON-formatted object that is stored
> > in `refs/notes/gitgitgadget`.
> 
> Ah, I wondered if there might be a catch like this. I do think it would
> be nice to keep that ref out of git.git. We definitely would not want to
> lose the features that depend on it, but it sounds like we could use a
> separate metadata repository.

How about... brace yourself... https://github.com/gitgitgadget/git?

:-P

Seriously, I still think that the `refs/notes/gitgitgadget` note was a
rather smart idea, and it was designed to allow for serving multiple
repositories. You will note that the PR references in
https://github.com/gitgitgadget/git/blob/1380f7ee9aaf/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
are all full URLs, including the GitHub domain and the org. So if any
contributor feels strongly enough to support, say, BitBucket or GitLab in
GitGitGadget, the data structures support that (and I would gladly accept
PRs for a change).

Read: yes, we could totally extend GitGitGadget in a minimal fashion so
that it supports PRs at https://github.com/git/git and stores the relevant
metadata in http://github.com/gitgitgadget/git's `gitgitgadget` note,
still.

> > I could imagine that we keep pushing those refs to gitgitgadget/git,
> > but now also allow for PRs on git/git to use GitGitGadget (we would
> > have to install the GitHub App there, too, and I would have to change
> > the code to allow that, and we would have to use a slightly different
> > format for the tags generated from git/git PRs to avoid clashes with
> > the gitgitgadget/git PRs, all of which is totally doable).
> 
> I don't think connecting the GitHub App should be a big deal. Ideally it
> would not even need write permission to the git/git repository, if it's
> keeping metadata elsewhere (it would need to be able to write PR
> comments, of course).

Well, bummer. I cannot tell GitHub that it needs a certain permission on
git/git vs another permission on gitgitgadget/git.

I guess I'll have to be really diligent about the code base of
GitGitGadget, then. Or maybe I'll use a second GitHub App that is only
installed on gitgitgadget/git, as a hack.

> It might not be a show-stopper if GitHub's permissions aren't
> fine-grained enough to allow that, but not having repo write access
> would be nice insurance against bugs in GitGitGadget writing where we
> don't expect it to.

Right. Hack it is.

> > If this is truly something we ("we" as in "engaged Git developers")
> > want, I can set aside some time to work on that. I had originally
> > planned on exactly that, i.e. supporting PRs on git/git, but I got
> > rather strong indications that GitGitGadget is hated by some (Duy, for
> > example, was very vocal about refusing to even look at any of the
> > GitGitGadget-sent patch series, let alone using the tool himself).
> > While I think that this hate is undeserved, I cannot change other
> > people's feelings, nor would I try, all I can do is to try not to make
> > the situation worse.
> > 
> > In short: before I spend serious time on extending GitGitGadget to
> > handle git/git PRs, I want to be sure that I won't get backlash for
> > that.
> 
> IMHO, GitGitGadget is a useful tool to develop. It has some rough edges,
> still, but I think the _idea_ is certainly a good one. Especially if the
> dream of bi-directionality is ever fulfilled (though I am not exactly
> holding my breath on that; I think it can get very tricky). But even
> without that, I think it's useful to have something like it (or
> submitGit) available for some contributors.

Agreed.

> In general, I have not minded the use of GGG on the list lately by you
> or Stolee. I do complain about the rough edges (timestamps, sender-cc on
> the cover letter, etc), but even as it stands now I am not hating it as
> a reviewer. If you are happy with it on the sending side, and especially
> if you want to smooth some of those rough edges, then I do not have a
> problem myself with its continued use.

Well, Peff, if I had to rank the Git mailing list regulars by "niceness",
you would be on top. I never doubted that you'd be okay with it.

Junio has been quite a bit more critical of it. And Duy really made a
stink of it. But yeah, while I really did not feel any love for
GitGitGadget, I also did not hear more than two voices speaking out
against at least the current state of GitGitGadget.

I'll give others time to chime in before I decide whether I should take
GitGitGadget into the direction of git/git. (Because, remember, it is not
quite "free", it takes a lot of time out of my schedule.)

For the time being, I'll of course continue GitGitGadget myself, primarily
because it addresses precisely all of my needs. Which makes sense, because
those who develop the software always get the most out of it. It's the way
it goes.

Ciao,
Dscho
