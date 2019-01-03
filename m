Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0A1D1F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 13:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbfACN1q (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 08:27:46 -0500
Received: from mout.gmx.net ([212.227.15.18]:33773 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730229AbfACN1o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 08:27:44 -0500
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MfEMs-1gyNN32EDC-00Oqqa; Thu, 03
 Jan 2019 14:27:39 +0100
Date:   Thu, 3 Jan 2019 14:27:39 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2018, #02; Fri, 28)
In-Reply-To: <CABPp-BEd5-0Vcv8YApUxo0jK_ofxCORSG5H0wU=kiR2aOY1ztQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901031424340.45@tvgsbejvaqbjf.bet>
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com> <CABPp-BEd5-0Vcv8YApUxo0jK_ofxCORSG5H0wU=kiR2aOY1ztQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XbvwfJuJ1aoeGb/LIv100JQXEFlOdIA1ysdh28HDDAJfJC9XBaD
 HDk9lzj5g3q5Jx4hHI7nlEbx5T6/reL7aGuvw0UlPW3QYWupTbdEmnut76tqx7im9aLhkog
 0A1avEq3JYKFJN9PXdKBWHXiaccwwtzyr5P9kz5wZxTaYF2s3n+VJ0jINTxeE/56fxUlZ9q
 TI0y7lMc9NBM5zqEY1aHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GDvhQCxcqXY=:wX+5Qm5VGpzhBuPlv9Z3pd
 YqF1KHOy6KsqH59QmtogmOEl6xOm5aoBAtuh4YHg69s1Dt8MdgPYTie2Q2dHG78ZfP7yLyg4f
 Xtk7bPd894yNmXcsdVkvSkHTVrd40N2eXbww7yJacUmSCuFXV8MdBH8AhutvrrP5VYRgbgWEa
 DSWteVF2skQKtf5QTQVhl+JZC7iHtR29VPMzIg+mIkxYhKi+8ZqLq8iSZIeEcUXRjKhawEcTt
 4sfR1HBmmyDf6Tzu+CHaOg1y/mFo8bIi7htf1id4XOZ8eXC0wUnjSWaFizbIHwS7B7XkMrAJF
 s1475+Jgehq6L+svZs59Yp7b639Z4Fyu6Vks6WKB4jCkt8s0G4w8b+o8I10/WpYmRt6WnaMHe
 tIgyz2sZNEY/Toiks+BxPVTLOmx4uNooBOiX49EHMMp6JSOxm9aEPJzxwnY5iQKBKNamUjKV1
 vaWQ27lwMoQRtuHpn81WwZ54fyfv/BnLMWYtMFjrsXWhD8YGn8pls1TuY8/xVwvdF+6Ha+k2f
 CDDvqdKiM8zLL/C25lADCVaqsL6antzH+2a5HWIjcNy7zP3KboD2lrDnamdaPbU/AHcyubJ4M
 ha1N6Vn4FF/XJyo4Gk8jknUzlPZOJqgRQvZ1Ttu5eiyvi9sBar8xJuiLvh4IZo/FGZo692XWU
 gXPy58SYzw2koQxpPwVreMHtDxwQdR6gGWFBjhbarMKwR6lQMMl4YpQdVBgQLcXU3meSdZgMU
 UA0RlWiyNGdL14Kspgp2TI7II/YCzEToMy0Gcia6u9Vl6Qb4ir6Mu8Tw8YXxLC+EKJwxZVmLo
 2FaJwqt4Cq5CFypbIC5a9704bhEeHYJAikSKRW0nkQxS+3Ppz9jZ3IPnlNOhrT8QoFhRHIbpQ
 32SI5Y312E9brqi631aV3cbsABmWFUlEN+NA2o8rlwYtqZrl8j+oHWAZjOu3BKbGcMqlTdb+2
 om8sLe8klMA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 28 Dec 2018, Elijah Newren wrote:

> On Fri, Dec 28, 2018 at 10:04 AM Junio C Hamano <gitster@pobox.com> wrote:
> 
> > * en/rebase-merge-on-sequencer (2018-11-08) 2 commits
> >  - rebase: implement --merge via git-rebase--interactive
> >  - git-rebase, sequencer: extend --quiet option for the interactive machinery
> >
> >  "git rebase --merge" as been reimplemented by reusing the internal
> >  machinery used for "git rebase -i".
> >
> >  Expecting a reroll.
> >  cf. <CABPp-BF8RupyfP69iqAVTXxEhBGyzVd-wUgp3y0pf+CbBFAQeg@mail.gmail.com>
> 
> Quick update: Two re-rolls have been sent in[1]; v3 on November 22 and
> v4 with only a minor error message tweak on Dec 11.  I think I've
> addressed all review comments from v2, but neither v3 nor v4 has
> received much review -- Dscho was also heavily busy during the run up
> to 2.20 and needed some recovery time afterward.

Yep. There have been quite a few problems in the -rc period, and at least
one frantic bug fix of mine introduced another regression, and then there
was the problem with cURL where it would try to use HTTP/2 with NTLM
(which does not work, and probably never will) and as you probably
suspect, NTLM/Kerberos authentication is *quite* common on Windows, so
that would have been a total non-starter if we had shipped Git for Windows
v2.20.0 with an unfixed cURL.

So yes, I was quite exhausted after those weeks.

> I was going to re-ping in early January.  Anyway, it may be worth at
> least updating your note to "reroll exists".

It is early January! ;-)

Ciao,
Dscho
