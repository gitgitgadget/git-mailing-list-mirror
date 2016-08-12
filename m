Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3326A1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 14:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbcHLOhJ (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 10:37:09 -0400
Received: from smtp122.iad3a.emailsrvr.com ([173.203.187.122]:47931 "EHLO
	smtp122.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752870AbcHLOhH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2016 10:37:07 -0400
Received: from smtp32.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
	by smtp32.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id E4846C04C0;
	Fri, 12 Aug 2016 10:37:01 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp32.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id BD7BCC00FC;
	Fri, 12 Aug 2016 10:37:01 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.7.1);
	Fri, 12 Aug 2016 10:37:01 -0400
Subject: Re: [PATCH v5 04/12] doc: revisions: give headings for the two and
 three dot notations
To:	Philip Oakley <philipoakley@iee.org>,
	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20160720211007.5520-1-philipoakley@iee.org>
 <20160812070749.2920-1-philipoakley@iee.org>
 <20160812070749.2920-5-philipoakley@iee.org>
Cc:	Jeff King <peff@peff.net>
From:	Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <a5cae9c9-8d38-37ef-2924-6d3a397a1715@xiplink.com>
Date:	Fri, 12 Aug 2016 10:37:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160812070749.2920-5-philipoakley@iee.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-08-12 03:07 AM, Philip Oakley wrote:
> While there, also break out the other shorthand notations and
> add a title for the revision range summary (which also appears
> in git-rev-parse, so keep it mixed case).
>
> We do not quote the notation within the headings as the asciidoc ->
> docbook -> groff man viewer toolchain, particularly the docbook-groff
> step, does not cope with two font changes, failing to return the heading
> font to bold after the quotation of the notation.

Looks good --thanks!

		M.

