Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86E7C1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 19:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbfHFTbR (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 15:31:17 -0400
Received: from elephants.elehost.com ([216.66.27.132]:52606 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfHFTbR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 15:31:17 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x76JVFCe000664
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Tue, 6 Aug 2019 15:31:15 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [Question] git checkout lifespan
Date:   Tue, 6 Aug 2019 15:31:08 -0400
Message-ID: <002c01d54c8d$8287b850$879728f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        boundary="----=_NextPart_000_001C_01D54C6A.CEBC29E0";
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFz+gjahvL0l/f6FugjsrFPJmpshg==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

I don't recall when this was previously discussed, but the timing is
relevant at 2.23.0. With switch and restore commands coming in this release,
I was wondering how long checkout will be provided for compatibility - or if
it will be deprecated at all. I assume that enhancements should only go to
switch and restore, but what of fixes? Should they go to only the new
commands or both?

Thanks,
Randall

-- Brief whoami:
NonStop developer since approximately 211288444200000000
UNIX developer since approximately 421664400
-- In my real life, I talk too much.



