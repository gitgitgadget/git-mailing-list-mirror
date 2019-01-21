Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B40EA1F453
	for <e@80x24.org>; Mon, 21 Jan 2019 20:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfAUU62 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 15:58:28 -0500
Received: from mout.gmx.net ([212.227.17.21]:52455 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfAUU62 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 15:58:28 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjeWC-1hNEO32KLo-00bdjj; Mon, 21
 Jan 2019 21:58:20 +0100
Date:   Mon, 21 Jan 2019 21:58:02 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Slavica Djukic <slavicadj.ip2018@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: pw/add-p-select, was Re: What's cooking in git.git (Dec 2018,
 #01; Sun, 9)
In-Reply-To: <be3d2a6e-e960-6e43-17bf-9f67837f74e5@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1901212154300.41@tvgsbejvaqbjf.bet>
References: <xmqq8t0z3xcc.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1812092101570.43@tvgsbejvaqbjf.bet> <d69259ce-bc45-9201-693b-3902a6379265@talktalk.net> <nycvar.QRO.7.76.6.1812111049560.43@tvgsbejvaqbjf.bet>
 <be3d2a6e-e960-6e43-17bf-9f67837f74e5@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yMfxyJ54GB7cwM6EVSztuDcGTbHjwH5bn5NGplsOR/TzXUzJIAw
 dN+gp1us9iRaKneEOLklXFE9kpUSmdXZ+PwWHCixjSKMbPyzYhbszMvvbaycHTQLsU1C/20
 snfBa/ZNJH6OJbmbFqcuI5UJxIQs2X+XP/E5KPSKn03zntw/PMByR7mfhNAI8Z7oTQR3GEv
 Q2uogPvSj01Ggwksrpngw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:486RvzLOYa4=:pirrqPDLXOL+a0CzH0Om8b
 WPAxl0AAuSYAsAA2k/rMp1sR5X2AGa9fCNpkpAC4SoWOHtPpw+B3SuqutVx7zpAE+dPcnJYbc
 JfNbhBpwclyDSEp9Y09NPvq8RjzvrdPEAjY5ZQwOyYxbm1Gp8HCFeYXfWK0M7huoXC6OZy8nR
 h3G1AfACebyLKDF8MFVOHDvmdNfaX1dw7lmg+dSuFpkrsgMxELZUky4AJXn8Z+YHwX0XlUbQB
 qfJ2lGwj5OAZ2j6xmJoGSNP4spLmuN2Ehs8eviPSWa8FwXQw0jTN3MZ6PJG17DVx9MJrTm+9P
 ZtDIRs/fZFMYwwoEknqEJq6rhl8a40vG3XwzeijeIT+XiTBNfi902rYUhmWKPE1oQRDQyPSgr
 qYtaf2ciNnAhNPJ0uINQoQmJ6vYrfPYCO3cezaZeKabp2bB0mbaPvM0Nvi2HX3KlBf2NoztAK
 8bihf+GgtUpKZJeMJwFWR85yUHCRFUlBq2oNbqls8RwTI4yL05pWzkTD1DSoima1ZYx48Pr7z
 +Be1Jl6OejL1IyE4YLqT6UElRAhFY4p/f8qJLNouS5vB7WkQpioKcRBanPFM30g0O5pU7QXbZ
 8VD1j/okGKwf2d3N++Z6SeoBbb8KFJCxauriZlEkQM/ycQSePPYBmjTT+8GNWRfHhCTt/Unka
 By+ylTJRwkh8zAYt1FXt+Rydf4XQ/bAmO9Hc3XE1qmlU+2AAtdjCWqrriImqp2KzOGSUmqhyh
 xbteMcl1QvC66kqrCxiGh0Z4Mt0kREyyE2lOdGBy7ROA+ekLywDIsYeEyK2mwj2+SOucjI71r
 z/8ZgjzP2zkNsGYsi08MPBynkH0/b2QxI7UmS6hMPbwyYRz5ZYnRDuyVvDjPol2VXlSQjtfBS
 CKNLL5gEjdJdJp+s0drXSh7bybNy6tjnw/memgpDTh5X2lRjnMidB/FqsibeNcrr7uAm0irvV
 1qkI1mR1fRw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,


On Tue, 11 Dec 2018, Phillip Wood wrote:

> On 11/12/2018 09:56, Johannes Schindelin wrote:
> 
> > On Mon, 10 Dec 2018, Phillip Wood wrote:
> > 
> > > On 09/12/2018 20:31, Johannes Schindelin wrote:
> > >
> > > > I could imagine, however, that it would make sense for `git add
> > > > -p` to imitate that feature more closely: by allowing to stage a
> > > > single line and then presenting the current hunk (re-computed)
> > > > again.
> > >
> > > that sounds like it would be quite tedious to stage more than a
> > > couple of lines,
> > 
> > It would be. But then, if you want to do anything slightly more
> > complicated than staging a hunk or a line, I personally prefer the
> > `edit` command *a lot*, as it lets me even split unrelated changes in
> > the same line into two commits.
> 
> I was hoping for something simpler than editing patches just to stage a
> subset of lines that do not need to be edited.

Personally, I found that Git GUI's "Stage selected lines" worked well,
even if I could only mark consecutive lines. That might be a valuable
simplification in your case, too, to allow either individual lines to be
staged, or alternatively a simple start-end range.

The trick, of course, is to present the updated hunk after staging the
line(s)... That's what makes it so fun to use in Git GUI.

> > > and it could be awkward to get it to stage modified lines correctly
> > > (While I was writing the feature I tried git gui, I think it is
> > > supposed to be able to stage modified lines correctly but I never
> > > persuaded it to do it for me. I also tried gitg, tig and hg commit
> > > -i but I couldn't get them to do modified lines either)
> > 
> > Git GUI works very reliably for me, but then, I have Git for Windows'
> > patched Git GUI at my finger tips (oh how I wish we had a Git GUI
> > maintainer again).
> > 
> > It should not be awkward to stage a single modified line at all.
> > Essentially, you take the hunk, strip out all `-` and `+` lines except
> > the one you want to stage, then stage that with `git apply --cached
> > --recount`, and then you simply re-generate that hunk.
> 
> But that involves editing the hunk or have I misunderstood? The aim of
> my series was that you'd select the '-' & '+' lines for the modification
> and it would stage them properly as a modification so given
> 
> 1 -a
> 2 -b
> 3 +c
> 
> selecting 1,3 would stage
> 
> -a
> +c
>  b
> 
> not
> 
> -a
>  b
> +c
> 
> (see https://public-inbox.org/git/878ta8vyqe.fsf@evledraar.gmail.com/
> for the background)

Why not staging them as line 1 first, then seeing an updated hunk and
staging the next one? That's an easier UI to begin with.

Ciao,
Dscho
