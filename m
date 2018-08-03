Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DFFE1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 17:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeHCTlz (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 15:41:55 -0400
Received: from real-world-systems.com ([209.95.59.175]:35702 "EHLO
        slmp-550-17.slc.westdc.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727362AbeHCTlz (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Aug 2018 15:41:55 -0400
X-Greylist: delayed 4120 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Aug 2018 15:41:55 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=real-world-systems.com; s=default; h=Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Nb4EG1AYjRxiRaO6akTkhhNCfxheWv5JKdswkuShDOM=; b=K7YGrHiVqspXUtZtzzu5oCWLS
        EBhXw/n3ptfmwWpQplznD1Hn7TAp06yxOrU4l5o8FCNZDmrAlH5pd+AwwIDm4NGz2K5xw5ZM8s5w2
        r7D/XIUYiR+2+Td0ErBCw3chJjjOoGjJurnQorEqHrDsMKD/vOfGo4TspEAJlWFVI2S+PEI4RtM++
        xcU0yPQFcf/8o8WeN80ydFmaIKrCrrm5vBkbs9nSrmQRTE67ewV1DQYWoN2Sqai1SkRYdNWVWSJK5
        ReTSNY+oB6S+PXSWY0B97PV3D1u1rckefzh2P181aoECHyMQQaNVeQiZCfkezqFRdNORiAfJn0CAD
        fxUACWvng==;
Received: from pool-96-242-240-45.nwrknj.fios.verizon.net ([96.242.240.45]:65341 helo=[192.168.1.22])
        by slmp-550-17.slc.westdc.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <DGerman@Real-World-Systems.com>)
        id 1fld3l-000mmP-9t
        for git@vger.kernel.org; Fri, 03 Aug 2018 10:36:13 -0600
To:     git@vger.kernel.org
From:   Dennis German <DGerman@Real-World-Systems.com>
Subject: Need assistance synchronize a fork with it's parent
Message-ID: <35833f9c-8167-506b-ce37-cc089b051aea@Real-World-Systems.com>
Date:   Fri, 3 Aug 2018 12:36:12 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------CB4BC47B92F8C02BC0DA9422"
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - slmp-550-17.slc.westdc.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - Real-World-Systems.com
X-Get-Message-Sender-Via: slmp-550-17.slc.westdc.net: authenticated_id: realger1/from_h
X-Authenticated-Sender: slmp-550-17.slc.westdc.net: DGerman@Real-World-Systems.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------CB4BC47B92F8C02BC0DA9422
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

I need assistance synchronize a fork with it's parent

    https://github.com/DG12/ruuvitag_fw
    This branch is 5 commits ahead, 29 commits behind ruuvi:master.

I want to revise main.c and the issue a pull request.

Sorry, but I am lost.

Seems that I am trying to do something simple.

Any help / comments would be appreciated.

SIncerely,

Dennis German





--------------CB4BC47B92F8C02BC0DA9422
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>I need assistance synchronize a fork with it's parent<br>
    </p>
    <blockquote>
      <p><a class="moz-txt-link-freetext" href="https://github.com/DG12/ruuvitag_fw">https://github.com/DG12/ruuvitag_fw</a><br>
        This branch is 5 commits ahead, 29 commits behind ruuvi:master.</p>
    </blockquote>
    <p>I want to revise main.c and the issue a pull request.</p>
    <p>Sorry, but I am lost.</p>
    <p>Seems that I am trying to do something simple.</p>
    <p>Any help / comments would be appreciated.</p>
    <p>SIncerely,</p>
    <p>Dennis German<br>
    </p>
    <p><br>
    </p>
    <blockquote>
      <p><br>
      </p>
      <p><br>
      </p>
    </blockquote>
  </body>
</html>

--------------CB4BC47B92F8C02BC0DA9422--
