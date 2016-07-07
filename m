Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D18A02070D
	for <e@80x24.org>; Thu,  7 Jul 2016 15:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbcGGPym (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 11:54:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:59684 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922AbcGGPyl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 11:54:41 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M7Hao-1bWn3u1ZQ6-00x0DZ; Thu, 07 Jul 2016 17:54:24
 +0200
Date:	Thu, 7 Jul 2016 17:54:21 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 11/17] am: counteract gender bias
In-Reply-To: <xmqqmvltqxjs.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607071753370.6426@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <cover.1467717729.git.johannes.schindelin@gmx.de> <ea23faf258b6e62e770879362869f49eea4db869.1467717730.git.johannes.schindelin@gmx.de> <xmqq1t36sbqt.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607071323440.6426@virtualbox> <xmqqmvltqxjs.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gDWBYXM1Xt8lkSC5eTpDLhUYcv+lkoTgJgKtSmmyd0wJwbgqguD
 S2ooJqEAhMy6C+pg7U55tf+U8pSTWvgR3hDV4MfKdRn2Pb/xNyK3AE4OCZQU71sL7psAzcN
 fDmZGrV/ZswQrM0CiWgRVwZ15D6up7+L4dK3sv2YywGi7Z2SLE4tgmhLU3SRsuWBq9kybi4
 mHhvsyzNwJ3+ej10Vv0cQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:QzxSOwc/gjo=:avDnlrI3OHkq75+u8EP+Bl
 8H2uJNmxKbSQzmRC/nleMTYpGOBEM0FNe4a3NU+lwCg2JQg1AEtCNEZsssCuhWTYnrMcC/oWQ
 BBZB3iIsS3vXATVqrTHCe9wHV5WumSsw5tHH+dddpLO1CcY4gVhMxqAsToCjNG0Ddsdx5cZpy
 TlqrsLeNZKmI1WBkXSsNn7+iFpbkS6cq54O3lq3gqIrSw2unLa6Tk4PDaUudyda0w9rQJ7c5V
 L82IvZCcp2+iPTS1Yqysc0Qy+Vv3WHRA4feqZyE1Hsnf1pE71LDtDlXArJnkVA42kXRVpLn2E
 soU7TnVNwtm6ic9Zf45vpdNRAWcrS3salW14DpulorIsAYi2yB2BUao17EiDG8pktXFKn5qiw
 Q+5MQhi1fgihsRnoh0mHel5xr0Rs1m5WJ1u/YCu6Pvi1p9hC7DfSFKU0nDHcGZk6KzWKVtJTe
 qU/Ac6chC99ihEQ41b2NlS8iGdKVc51D5NYPTwJvXjTO1CA3JhdGzcOKURB6nxTRBFNUqjOQx
 lDSMFyDYqo1Adfrt6uSB6Smh0hPUAl66Qo+mSZnUiz7Ry8hq7nqJsWmNvzdcN7jyc+Wn/k/dX
 VGgOiU/sV/ls8IFLmYjY69eCAvAolQqOab05oVz1g5C2X76rPrzbpfty3egq1I13e3aQMFJEX
 rfDhtd+pr3dEcFKCHjH9FbfVN22B+0byv2QfX5pBRjbIeibDSWtIOAeWgw8o1bj+l5Bq4ibAG
 /QC3mxV8vuDR/BmKnsC5CrQUYhQExHaHHJS2bXFOsccf+my2u8gDE+YBA2FUImT8gG61XzvZz
 jW2unKR
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Thu, 7 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I doubt this kind fo distraction is desirable in the middle of a
> >> seriously heavy series like this one.  As a standalone clean-up to
> >> turn these directly to "their" that everybody would agree on and can
> >> be merged down quickly to 'master' that does not have to keep the
> >> body of the main topic waiting for the dust to settle might be a
> >> better approach.
> >>  ...
> > I am really curious, though. Has it not been our practice to encourage
> > preparatory patches like white-space or const fixes as part of patch
> > series that touch a certain part of the code that needed fixing?
> 
> Yes, isn't that "preparatory clean-up" what I said "might be a
> better approach"?

What I meant by "preparatory clean-up" is a patch in the patch series,
just as I had it.

Now it is a separate patch "series".

Ciao,
Dscho
