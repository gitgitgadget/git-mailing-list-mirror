Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22EB51F516
	for <e@80x24.org>; Wed, 27 Jun 2018 10:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbeF0KwI (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 06:52:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:56927 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750774AbeF0KwI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 06:52:08 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M85r3-1gKL1I17JZ-00vfW9; Wed, 27
 Jun 2018 12:52:05 +0200
Date:   Wed, 27 Jun 2018 12:52:04 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     dana <dana@dana.is>
cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>
Subject: Re: [PATCH] rebase -i: Fix white space in comments
In-Reply-To: <D5941A31-B9B3-4EB1-9D55-D5E86A541D2C@dana.is>
Message-ID: <nycvar.QRO.7.76.6.1806271251130.21419@tvgsbejvaqbjf.bet>
References: <614F0C12-7173-48BD-9212-71AD6FBBDAA7@dana.is> <nycvar.QRO.7.76.6.1806262329390.21419@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1806262331340.21419@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1806262343410.21419@tvgsbejvaqbjf.bet>
 <D5941A31-B9B3-4EB1-9D55-D5E86A541D2C@dana.is>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:w1GDJGgh9vHOELcFA9lMTv+ugy4r8590gatmyzmLkDci9izLYDo
 MCOBYPpB/xb2ypM9qpIvvDGtgkYyfFs1cp2LWXqeJJZfFcVrl7B9b3oiFfN9IDw4p/NbaaN
 BEg1z5HYB4RDE6V/h34oVBqw5uUWar971eJuDR1VUrzo7bxxodk2qzcPDlfr7AefvXB0vZu
 c2uZNcEtIiMp8MY9On77Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M7gTe3h4JhU=:06ncxyKPkT4/6kuR/JODa9
 R0NSC2QM0M5tqXFZMZ1ebYepopJhPFPEF/MDTx1kCjJHLsO1xK6YZuGvrODEXn3X+rmddcuHa
 On3GKnfJqsPRyG8JWaMs4h9iB7eYKNJIroUR0lNqu+/c9LPty0AZQy5r0CGNvbkjefwY4QUhi
 /osvbUb/kIH8mA21/rkg+p4c+rFpZdUZ1ZuJ5c/5LEUem0aGW0I/r9e50AEthqGWfxlzeSaPD
 BrX/GAR+Ag2nYV4OjX3xnSObdhpls4JfC+cY6OaqkeoAFNyl5KgLCUsHVbCx3o26aUcHk/pBe
 wbH0HdcPhM5Y5f0Z6ScED9AH2EHejnyvEGOO0y8M8aQ8JNKhaLBo5FHCa6RgyKsqVmMp3v+FF
 RF+zP6ldRMIRZ6SJjgjo8Ei+Twm/6WpvKBqMFxYetF5hhwAw4GlTUPIn+OEsKIxig/0z9d+Us
 /Rx9JSOEKbE8mtqNc/nv2Qni2Z4dq+bD2iHHdrpxEgFqq62ordNlsx9g9Eny1UXHFi1q+DkA+
 MGSTlKD1AoCw3LPfT33Sxb6L2MbOKtdSKuD2bwzVerUrUP4T38NA9HwhMH09miH5mdvPND8R/
 owHojeDXZdNERZKR1pIG8Ivkk2Yv9WGcFuS8Rs46B7YX+qImejSMdNKBJGUdBLBDfnteK1ZbF
 xxkqrmVtGvPPj8vMGwtCbYdH7MJpi8VIc6ZciI4ChfDwnAbPEoFJ1C2cLo9X2jZOuL1Vb+JiC
 Q0PbhsCKnBt6eK3cYkzlpp055AymBdCjT+rFQcvnRaugRYV8Lxd9QyjMVDGp+kmq5las4UM/R
 lsrr1cl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dana,

On Tue, 26 Jun 2018, dana wrote:

> On 26 Jun 2018, at 16:44, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >There is of course one other way to fix this, and that is by rewriting
> >this in C.
> >
> >Which Alban has done here ;-)
> >
> >http://public-inbox.org/git/20180626161643.31152-3-alban.gruin@gmail.com
> 
> Oh, i'm sorry, i didn't see that.

No need to be sorry, nobody expects you to read the "firehose" that is the
Git mailing list in its entirety.

> That change does appear to solve the same problem, so i'm happy to defer
> to it.

Thank you for confirming that it also fixes your issue, that is very
helpful!

Ciao,
Johannes
