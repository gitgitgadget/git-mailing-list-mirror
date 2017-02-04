Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 946B01F9AF
	for <e@80x24.org>; Sat,  4 Feb 2017 12:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754027AbdBDMGC (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 07:06:02 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:5315 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753471AbdBDMGC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 07:06:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 650C81E2CE1;
        Sat,  4 Feb 2017 13:05:58 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6CACK6CPhqDM; Sat,  4 Feb 2017 13:05:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 2AA431E2D79;
        Sat,  4 Feb 2017 13:05:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nSNqbd4-qIsP; Sat,  4 Feb 2017 13:05:58 +0100 (CET)
Received: from [192.168.178.28] (aftr-185-17-204-203.dynamic.mnet-online.de [185.17.204.203])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id CC3001E2CE1;
        Sat,  4 Feb 2017 13:05:57 +0100 (CET)
Subject: Re: [PATCH 1/2] doc: add doc for git-push --recurse-submodules=only
To:     Junio C Hamano <gitster@pobox.com>
References: <20170201230753.19462-1-cornelius.weig@tngtech.com>
 <xmqqinotmrhe.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, sbeller@google.com
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <f79acbf7-5c06-72e3-c410-aca320a26418@tngtech.com>
Date:   Sat, 4 Feb 2017 13:05:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqinotmrhe.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shouldn't this be part of v2.12-rc0? I just checked but it's not there.

Cheers,
  Cornelius
