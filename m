Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20BF11F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 12:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbeGLM5t (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 08:57:49 -0400
Received: from mout.gmx.net ([212.227.15.19]:42627 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbeGLM5t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 08:57:49 -0400
Received: from [192.168.0.129] ([37.201.195.126]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lw1vh-1g9KQO1Gur-017pGB; Thu, 12
 Jul 2018 14:48:17 +0200
Date:   Thu, 12 Jul 2018 14:48:01 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] rebase --rebase-merges: adjust man page for octopus
 support
In-Reply-To: <CABPp-BFMKnTMYTd3mK69wZ7__TZTwoF9NmX+RXwyqgUj7NJ0Kw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807121447240.75@tvgsbejvaqbjf.bet>
References: <pull.8.git.gitgitgadget@gmail.com> <20cd1b914e74c8f45e5cc9ed82d83eee1463cd91.1531312689.git.gitgitgadget@gmail.com> <CABPp-BFMKnTMYTd3mK69wZ7__TZTwoF9NmX+RXwyqgUj7NJ0Kw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:H2HUhDzjG7GBjyxMuTPT6oTG6kVBQdlbMCqvkQfirmkGK5igdfU
 S/wUFdZyK8AkRQ/iGzms8+FogbVcfulQAmBGdR22nOumfE1eBiLHTNAunzJF7ANeFlWvHgp
 HGNxMYNlCUHkUJDZ2VDpd6hbWw+Mj32+Xws9ehS8O4KCR9BgPCGqnJzZj9fD9dAPlVrTeMS
 G3cjo1NDsIJp555s5ac4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L8+uYBDWor0=:J8nL8/If4v9KhFgn+7rjHf
 7lF2fjRR4T1+8uav/mURvpId14jDn5hmU70A/NoNHuElGxmdI1BqH4ATEQzK8Ze8HsfFE9dIw
 9AGPcKhlt5Onb5+cWpwUW0ucWstjqgDi6Byzeb6iQQcrhCam0sEo7zWNQQN9yZhoQSo3cEUaU
 vYHZ4GNl+6QKwyMet4IXR0ny75r5Oc59oD6ZVfNWONlWFqkEFAv3so6jWhgNDLWtrlawp9Fwt
 CtgKhBryX5021eEVB6IROlcwOFAiSrBVxx8oqxooOzbp9+uEqagjxQp3mEIGlx6QJzJ/DdBtg
 jY55Qe8LfhPO5a22EwRFw7Q4ra8RFV+MEZ1r1JX2ugPP6mG2RoU+h0+b4AT1U48iGObK6wKNy
 rxbDm2ILHv3p/qbnz6Wix9K5sQbzMCio39yZFkYH3w9rwfapaB6xRm0ctOivykQnhISr3wBTY
 UfQN/gUpiYmWv2eOR+QoXiuI5uQChFZIFp1JA6xNFLYy5V8W8l/E+91HrL8LTl30F5LL6E9Qs
 i5q7qExVjXg7zygCeHdxCv5kcK0hiRAgUzrnLrHnUV67AjUTWt/LR7zlxKUKNxXGH25B8AMpG
 xcsWi5yO/AGcuuqJI8yAGhAahCi+ign774ZiqczHsKwlrwy4f+gJhi1/ujoFInf2Xvwz/y8X0
 nMbdQe3m+ERdA3/Re47XH2lEYlJagkG7BibhRlIdykYKplFcbrwtFxHhZfEpa6NrBJ2ymzgxa
 1vA6KFqvpMvIc2/51ey8+S/LQo4GIjDMWNA59uaJRKdMokiVq/nooNkVEs6aZuw7ABAhUTrZ6
 TSV1WT0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 11 Jul 2018, Elijah Newren wrote:

> On Fri, Mar 9, 2018 at 8:36 AM, Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>
> > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> > index 0e20a66e7..c4bcd24bb 100644
> > --- a/Documentation/git-rebase.txt
> > +++ b/Documentation/git-rebase.txt
> > @@ -889,7 +889,8 @@ If a `merge` command fails for any reason other than merge conflicts (i.e.
> >  when the merge operation did not even start), it is rescheduled immediately.
> >
> >  At this time, the `merge` command will *always* use the `recursive`
> > -merge strategy, with no way to choose a different one. To work around
> > +merge strategy for regular merges, and `octopus` for octopus merges,
> > +strategy, with no way to choose a different one. To work around
> 
> The "...merges, strategy, with..." looks like an incomplete edit.
> Perhaps "...and `octopus` strategy for octopus merges, with no way..."
> ?

Okay. Will be fixed in v2.

Ciao,
Dscho
