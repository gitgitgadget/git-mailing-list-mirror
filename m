Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C89931F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 13:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfHLNgs (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 09:36:48 -0400
Received: from elephants.elehost.com ([216.66.27.132]:44686 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfHLNgr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 09:36:47 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x7CDaewV045445
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 12 Aug 2019 09:36:40 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <xmqqk1bmcf3q.fsf@gitster-ct.c.googlers.com> <20190809212017.GB8440@Gentoo> 
In-Reply-To: 
Subject: RE: [ANNOUNCE] Git v2.23.0-rc2
Date:   Mon, 12 Aug 2019 09:36:34 -0400
Message-ID: <003101d55112$f89da5c0$e9d8f140$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFKX3pRulh6YnLsH28sbgpb1x6NFQEhNevkqAAod5CABDShsA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 9, 2019 5:24 PM,  I wrote:
> On 12:29 Fri 09 Aug 2019, Junio C Hamano wrote:
> > >A release candidate Git v2.23.0-rc2 is now available for testing at
> > >the usual places.  It is comprised of 483 non-merge commits since
> > >v2.22.0, contributed by 67 people, 24 of which are new faces.
> > >
> > >The tarballs are found at:
> > >
> > >    https://www.kernel.org/pub/software/scm/git/testing/
> *big-snip*
> 
> NonStop platform testing is in progress.

NonStop platform testing passed.
Thanks all.

