Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=2.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,HEADER_FROM_DIFFERENT_DOMAINS,INVALID_MSGID,
	MSGID_FROM_MTA_HEADER,MSGID_NOFQDN1,PLING_QUERY,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: (qmail 32212 invoked by uid 111); 24 Jun 2008 03:26:07 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 23 Jun 2008 23:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbYFXDZy (ORCPT <rfc822;peff@peff.net>);
	Mon, 23 Jun 2008 23:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbYFXDZy
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 23:25:54 -0400
Received: from w2.willowmail.com ([64.243.175.54]:59983 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752245AbYFXDZy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 23:25:54 -0400
Received: (qmail 7236 invoked by uid 90); 24 Jun 2008 03:25:33 -0000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:	"David Jeske" <jeske@google.com>
To:	Nicolas Pitre <nico@cam.org>
Cc:	git@vger.kernel.org
Subject: Re: why is git destructive by default? (i suggest it not be!)
X-Mailer: Willow v0.02
Date:	Tue, 24 Jun 2008 03:18:45 -0000
Message-ID: <willow-jeske-01l5e9cgFEDjCh3F>
Received: from 67.188.42.104 at Tue, 24 Jun 2008 03:18:45 -0000
References: <alpine.LFD.1.10.0806232213360.2979@xanadu.home>
	<willow-jeske-01l5PFjPFEDjCfzf-01l5ciVtFEDjCaD9>
In-Reply-To: <alpine.LFD.1.10.0806232213360.2979@xanadu.home>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

-- Nicolas Pitre wrote:
>> or we expect "running without ever collecting the log"
>> to be a valid mode of operation... which I doubt is the case.
>
> Why not?

Is see the hole I left in my logic, so let me restate.

... or we expect "human parsing of the the log" is a valid common
user-interface for non-git developers.
