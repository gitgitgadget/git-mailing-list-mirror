Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4AAE20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 23:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753177AbdLEXhX (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 18:37:23 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:48555 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753171AbdLEXhW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 18:37:22 -0500
Received: from [192.168.178.21] (x4d075e6a.dyn.telefonica.de [77.7.94.106])
        by mxf98a.netcup.net (Postfix) with ESMTPSA id 1CBB2140CB2;
        Wed,  6 Dec 2017 00:37:21 +0100 (CET)
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.94.106) smtp.mailfrom=rabel@robertabel.eu smtp.helo=[192.168.178.21]
Received-SPF: pass (mxf98a: connection is authenticated)
Subject: Re: [PATCH v2 1/2] git-prompt: make __git_eread intended use explicit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <alpine.DEB.2.21.1.1712011143320.98586@virtualbox>
 <20171201233133.30011-1-rabel@robertabel.eu>
 <xmqqindmml25.fsf@gitster.mtv.corp.google.com>
 <e8d35c35-ffd5-ef10-bc6a-0834c1703995@robertabel.eu>
 <xmqqd13ukohs.fsf@gitster.mtv.corp.google.com>
 <818f414b-76ab-6e1d-0c5c-7f9959223e64@robertabel.eu>
 <xmqqlgihjpd6.fsf@gitster.mtv.corp.google.com>
From:   Robert Abel <rabel@robertabel.eu>
Message-ID: <23f95ab7-4ece-5252-5bae-16eec8f34824@robertabel.eu>
Date:   Wed, 6 Dec 2017 00:37:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqlgihjpd6.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <20171205233721.14285.32867@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Junio,

I'm amazed at how much time and energy you spend on correcting these
essentially non-issues in my git commit messages for a quadruple-liner
code change.

I'll resend both patches one last time addressing the grave issue of the
informative mention of multi-line files.

Regards,

Robert
