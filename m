Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B5681F453
	for <e@80x24.org>; Mon, 22 Oct 2018 09:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeJVRTS (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 13:19:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:47609 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbeJVRTS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 13:19:18 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0McPvw-1fwzCt25Ts-00HjEN; Mon, 22
 Oct 2018 11:01:39 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0McPvw-1fwzCt25Ts-00HjEN; Mon, 22
 Oct 2018 11:01:39 +0200
Date:   Mon, 22 Oct 2018 11:01:40 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Luca Weiss <luca@z3ntu.xyz>
cc:     git@vger.kernel.org
Subject: Re: No --no-gpg-sign option with "git rebase"
In-Reply-To: <3511237.7GcYbsQxqc@g550jk>
Message-ID: <nycvar.QRO.7.76.6.1810221100330.4546@tvgsbejvaqbjf.bet>
References: <22001585.W2CEcL5IrY@g550jk> <nycvar.QRO.7.76.6.1810191729080.4546@tvgsbejvaqbjf.bet> <3511237.7GcYbsQxqc@g550jk>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OD/OYJJflb/G4zVlnON2rsfSXOb0SdgTBp0PXerIlLTf6d22+57
 Q06xH9d8nlpCY33pgF43Qc/VfgkEWRcnXQFLDhG6SZI/dnllBIL/iixIEQdknc/ObDZWNuQ
 idt/BVZA7VQhyPbFPTbfPh/4jVeIJ16dk2hRlWO/JPvO0pQk4sUzBwlaSjRV/MCrvL34QUp
 33BC1GpQXRW0ybHhNHnQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KEBGeeEmrtc=:SszYgUhuTScXmzMsIm6+yA
 XVgl0KyEAgHOsJyIRsBXsV/UO9HO2NELViJdoDItGU5W2fnztD/9h6cO1ZKIf/DilDURbyxuw
 s9NIZZuvn62Z/+5m3w1ri1TxzGfeWmaP/wzPV8SGgx7Q4QbAv/bI0iakmZmhvHQcgBzUxoYOV
 BnWJBSa5uODXZuEXTz/Vz8fuu/Fv7MvfnRK9YFD/v2WppWAR6A5q4SPjyo/3fPNS5D477mHJ7
 9GqxWtkKzwJ+9ot/COwMsBAKJOqCvrh/12HvV3E5vpCfBPxkl9y+RkU+qVHmh1JYm5S5AD3AQ
 IBPCNzQJ9+tkxx2aiB9eMC9pImRr53pVoaJDTUtMEJjttzfaIDtBmm5wHCsOOG//2DAd8pS4q
 HWrSBM4pA8sD0AJOWDxBTYHHJjpfnzoQry9NzHc+C0Q+eOysTtLe1DUEfRLOhm5dLIr3tcyia
 1mqVqNeU1ZzmISjBjhPXY6v2M82qHOMg66W7TIfPcwOLQuzzftcvf2be1SdtBZFXah0yRd8FD
 ggqBQ0McD/zSR78kyP3PDjCsAmnt4lam6kUVlQ7PwkERM8dU/MIZF2sfOFbmpusTdTtKAVk3B
 mdWprblg9IiZR8jvWYaVqJhKjI7MHJj7Ifxj0K7rFGyDb6K/INAWs+AQbRAmOv445lpMKaiyN
 vBH6JVyaCXKbMPWsM1/7LFzSMHnyXB0PKXc5KUPBCf0iRWkph3OuA5jxZCc311n75Tdh7V4p3
 r4/SQNp6FehPw3qjMpsmNrkC3EXfBzJlf9W76Py9Dat7hVOCndLlNEyH43X3aOP1lvM0bSZCq
 7/4vYG8jkvE01kN5n9izrx7zfJ57uKzsvTpcEOLJRta4r60a/g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luca,

I re-Cc:ed the Git mailing list (it is in general a very good idea to keep
it in Cc:, as I could be hit by a bus, for example).

On Fri, 19 Oct 2018, Luca Weiss wrote:

> On Freitag, 19. Oktober 2018 17:30:17 CEST you wrote:
> 
> > On Thu, 18 Oct 2018, Luca Weiss wrote:
> > > See subject, would be quite useful to have this. ("Countermand
> > > commit.gpgSign configuration variable that is set to force each and
> > > every commit to be signed.")
> > 
> > Have you tried the built-in rebase? It's already available in `next`,
> > and it is available in Git for Windows as an experimental feature.
>
> in the 'next' branch the option "--no-gpg-sign" is actually accepted for
> git rebase (not listed in "--help" output or the man page though) but
> git still tries to sign each commit.

Did you get a chance to debug this?

Ciao,
Johannes
