Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B42E1FF40
	for <e@80x24.org>; Mon,  5 Dec 2016 11:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbcLELUF convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 5 Dec 2016 06:20:05 -0500
Received: from smtp-out4.electric.net ([192.162.216.188]:60428 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbcLELUF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 06:20:05 -0500
X-Greylist: delayed 836 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Dec 2016 06:20:04 EST
Received: from 1cDr5w-0004mY-V9 by out4c.electric.net with emc1-ok (Exim 4.87)
        (envelope-from <thomas.attwood@stfc.ac.uk>)
        id 1cDr5x-0006hi-Uz; Mon, 05 Dec 2016 03:06:05 -0800
Received: by emcmailer; Mon, 05 Dec 2016 03:06:05 -0800
Received: from [130.246.236.11] (helo=exchsmtp.stfc.ac.uk)
        by out4c.electric.net with esmtps (TLSv1:ECDHE-RSA-AES256-SHA:256)
        (Exim 4.87)
        (envelope-from <thomas.attwood@stfc.ac.uk>)
        id 1cDr5w-0004mY-V9; Mon, 05 Dec 2016 03:06:04 -0800
Received: from EXCHMBX01.fed.cclrc.ac.uk ([130.246.236.13]) by
 EXCHHUB03.fed.cclrc.ac.uk ([130.246.236.11]) with mapi id 14.03.0266.001;
 Mon, 5 Dec 2016 11:05:41 +0000
From:   <thomas.attwood@stfc.ac.uk>
To:     <tboegi@web.de>, <peff@peff.net>
CC:     <git@vger.kernel.org>
Subject: RE: git 2.11.0 error when pushing to remote located on a windows
 share
Thread-Topic: git 2.11.0 error when pushing to remote located on a windows
 share
Thread-Index: AQHSTOy2DsC60xIvQbi3TRYfROIxx6D3cY0AgAG+XKA=
Date:   Mon, 5 Dec 2016 11:05:40 +0000
Message-ID: <AABB04BF1441D24CB4E9FCF46394F17D666F3805@exchmbx01>
References: <AABB04BF1441D24CB4E9FCF46394F17D666F34E1@exchmbx01>
 <20161202223749.2n7wa37e5w6446uv@sigill.intra.peff.net>
 <20161204080914.GB2415@tb-raspi>
In-Reply-To: <20161204080914.GB2415@tb-raspi>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.246.243.42]
x-esetresult: clean, is OK
x-esetid: 37303A29411E556763776B
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Outbound-IP: 130.246.236.11
X-Env-From: thomas.attwood@stfc.ac.uk
X-Proto: esmtps
X-Revdns: exchhub03.rl.ac.uk
X-HELO: exchsmtp.stfc.ac.uk
X-TLS:  TLSv1:ECDHE-RSA-AES256-SHA:256
X-Authenticated_ID: 
X-PolicySMART: 3590380
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 4 Dec 2016 08:09:14 +0000, Torsten Bögershausen wrote:
> There seems to be another issue, which may or may not being related:
> https://github.com/git-for-windows/git/issues/979

I think this is the same issue. I've posted my trace command output there as
It might be more appropriate:
https://github.com/git-for-windows/git/issues/979#issuecomment-264816175

