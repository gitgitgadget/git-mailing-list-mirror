Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D046C1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 15:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbcHLPiA (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 11:38:00 -0400
Received: from smtp90.iad3a.emailsrvr.com ([173.203.187.90]:45755 "EHLO
	smtp90.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752455AbcHLPgi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2016 11:36:38 -0400
Received: from smtp20.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
	by smtp20.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id D6D53604AD;
	Fri, 12 Aug 2016 11:28:27 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp20.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id B3CBE604A3;
	Fri, 12 Aug 2016 11:28:27 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.7.1);
	Fri, 12 Aug 2016 11:28:27 -0400
Subject: Re: [PATCH v5 00/12] Update git revisions
To:	Philip Oakley <philipoakley@iee.org>,
	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20160720211007.5520-1-philipoakley@iee.org>
 <20160812070749.2920-1-philipoakley@iee.org>
From:	Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <58d0df88-4902-4519-df21-3ba3d86a19c9@xiplink.com>
Date:	Fri, 12 Aug 2016 11:28:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160812070749.2920-1-philipoakley@iee.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-08-12 03:07 AM, Philip Oakley wrote:
> [2nd attempt : ISP troubles]
>
> This has grown like topsy from a little two patch series that tried to
> name the 2-dots notation [1] into this extended set of tweaks.

Honestly, I start just trying point out something concrete, like 
misrendered headers, but then I figure since I'm sending a review 
comment anyway I might as well go in-depth on the rest of the patch.

I think I'm sticking to substantive comments, but if I'm getting too 
picky please just swat me down!

		M.

