Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE31D1F4DD
	for <e@80x24.org>; Fri, 18 Oct 2019 18:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442925AbfJRSPc (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 14:15:32 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:44241 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfJRSPb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 14:15:31 -0400
X-Originating-IP: 1.186.12.12
Received: from localhost (unknown [1.186.12.12])
        (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 338161BF20B;
        Fri, 18 Oct 2019 18:15:28 +0000 (UTC)
Date:   Fri, 18 Oct 2019 23:45:26 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v3] Doc: Bundle file usage
Message-ID: <20191018181526.6py52lp2oqkcqyp2@yadavpratyush.com>
References: <20191016210957.GA28981@sigill.intra.peff.net>
 <20191018151555.2277-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018151555.2277-1-philipoakley@iee.email>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/10/19 04:15PM, Philip Oakley wrote:
> From: Philip Oakley <philipoakley@iee.org>
> 
> Improve the command description, including paragraph spacing.
> 
> Git URLs can accept bundle files for fetch, pull and clone, include
> in that section. Include git clone in the bundle usage description.
> Correct the quoting of <git-rev-list-args>.
> 
> Detail the <git-rev-list-args> options for cloning a complete repo.
> 
> Signed-off-by: Philip Oakley <philipoakley@iee.email>

Reminder: The email in your signoff and From are different [0].

[0] https://public-inbox.org/git/59958c50-cbcb-ae9b-614f-ba28221f41ed@iee.email/

-- 
Regards,
Pratyush Yadav
