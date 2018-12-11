Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4BC120A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 09:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeLKJ5H (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 04:57:07 -0500
Received: from mout.gmx.net ([212.227.17.22]:39571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbeLKJ5H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 04:57:07 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LdYSM-1hE0D23t3a-00ijdd; Tue, 11
 Dec 2018 10:56:59 +0100
Date:   Tue, 11 Dec 2018 10:56:57 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Slavica Djukic <slavicadj.ip2018@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: pw/add-p-select, was Re: What's cooking in git.git (Dec 2018,
 #01; Sun, 9)
In-Reply-To: <d69259ce-bc45-9201-693b-3902a6379265@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1812111049560.43@tvgsbejvaqbjf.bet>
References: <xmqq8t0z3xcc.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1812092101570.43@tvgsbejvaqbjf.bet> <d69259ce-bc45-9201-693b-3902a6379265@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ssPqBzaqMhdODO7CM6S34vUVjoQyv5oM+0Qih7q8ZJtYcm0DBnl
 x3BwHSpYZOKAQBJ0J3B3ZetZul1aDiqTGTwevv6D7akldCmj7Jahuoh+FUhwZm1hhzfXia9
 TmPp6xZunzgfAOayjL5Zljz2LtJFwe5S0atj1H4c3G7oeFA6yYPFXqIY8cukuHLH13Y6kxs
 DEMNrluirR7MgLO3k9Q/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/wgn3PK/Xxw=:LFRc54Mq9u+dYH3JC/2HO1
 BRjs9/i7EOhyr8Yyw1y7aVspax5fl9tbAYYPpBw5z8SDZ7fg74T9bIP077cYex1QDVF9Ftq2G
 IFOPW8LL+/guScUIgRiJVZy6vD/AvAl+1BTj4WNSiwrgXniYuWJzKpg9GkbSAp/At//oRmkSR
 eKAOYSvwUJBeHSTfRStDCkcVBKGuisDAnj5c8Mvkl/oSDzdaX3i3HiJ1vmWwan1cfoVLGte41
 hAr0b1V00E+EJ6xeur7WoZ+2QSN4RgPMpRbIqCbtQRUT28xOqKuc/4JoVUDGiyW7oJqZjp7Dg
 unPUF0nKFvN0D0lHbXZ6YZiIdmJ1fAqdZlhGTMauLCVfAF6EOuA0bnTNUB+rN9tZx+oBscyFd
 lSfqkdwErWV+MSfzDIUTKMkJNztgsMt89Yvw0D7XwzBMX+3LnLG9K8hUnotMp2gDjKtCz5rBo
 v5p9OGqyE32PG5L+a0A8XxcE/fuzu72kT4TZkE0xDTkBgG/K7t4UIbFXhOhhrn0M0rkKWhWJB
 0L0q6mkJ58Ul9Bf4Um/klPu1QfQmIrlzoD0L1wTm97tlBOPpZyYPQ0bNoebUiAdQL+46syI4L
 jcrio0e6RJT9FBayE1KI9hBqpecTbUVLJzbd+uHqOdyOFCBKtI6m7a9gZP1ToalTgGH3P6J1o
 PaU4VZ/TnaQP52EiM1joG68jkfu6TfakMoUjRzAoYlCjk5TH7fa9CDsj55ZgFwXQj/I39ysYM
 GLu782zrxncLR5vrBZso0lkHShDIytH8vTQUd8z+K4tZ/I6yK5wzF7m4VekYT6oCYO+a5QBoM
 YIPR3+MnhhAW09+QVeSZdYyNFxgvFfm7IAycHV1tm02NtAJBWNHCG3Bd//rVn7zD1+br7HQ3J
 pcJRU0GM3imJwbqoGpFBoIHy6cbt6kEWjkDmFBa1LAxakLlIMR0fGFdByzQuXzKbu39CHQJdA
 hqKS8dE7TvA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

[Cc:ing Slavica, the Outreachy intern working on converting `add -i` to a
built-in]

On Mon, 10 Dec 2018, Phillip Wood wrote:

> On 09/12/2018 20:31, Johannes Schindelin wrote:
> > 
> > On Sun, 9 Dec 2018, Junio C Hamano wrote:
> > 
> > > * pw/add-p-select (2018-07-26) 4 commits
> > >   - add -p: optimize line selection for short hunks
> > >   - add -p: allow line selection to be inverted
> > >   - add -p: select modified lines correctly
> > >   - add -p: select individual hunk lines
> > >
> > >   "git add -p" interactive interface learned to let users choose
> > >   individual added/removed lines to be used in the operation, instead
> > >   of accepting or rejecting a whole hunk.
> > >
> > >   Will discard.
> > >   No further feedbacks on the topic for quite some time.
> > 
> > That is not quite true. I did comment that this feature
> 
> Sorry I meant to reply to that comment but never got round to it.

No worries. We're all busy down here.

> > (which I take as being inspired by Git GUI's "Stage Selected Line"),
> 
> not particularly, I don't use git gui I just wanted a way to easily
> stage a subset of lines without editing the hunk.

Okay. I used to use Git GUI quite a bit to stage individual lines, but
recently I tried to stay more in the terminal and used the `split` and
`edit` commands of `add -p` quite extensively. Wishing for an quicker way
to stage individual lines between all of my debug print statements.

> > and thought that it would be useful.
> > 
> > I could imagine, however, that it would make sense for `git add -p` to
> > imitate that feature more closely: by allowing to stage a single line
> > and then presenting the current hunk (re-computed) again.
> 
> that sounds like it would be quite tedious to stage more than a couple
> of lines,

It would be. But then, if you want to do anything slightly more
complicated than staging a hunk or a line, I personally prefer the `edit`
command *a lot*, as it lets me even split unrelated changes in the same
line into two commits.

> and it could be awkward to get it to stage modified lines correctly
> (While I was writing the feature I tried git gui, I think it is supposed
> to be able to stage modified lines correctly but I never persuaded it to
> do it for me. I also tried gitg, tig and hg commit -i but I couldn't get
> them to do modified lines either)

Git GUI works very reliably for me, but then, I have Git for Windows'
patched Git GUI at my finger tips (oh how I wish we had a Git GUI
maintainer again).

It should not be awkward to stage a single modified line at all.
Essentially, you take the hunk, strip out all `-` and `+` lines except the
one you want to stage, then stage that with `git apply --cached
--recount`, and then you simply re-generate that hunk.

> I'll try and re-roll in the New Year, when does the outreachy project
> for converting add -i start? - it would be good to try and get this
> pinned down before then.

Too late. Slavica started on December 4th, and you can even read about it
on their blog: https://slavicadj.github.io/blog/

Ciao,
Dscho
