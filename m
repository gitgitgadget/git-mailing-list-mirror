Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E9B51F89D
	for <e@80x24.org>; Thu, 27 Jul 2017 08:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbdG0I4g (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 04:56:36 -0400
Received: from cirse-smtp-out.extra.cea.fr ([132.167.192.148]:58007 "EHLO
        cirse-smtp-out.extra.cea.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751466AbdG0I4f (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Jul 2017 04:56:35 -0400
X-Greylist: delayed 1523 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jul 2017 04:56:35 EDT
Received: from epeire1.extra.cea.fr (epeire1.extra.cea.fr [132.167.198.31])
        by cirse-sys.extra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with ESMTP id v6R8V9dB047764;
        Thu, 27 Jul 2017 10:31:09 +0200
Received: from epeire1.extra.cea.fr (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 599395C503E;
        Thu, 27 Jul 2017 10:31:09 +0200 (CEST)
Received: from orpin2.extra.cea.fr (orpin2.extra.cea.fr [132.167.198.5])
        by epeire1.extra.cea.fr (Postfix) with ESMTP id 30E2D5C49E8;
        Thu, 27 Jul 2017 10:31:09 +0200 (CEST)
Received: from [132.166.17.90] (iram-ha-003601.extra.cea.fr [132.166.17.90])
        by orpin2.extra.cea.fr (8.15.2/8.15.2/CEAnet-Intranet-out-1.4) with ESMTP id v6R8V8wg006693;
        Thu, 27 Jul 2017 10:31:09 +0200
Subject: Re: requesting permission to use some Git for Windows code
To:     elizaretskii@gmail.com,
        git-for-windows <git-for-windows@googlegroups.com>
Cc:     vdhoeven@lix.polytechnique.fr, git@vger.kernel.org
References: <a730cebb-1782-f32b-0b7c-253bd61475d6@cea.fr>
 <alpine.DEB.2.21.1.1706281259170.84669@virtualbox>
 <83bce6b8-a5eb-4914-a2d3-edd57050bfaa@googlegroups.com>
From:   Philippe Joyez <philippe.joyez@cea.fr>
Message-ID: <4517a3d2-5acb-e7b5-8cd6-0c5fe57811d1@cea.fr>
Date:   Thu, 27 Jul 2017 10:31:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <83bce6b8-a5eb-4914-a2d3-edd57050bfaa@googlegroups.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 25/07/2017 à 15:53, Johannes Schindelin a écrit :
>
> It is great that you can make use of the code!
>
> As to the licensing problem, I agree it is a hassle. The biggest obstacle
> is that you have to have the consent of all the authors.
>
> You hereby have mine.
>

Many thanks Johannes for your positive personal answer but also for the
very detailed tips on how to handle this.

Le 27/07/2017 à 06:30, elizaretskii@gmail.com a écrit :
>
>
> An alternative would be for TeXmacs to use the code from GNU Emacs,
> which also supports Unicode file names on MS-Windows.  Emacs is of
> course GPL v3+, so there should be no problem with that.
>
Thanks you too Eli, for bringing up that piece of information; I'll
definitely take a look into it!

Philippe
