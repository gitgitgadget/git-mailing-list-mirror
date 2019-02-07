Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AAA81F453
	for <e@80x24.org>; Thu,  7 Feb 2019 19:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfBGTuO (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 14:50:14 -0500
Received: from mout.gmx.net ([212.227.15.15]:42925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfBGTuO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 14:50:14 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Meg8W-1gTi9o2CXw-00OJsP; Thu, 07
 Feb 2019 20:50:08 +0100
Date:   Thu, 7 Feb 2019 20:50:08 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.21.0-rc0
In-Reply-To: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1902072049080.41@tvgsbejvaqbjf.bet>
References: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eR1YsvGvFiDYiMy8hU9Q/MbJkP575dAqQEQzDK9RaRuasWPVVl/
 C9F4ifKwPccCf5w3jVq8rYN7yPW5mMPxDIRcq9ZH7XiHK8uTfgc+snQTNjiaugKxHXaai4X
 bTXjxu3j4LhGcEtDI2HGqD2ufeEVlVLWX0rla5btu/1lqD0QhC50rYMRmBoHy46lcEvMpz3
 npDaEU2652ooboBEV92Kw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BZIDDRE3DKM=:grFlkxpegSrvawTMYq4BwL
 3FCPpVoTRy9u1oCHY1AWXWrT9pgm+jTcH7a8F5htZCddHA13Fk1kPW6CIhT8SqGGjiwSzuhcU
 K1Y9O0U1OyS9rkap3mNyWBAXRTQHnfTm906w/+wsOKcXxucDFUWBh5RNDSbOlY5rHwXgtNZgg
 nddoeSWRzen7j2gzUyUf6UT7SAv/XbD94gQG++Vet9kuxoVurLKnTzrF5Q48l1rA86P8N++8D
 nchpI+vJHuDRwymW7mCLgmgaQ9EBd2/Vo6+yAS2LxsBofHlnzUtde/mjXgCWQdOzG6y3EykXg
 2Q6G4ILZkVvqfuEH0KtE+sPDJWjr4+khOq+Dz3epS7zjdv27WTI/FgdysCJOtDj9Kou3dS/W7
 IuZtJct2peZclQeNlvBcGGoDcluUShMGfVkDPOraFS13EscZqtzQJ3GRU1h4cAFDKThF76fmd
 pbUwg+m6u1/IVfqQnrYycdm1KcbsyRa2Gf0FQ+rcfoTaZVGBx0giqk5qmc3zqTcoJxoJZzj7M
 Q2/nzUpDkwaKmvEQ4cmLKQDuva0H+UUjpWmmyF23yW0kkk8UHqP8JmRDAITYzsJAAYSjrGaa0
 PDxaB3hbF8rcWYAzeHEwqHfTaaCBkrzY0uITFLiR5+/rwH6WFUQUfDQtrKd0labN6JBiVFq7r
 xr9hY5NFt+yNpowXzisXS6yHl2xwtg89JHBIajpvOZHFG8nvNrxkBaTSzLZyMbwnee/y5sX18
 uQKQOVjowmY+SRC7AKvbwP+9qrspAjZ6Zmql2FnxRN4eu2aaImSHrotj+VweXp8/W2J2qtc7G
 wCV4T9DT6tuPSjjhaqV1IWlALVXj2BE9Bl5ZglJ/dPeHupIv98PZRtRqfrSQGWLhsagxV+ROH
 X4rAZrvonwLQRAGNK4nsbEsDzCg08lip69JkknSGlw4PEPKGs0IFZEGJL9w2THFsgjEneTbR0
 Jm1YWI8Vf/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 6 Feb 2019, Junio C Hamano wrote:

> New contributors whose contributions weren't in v2.20.0 are as follows.
> Welcome to the Git development community!
> 
>   Arti Zirk, Brandon Richardson, Chayoung You, Denis Ovsienko, Erin
>   Dahlgren, Force Charlie, Frank Dana, Issac Trotts, Laura Abbott,
>   Patrick Hogg, Peter Osterlund, Shahzad Lone, and Slavica Djukic.

Could you include Tanushree Tumane in that list? Granted, so far they
mostly cleaned up Pranit Bauva's patches, keeping the authorship, but
still...

Thanks,
Dscho
