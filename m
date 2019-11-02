Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC1541F454
	for <e@80x24.org>; Sat,  2 Nov 2019 02:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfKBCnS (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 22:43:18 -0400
Received: from mxout017.mail.hostpoint.ch ([217.26.49.177]:46112 "EHLO
        mxout017.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727067AbfKBCnS (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 Nov 2019 22:43:18 -0400
X-Greylist: delayed 966 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Nov 2019 22:43:17 EDT
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout017.mail.hostpoint.ch with esmtp (Exim 4.92.3 (FreeBSD))
        (envelope-from <mail@marclandolt.ch>)
        id 1iQj89-000DGq-J7
        for git@vger.kernel.org; Sat, 02 Nov 2019 03:27:09 +0100
Received: from 178-82-219-75.dynamic.hispeed.ch ([178.82.219.75] helo=[192.168.179.102])
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3 (FreeBSD))
        (envelope-from <mail@marclandolt.ch>)
        id 1iQj89-000Mz5-Fi
        for git@vger.kernel.org; Sat, 02 Nov 2019 03:27:09 +0100
X-Authenticated-Sender-Id: mail@marclandolt.ch
To:     git@vger.kernel.org
From:   Marc Landolt <mail@marclandolt.ch>
Subject: GIT_SSL_NO_VERIFY=true -> mark username: red?
Message-ID: <21bef192-ca1a-7629-a00b-1e58b15273d3@marclandolt.ch>
Date:   Sat, 2 Nov 2019 03:27:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git

i use some repositories (i know i shouldn't) that don't have a SSL-Cert, 
when I use CTRL-R in bash i sometimes get the wrong git push... wouldn't 
it be nice if the "username:" then would appear read?

Greetings
Marc jr. Landolt

https://marclandolt.ch/HackersCardgame3/
https://2hmorvqnlhwyrhvl6dwv4jqgnvhlaf2wxnrbmbhrbpmx5x3qqiwprjyd.onion/free/hackerscardgame3
