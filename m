Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A82CB20401
	for <e@80x24.org>; Thu, 15 Jun 2017 20:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbdFOUQj (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 16:16:39 -0400
Received: from filter01.peak.org ([207.55.16.92]:48981 "EHLO filter01.peak.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751639AbdFOUQh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 16:16:37 -0400
X-Greylist: delayed 629 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Jun 2017 16:16:37 EDT
Received: from zmail-mta02.peak.org ([207.55.16.112])
          by filter01.peak.org ({e1c81c21-e4c4-4528-aa90-7a27869c545a})
          via TCP (outbound) with ESMTPS id 20170615200603611_0000;
          Thu, 15 Jun 2017 13:06:03 -0700
X-RC-FROM: <scott@perturb.org>
Received: from zmail-mta02.peak.org (localhost [127.0.0.1])
        by zmail-mta02.peak.org (Postfix) with ESMTPS id 4E9294D29D;
        Thu, 15 Jun 2017 13:06:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zmail-mta02.peak.org (Postfix) with ESMTP id 1714F4D2EA;
        Thu, 15 Jun 2017 13:06:00 -0700 (PDT)
Received: from zmail-mta02.peak.org ([127.0.0.1])
        by localhost (zmail-mta02.peak.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tdJWaY597iVI; Thu, 15 Jun 2017 13:05:59 -0700 (PDT)
Received: from mailproxy-lb-07.peak.org (mailproxy-lb-07.peak.org [207.55.17.97])
        by zmail-mta02.peak.org (Postfix) with ESMTP id D9FE84C875;
        Thu, 15 Jun 2017 13:05:59 -0700 (PDT)
Subject: Re: [PATCH] diff-highlight: split code into module
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20170615163055.b63hcivjogafkerq@sigill.intra.peff.net>
 <xmqqpoe512rc.fsf@gitster.mtv.corp.google.com>
From:   Scott Baker <scott@perturb.org>
Message-ID: <70fc9096-ce97-e781-3cca-bae7c3ce5b20@perturb.org>
Date:   Thu, 15 Jun 2017 13:05:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqpoe512rc.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-MAG-OUTBOUND: peakinternet.redcondor.net@207.55.16/22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/15/2017 12:15 PM, Junio C Hamano wrote:
> Do you want +x bit for the last one?  I could throw that bit in
> while queuing if you want.
>
> Thanks.
>
Ya probably best.


