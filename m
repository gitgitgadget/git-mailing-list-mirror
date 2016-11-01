Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ED9B20229
	for <e@80x24.org>; Tue,  1 Nov 2016 18:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbcKASMZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 14:12:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:56445 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751726AbcKASMY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 14:12:24 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MXq3L-1cPVlr1IHP-00WkYr; Tue, 01 Nov 2016 19:12:12
 +0100
Date:   Tue, 1 Nov 2016 19:01:07 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git-for-windows@googlegroups.com,
        Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.10.2
In-Reply-To: <alpine.DEB.2.20.1610291031250.3264@virtualbox>
Message-ID: <alpine.DEB.2.20.1611011859590.3264@virtualbox>
References: <xmqqd1ijwu3s.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1610291031250.3264@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MDlLBNvYKq88W1QM/1zJpp2w34YlqOb7TUOTxJ3TA/mHP1PHLvI
 I26qwLp7+6YOeLGnfqEEwPb3+kJIsNUPkCLQPSVqVWGkVGR0LJHof5WAD3vVlcY69+jBjfr
 kflbOYAcTBOdShPhzwjt+csDl668IYbjkN4CTC5dAWUVbt0Ml3oVNhTFKlitIM8NevHOQBP
 oBgrwSt8x0AA1VrOFIkLQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0KiFDxZFYP8=:XggyvPJpZt4RHF19R0baaO
 trWyxM8UjLWNU+GpTupT3V2UnCghyZCVogz3h5kF0fD3glotHLkj5CeeLysv7dlyPNUc4MJFt
 B/iRs8CrGc8hTc6nVy9K30j0gv9sx8xknk54ykH1zSo2GuoYUgxhJfxh67wX5upNf/s4XGNxr
 hPMvGp4cs9t+l7NZCcViHCmv9CYNxllPiaEFFYLdY6NmBjE3qyXqBR/N/2ocP6kp6D7blYFzF
 MLtf06eZhZULw1BOLRkLatrlVlKpu4X4ERBlL+HxTXOBmNPr+E9Ps6Fnvz8yj5aNtI6Xeh4kE
 jebM1jXm0JeQrc/hSD+n7pkV9tMyifSFjUEzWvZLWJsuRr9d7uyX3Wi/Y/KQE665hlRc9tEGC
 GPt3XIcWhBbJIo4gzY6mzf0NoxwRMYoP1GCcGidJ5IUmzsTiiJbtqa/GJopypkmesvG0jsR0j
 bDxBeRhSehHTgyHZRfdz83xTB3CiYlSvkrnTcBEGPmaumY4BZu/30fsox1lg8A5bydxJmL/LO
 uldwPNkURpWX2MF2aseWmWUHYEFa7LiO0uj/+vdBNcUXEMKob45sanHUQSji9mkHPv1hoHgvh
 TDwFJQmSlAOXm0iC3Fn33NeMJlUQaMMiQ/sjfRbIhXaVHT+IVbd89joI+a0b0E6n5gQn+lVft
 VALarQbmnNT5W8wRThanUCZEMOIPuBuVfhYzkahc2Ux6qBtnEN4HGttoMrSVIRV7XROGBgluk
 MzG48EQzLaj/DmiRLvTHnA61w6haHcLQCSoUa1EV7MDoecMMQz2o4Jc8t4zwwpFliOCZMPhUJ
 MB5gYhP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

On Sat, 29 Oct 2016, Johannes Schindelin wrote:

> On Fri, 28 Oct 2016, Junio C Hamano wrote:
> 
> > The latest maintenance release Git v2.10.2 is now available at
> > the usual places.
> 
> The corresponding Git for Windows version will be hopefully out on
> Tuesday: https://github.com/git-for-windows/git/milestone/5

As of time of writing, cURL has not been released. Git for Windows v2.10.2
will have to wait for tomorrow, or whenever cURL 7.51.0 will be released.

Ciao,
Johannes
