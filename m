Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7AF520248
	for <e@80x24.org>; Thu, 14 Mar 2019 12:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfCNMFP (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 08:05:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:47231 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbfCNMFP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 08:05:15 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MO77c-1h9vPj05fI-005WkM; Thu, 14
 Mar 2019 13:05:07 +0100
Date:   Thu, 14 Mar 2019 13:04:51 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Roberto Tyley <roberto.tyley@gmail.com>
Subject: GitGitGadget on github.com/git/git?, was Re: [RFC/PATCH] point pull
 requesters to Git Git Gadget
In-Reply-To: <20190312213246.GA6252@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903141235390.41@tvgsbejvaqbjf.bet>
References: <20190312213246.GA6252@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6I7V2mRNFNec5LFn8SWjAfe67bjx2fCGXaJBij6XwLj8JAqOOrR
 YoEtEETp5j6yTuvpUAzKveX7lIp1sAul+Z2yLN5s73B90ydk9T4gc5gD1B8F84y84JHZxoX
 Wy6vGdKA/GICj10MqGKVtykak0W4IlBe4KnZYQ9gisZkM1G1nLP09FA67G0QR9SZCPyArn6
 cAEfxZ4m3bv4mrEX6SRvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ku1SEJNzK6U=:p7qb6j4k9Yl6b3xEdnABlD
 R9qBc88ktD+KeqEq0dJqsvuUjdfZOQconhWnz21UMIHBvkZBi2cRjZh/jpJAPJWAQn5udyybg
 7PMvkT9W9j181Yi1vq7TpQkP2xvVGVpC7oMAteD59GHpvVlKMKS+4Uvp2qAoLWpx3EjpIxk94
 HPO7i1fD/pKQuIrjeb2nqb678A5fhjbke1WmfCilbtqi8axGLOfzT6gNF7s3Bn/2iOA5jxv4T
 SXfQaxd4gL9TXtLSJmLzDG1/d+QVuYHgN74HBqzMwhXiHtQYX+Bg2sc+ApAQ0UpqHdlwZ+SmA
 aaX/FDSgZkaWq8ZQzMCj/+HgcATPDJWqyDkaN8cSd1dcZ/3GHGudmIvh0cv582h7lQLzr4UBY
 Y0SgdANU7joJZKBvyS8XMPqidI3t2PIHGumhc1XdKE5tJr/9+s9NbMYclCt9d6d1wDb9/RAGC
 lN6ExNIB2bfQzsU5D/07v0LCdci+RVN6gyZGyeePF1/0S9wNiX3cvqp7N4S+X96LKRpXu0QAR
 8pjRoPziVPwBs2HSbIfuHb1isaCKvfLSSlW1fl2GOfVtY39QplM1DHHdXLzlcj3goOcr0hdfF
 /tPfOtGsGe+zi0UZFDvDV1sFzwejo/S+Tx8miadb1nqQl882VcIwEW5s99cSz3zknF4spSld5
 5oh2UAEm+BeQuTqalqHK4iUB1ghRgMQM+gVH1eklVYGLarFGn9ht8RRQm/wcXHr0W37h/3/0X
 2UVXjbEH8K7Dp5fe0T2z0WqmYxmVMt+DyTn5tHzOY8lzJ4d/6Iie20tAQEMd/82Y0DlRwDo7X
 tXBXRDaWchEcgjaG2UJDL2QHyLvIOnIbbeNvJeK1DNHDxP5z3wQCSnDHK+afugENJLLo++7FP
 n3gBehaifrXSsg2ppJ3FxUEzNTO13VxNL0BYolou6p4lrO50r6cCXvOvA00Fin6nYbD/am+Cm
 DfMnYWZnygQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 12 Mar 2019, Jeff King wrote:

> One thing that I think submitGit can do that GGG cannot (yet), is just
> take PRs straight on git/git. If we're going to start recommending it,
> then I think we'd probably want to configure that, since it's one less
> confusing step for first-timers, who right now might have to go re-make
> their PR on gitgitgadget/git.

I just realized that I had not responded to that yet. It is not *quite*
that easy, unfortunately.

I did design GitGitGadget to have a state. For example, to avoid spamming
the Git mailing list with bogus patch series, GitGitGadget maintains a
list of GitHub user names for users allowed to send patch series. (I saw
my share of bogus PRs in the Git for Windows fork, and had no desire to
facilitate similar patch series on the list.) This information, together
with information about the Message IDs to monitor, and about the PRs that
are still open, are maintained in a JSON-formatted object that is stored
in `refs/notes/gitgitgadget`.

I also designed GitGitGadget to tag iterations it sent, and to push those
tags to the public repository. I personally find it pretty frustrating
just *how hard* it is to go from a given mail in the mailing list archive
to a fully working local branch, even if that was exactly what the
original contributor had to begin with. With these tags (of the form
pr-103/slavicaDj/add-i-v5), that's not a problem.

Now, I was rather certain that Junio would *not* want that Git note in
https://github.com/git/git, let alone all those tags.

Yet for ease of implementation, GitGitGadget uses the very same fork where
the GitGitGadget PRs live to push those refs.

I could imagine that we keep pushing those refs to gitgitgadget/git, but
now also allow for PRs on git/git to use GitGitGadget (we would have to
install the GitHub App there, too, and I would have to change the code to
allow that, and we would have to use a slightly different format for the
tags generated from git/git PRs to avoid clashes with the gitgitgadget/git
PRs, all of which is totally doable).

If this is truly something we ("we" as in "engaged Git developers") want,
I can set aside some time to work on that. I had originally planned on
exactly that, i.e. supporting PRs on git/git, but I got rather strong
indications that GitGitGadget is hated by some (Duy, for example, was very
vocal about refusing to even look at any of the GitGitGadget-sent patch
series, let alone using the tool himself). While I think that this hate is
undeserved, I cannot change other people's feelings, nor would I try, all
I can do is to try not to make the situation worse.

In short: before I spend serious time on extending GitGitGadget to handle
git/git PRs, I want to be sure that I won't get backlash for that.

Ciao,
Dscho

P.S.: Fun fact: I came up with the name while discussing the idea of the
"UI" (using PR comments to send commands and get answers) with Stolee,
pretty much precisely a year ago, and when I tried to find a label for
what this thing that I have in mind is all about, it was "kind of a gadget
that works on git.git".

So yeah, I had https://github.com/git/git PRs in mind when I started, and
I only started the gitgitgadget/git fork in order to prove that it works,
and that it has benefits.

If it was not for my wonderfully supportive team, I would probably have
abandoned it after encountering so many pushbacks (`amlog` being actively
made useless for me, the unexpectedly negative reactions to GitGitGadget,
all the work being left to me, etc). But my outstanding teammates really
made a difference, and can now reap the benefits of having a system that
only requires a GitHub account to contribute to Git. As well as occasional
contributors, I might want to add, whose contributions we would have lost
if it was not for GitGitGadget.
