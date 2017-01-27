Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D0BE1F437
	for <e@80x24.org>; Fri, 27 Jan 2017 20:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbdA0UFN (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 15:05:13 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:63507 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdA0UEY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 15:04:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id A6D7B1E2FBA
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 21:04:21 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XZ7cQ3_uQ9rR for <git@vger.kernel.org>;
        Fri, 27 Jan 2017 21:04:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 7405E1E2FD8
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 21:04:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AY2INDmEwfsV for <git@vger.kernel.org>;
        Fri, 27 Jan 2017 21:04:21 +0100 (CET)
Received: from [192.168.178.28] (aftr-185-17-206-252.dynamic.mnet-online.de [185.17.206.252])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 44EDD1E2FBA
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 21:04:21 +0100 (CET)
Subject: Re: [PATCH] doc: clarify distinction between sign-off and pgp-signing
To:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <20170127200136.29949-1-cornelius.weig@tngtech.com>
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <d65bc165-9bd3-c7a6-9a55-1904d1bc095e@tngtech.com>
Date:   Fri, 27 Jan 2017 21:04:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170127200136.29949-1-cornelius.weig@tngtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, I forgot to mark this patch as follow-up to message
<xmqq60l01jr9.fsf@gitster.mtv.corp.google.com>
