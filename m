Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C72DF202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 20:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbdJZUv3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 16:51:29 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:11713 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751651AbdJZUv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 16:51:29 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3yNK1C5lPSz5tl9;
        Thu, 26 Oct 2017 22:51:27 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 49A0F306;
        Thu, 26 Oct 2017 22:51:27 +0200 (CEST)
Subject: Re: Consequences of CRLF in index?
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com>
 <eda48d5e-a52c-9a39-8e55-a6828efdb3ef@kdbg.org>
 <alpine.DEB.2.21.1.1710251415040.6482@virtualbox>
 <5e962f69-f9cb-bd7e-481f-050e6239813f@kdbg.org>
 <30ED36AB-FAB1-4635-94AF-FCEC6F02CE01@gmail.com>
 <7a4396e8-7b97-9ec9-d028-c5ad29042c86@kdbg.org>
 <20171026203046.fu3z5ngnw7hckfrn@aiede.mtv.corp.google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <f56a02d6-fbf9-188f-d19f-3d48708d9268@kdbg.org>
Date:   Thu, 26 Oct 2017 22:51:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171026203046.fu3z5ngnw7hckfrn@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the clarification, it's much appreciated.

-- Hannes

