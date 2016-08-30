Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7294C1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 18:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758527AbcH3SV2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 14:21:28 -0400
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:45980 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751645AbcH3SV1 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Aug 2016 14:21:27 -0400
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 643D312BD05;
        Tue, 30 Aug 2016 18:21:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hair70_298bc9de8cc14
X-Filterd-Recvd-Size: 1396
Received: from XPS-9350.home (unknown [96.251.125.34])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue, 30 Aug 2016 18:21:25 +0000 (UTC)
Message-ID: <1472581284.5512.117.camel@perches.com>
Subject: Re: git am and duplicate signatures
From:   Joe Perches <joe@perches.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Date:   Tue, 30 Aug 2016 11:21:24 -0700
In-Reply-To: <xmqqshtm3yur.fsf@gitster.mtv.corp.google.com>
References: <1472573556.5512.93.camel@perches.com>
         <xmqqwpiy5haf.fsf@gitster.mtv.corp.google.com>
         <1472577999.5512.107.camel@perches.com>
         <xmqq8tve5fet.fsf@gitster.mtv.corp.google.com>
         <1472578879.5512.111.camel@perches.com>
         <1472579363.5512.113.camel@perches.com>
         <xmqqshtm3yur.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2016-08-30 at 11:17 -0700, Junio C Hamano wrote:
> Joe Perches <joe@perches.com> writes:
> 
> > 
> > On Tue, 2016-08-30 at 10:41 -0700, Joe Perches wrote:
> > > 
> > > Maybe something like traces or chains.
> > Or "taggers" or "tagged-bys"
> I am afraid that you are way too late; the ship has already sailed a
> few years ago, if not earlier, I think.

What's the ship's name?  Is it footers or trailers?

