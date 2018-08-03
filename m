Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE0C5208E9
	for <e@80x24.org>; Fri,  3 Aug 2018 06:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeHCIUw (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 04:20:52 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:9755 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727250AbeHCIUw (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Aug 2018 04:20:52 -0400
X-IronPort-AV: E=Sophos;i="5.51,437,1526335200"; 
   d="scan'208";a="274863112"
Received: from abo-214-111-68.mrs.modulonet.fr (HELO [192.168.0.15]) ([85.68.111.214])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2018 08:25:49 +0200
Date:   Fri, 3 Aug 2018 08:25:48 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc:     Jeff King <peff@peff.net>,
        =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nicolas Palix <npalix@diku.dk>,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PoC] coccinelle: make Coccinelle-related make targets more
 fine-grained
In-Reply-To: <87bmaktpbt.fsf@evledraar.gmail.com>
Message-ID: <alpine.DEB.2.20.1808030824330.2446@hadrien>
References: <20180723135100.24288-1-szeder.dev@gmail.com> <20180802115522.16107-1-szeder.dev@gmail.com> <20180802180155.GD15984@sigill.intra.peff.net> <87bmaktpbt.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By the way, you can see my performance numbers here:

https://www.usenix.org/system/files/conference/atc18/atc18-lawall.pdf

Page 8, figures 4 and 5.

julia
