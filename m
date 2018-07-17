Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4616E1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 16:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbeGQRMu (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 13:12:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:43613 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729648AbeGQRMu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 13:12:50 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mhej1-1fS2cK1Un5-00Ms2n; Tue, 17
 Jul 2018 18:39:15 +0200
Date:   Tue, 17 Jul 2018 18:39:13 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 17/20] range-diff: add a man page
In-Reply-To: <CAPig+cSin5Em1m7uigSLnNg9wbz+fz8uy4sJOECq2Ke2+v+D4A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807171839010.71@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <pull.1.v3.git.gitgitgadget@gmail.com> <799da25ef35d2b23dc0df1e6af0772e634f39f19.1530617166.git.gitgitgadget@gmail.com> <CAPig+cSin5Em1m7uigSLnNg9wbz+fz8uy4sJOECq2Ke2+v+D4A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PK/2yJ7zznmjv9MHe8DaX1bvHB0IS4h0F4NIPkJOJtbJSajYMWb
 vvMDZcrC6A7lyB9w43FvXkUnHp6fNQsDcVe5t6t0jM9uuof+NGj7CR9GIlQBiY7TIkD3TwE
 XOJxB956708w/GnmFtBpIW1VPvzXqB5pzuCs3waa0Lwl7qdljr0U/r1AFsPJBoJBcY8C3bf
 SvN6bd9hqNBmwPu5rsjVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FFhuUzJOEyc=:goivH32mjiOlbwJendZirS
 xcLIaQNxT8R6ukzMxaFy+eHiZdqk7R2bGoikqegH4el4Ia3n9fOk8fSKN3xy0aGX7p3B2oWZs
 X8Ayps57FwKBa9RMokqlfysBmOIu1Z4frULsBT95RSmK7cehfZ+tBGp6d/UfQHlXzLawGOzfp
 qG2EAb7zPmT19nydMok+qD/EY5NR/FRP3uqYofx1Qwh8pGEP6n7gdaCIL8pDnWYAUhzV1/6hv
 Bj01IcwYfbd2B0rU/onBTcAEwheQkYYme0DJ7TVrRYeo4dqgXkQCwkZ7RwFkUN6ImkWgyn87V
 Wpg2uJ4KCrpPZBFc04GfWk5bzv7IOa16NJrqAY8qCYacgKAPlCLc19KUAbuq8jThbry5L8aTU
 gsiB1IG8JI2nKL4mACVUNwa49vN6k/rqlouHVRrBuhug+lTJjs+t9vavcS5NcLWA4lTpeeXCm
 Fv4T7rSYNhqciKt3ik+zb9+vBE3UzErmQ7ja+F2LTAZwvWf/9IStU+4sPJEwcUe5f5YBHOKI3
 JjdBrPYkhxWQoEUe5PNLh9UdaiAw3uvwEu44J5SWLIuHwTXoiB48vmDQqJPjH7bV0VU5oSaxC
 vWkn4AwRBjFShzc6/SlMHqWXJUzjm527l4je01/lfjXbyuBTXxtS3e6HPzJoZEtvWKhcBzF3u
 QFLC9vpEl7YbZV/25ycRpYEZAgszZZ0lspJlxT+Bfq9ruSML17x5YHqxXMJ7tO2n7EBXgx95A
 vZaZkBT3qdqXqwLN3FgW6Nwo401soQLn1NG9AtB5/ze/BENORjPX3O0H26q0OaRgHmgoBXQKj
 jRadFIi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 16 Jul 2018, Eric Sunshine wrote:

> On Tue, Jul 3, 2018 at 7:27 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > The bulk of this patch consists of a heavily butchered version of
> > tbdiff's README written by Thomas Rast and Thomas Gummerer, lifted from
> > https://github.com/trast/tbdiff.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
> > @@ -0,0 +1,235 @@
> > +To that end, it first finds pairs of commits from both commit ranges
> > +that correspond with each other. Two commits are said to correspond when
> > +the diff between their patches (i.e. the author information, the commit
> > +message and the commit diff) is reasonably small compared to the
> > +patches' size. See ``Algorithm` below for details.
> 
> Unbalanced number of backticks on "Algorithm".

Of course!

Thanks,
Dscho

> 
> > +Finally, the list of matching commits is shown in the order of the
> > +second commit range, with unmatched commits being inserted just after
> > +all of their ancestors have been shown.
> 
