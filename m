Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8490211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 15:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbeLACcS (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 21:32:18 -0500
Received: from mout.gmx.net ([212.227.15.19]:40481 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbeLACcS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 21:32:18 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MCtNr-1gbrQZ05XH-009jo3; Fri, 30
 Nov 2018 16:22:32 +0100
Date:   Fri, 30 Nov 2018 16:22:31 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: en/rebase-merge-on-sequencer, was Re: What's cooking in git.git
 (Nov 2018, #07; Fri, 30)
In-Reply-To: <xmqqpnumk604.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811301621300.41@tvgsbejvaqbjf.bet>
References: <xmqqva4fj62k.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1811301429220.41@tvgsbejvaqbjf.bet> <xmqqpnumk604.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0HP0ZVMQ7FsmE+D4Bf5MKoFMhRr8lztgdJF8WPrsM8Yu7u6WKaI
 SBvl4ok7ZiNzI6wQuthGkq9Z+NCMtQHTKm27BKigmkoUOgWBgTEugrzFSl+gu7K7w8Aj2Qx
 E/pNcczkRhDBmZIdQ+h5szhIaMKsXsrmiof81z96ITUxGmNZgt7oO2tsHmJ25xeBeJNAJL8
 lwLztrg4TY9RTfsrIHMMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6hHeNUe1h1M=:KJEX+W7cmYMC+GS+f5Q4AZ
 Kxki0kXpyxjhfUqULHJrhSqyul/oSYwDg9Yk2Z6BQU53QzjSjzxaNeFm+WRp652tnhprcXAMh
 e3/St0zcUmYA417nqi+x+JxT6ZNfLGILJ/Q1MC/CDWSSkBJ9hIG8pGPoVzblDGdeteo3EUum8
 nbNRwdWHhqK8q+PKsnPTU6dot2C3dJ+FssCF5D3EymMbpulcdtP6X7hZgyvQ40C8tmS0ot+37
 AXwvsesvLSYwYqSGcX1A/zkyo5YdpwR5GUwiKi+YSxZac/kBQZKCBjZOiDkHyHCavWiV24IKd
 0acXZxHg95WB2PUYLRWpWcgQ8fT1fFrx+AU2mtzRseCfDLYYnzxSvcwUOLCz+DN2y9u7rEbrt
 ZUBQg1ZCSe8ZmyPeZ31WqF5gya63ORVv/sPl3ecCAlgsryteBMNFBXTf22c5086xoe8sBQkb+
 taj8jw6yhkxW3AdspsQtCM9Pb2pKLIduYxnc0pGCg+0XclydH/V04C/UOO1CSy5cPLR5eySSn
 GDUAPHSu98cMlxuJvHuBf6sjC1gidy/AcpcISg07LgjspydxB8FB04sTxX4RNzc908uA8a7Xo
 NMo6+QOiy6cDIsZSEA0E+aVi9e9ZeRSVuf3eo7+0+rQrwZ/xYBGL/JpXrepKWIPA4ecJ9frDt
 L81UqqPAnwxOzNtYuoK8d+KDfenXTKVZ9lZOvBa32VRIgSijMkVriWMNNtbpJlUcKgfiM8B5E
 4dxm+/Wz5C2uP41aZ8Vwcun81Sl8zf7ra7+YLhs6dcuO+nuMiFhByuUzBzW00YASkCRPLk7dQ
 8yPOlIAebPuEC+2qNl5vW+HjCBIuyOK7GqcBNcZxcGVOSC+2gaSvkaZcRsGE/Sl0XfxSywYEf
 G4om16aRXlmNl9gxVPrmzscPhLvNJuraepenvlFbMWkwFHQsLBFG53PT7GfQ3vNzzAx+kb8oD
 q3FqOJLwMbA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 30 Nov 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 30 Nov 2018, Junio C Hamano wrote:
> >
> >> * en/rebase-merge-on-sequencer (2018-11-08) 2 commits
> >>  - rebase: implement --merge via git-rebase--interactive
> >>  - git-rebase, sequencer: extend --quiet option for the interactive machinery
> >> 
> >>  "git rebase --merge" as been reimplemented by reusing the internal
> >>  machinery used for "git rebase -i".
> >
> > I *think* a new iteration has landed (which has 7 instead of 2 commits):
> > https://public-inbox.org/git/20181122044841.20993-1-newren@gmail.com/
> 
> "Landed" as opposed to "be in-flight"?  
> 
> You got me worried by implying that I merged them to either 'master'
> or 'next' where it is harder to back out ;-).
> 
> During the freeze, especially after -rc1, I stop paying attention to
> anything other than regression fixes and fixes to the addition since
> the previous releases, unless I have too much time and get bored and
> the new topic is trivial (which often means a single patch).

I thought so, but then I thought I had seen you commenting on the
(distinctly non-single patch distinctly non-regression fix)
`split-checkout-into-two-new-commands` patch series ;-)

> I'll mark the topic with the following, and continue ignoring it (or
> any other topics) for now.  Thanks.
> 
> * en/rebase-merge-on-sequencer (2018-11-08) 2 commits
>  - rebase: implement --merge via git-rebase--interactive
>  - git-rebase, sequencer: extend --quiet option for the interactive machinery
> 
>  "git rebase --merge" as been reimplemented by reusing the internal
>  machinery used for "git rebase -i".
> 
>  Reroll exists.
>  cf. <20181122044841.20993-1-newren@gmail.com>

Thank you, much appreciated.
Dscho
