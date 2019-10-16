Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1AB91F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 10:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404603AbfJPKPu (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 06:15:50 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:48912 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbfJPKPu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 06:15:50 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iKgLM-0001ER-3E; Wed, 16 Oct 2019 11:15:48 +0100
Subject: Re: [PATCH v2] Doc: Bundle file usage
To:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
References: <7vzk4mj38g.fsf@alter.siamese.dyndns.org>
 <20191016095737.1588-1-philipoakley@iee.email>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <59958c50-cbcb-ae9b-614f-ba28221f41ed@iee.email>
Date:   Wed, 16 Oct 2019 11:15:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016095737.1588-1-philipoakley@iee.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/10/2019 10:57, Philip Oakley wrote:
> From: Philip Oakley <philipoakley@iee.org>
Oops - the From: line still has my old email address. Is a resend 
preferred, or can it be fixed locally?

P.
> Git URLs can accept bundle files for fetch, pull and clone, include
> in that section. Include git clone in the bundle usage description.
> Correct the quoting of <git-rev-list-args>.
> Detail the <git-rev-list-args> options for cloning a complete repo.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.email>
> ---
>
> This takes up the advice from peff in
> https://public-inbox.org/git/20191011161112.GA19741@sigill.intra.peff.net/
> from the original v1 in 2012(!)
> https://public-inbox.org/git/1348010734-664-2-git-send-email-philipoakley@iee.org/
>
> Hopefully this covers Junio's concerns from that time.

