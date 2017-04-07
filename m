Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5616B20966
	for <e@80x24.org>; Fri,  7 Apr 2017 17:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756152AbdDGRfT (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 13:35:19 -0400
Received: from 5.itsy.de ([188.40.84.14]:43370 "EHLO 5.itsy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753290AbdDGRfT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 13:35:19 -0400
Received: from [192.168.0.13] (84-72-0-73.dclient.hispeed.ch [84.72.0.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 5.itsy.de (Postfix) with ESMTPSA id 73E5C644E5
        for <git@vger.kernel.org>; Fri,  7 Apr 2017 19:35:17 +0200 (CEST)
Subject: Re: [PATCH] submodule: prevent backslash expantion in submodule names
References: <CAGZ79ka7PEWy2iA8V9s11n2kyD=vHyS2y1K3SJzDq-5HsY7how@mail.gmail.com>
 <20170407172306.172673-1-bmwill@google.com>
To:     git@vger.kernel.org
From:   Joachim Durchholz <jo@durchholz.org>
Message-ID: <ab8959a3-0a26-b60e-fb11-ee743b740780@durchholz.org>
Date:   Fri, 7 Apr 2017 19:35:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170407172306.172673-1-bmwill@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks!
