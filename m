Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C20ED2042F
	for <e@80x24.org>; Wed, 16 Nov 2016 15:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752360AbcKPPQp convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 16 Nov 2016 10:16:45 -0500
Received: from sp-internet-ext-ply.uhc.com ([198.203.175.175]:47357 "EHLO
        mail16.uhc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753157AbcKPPQo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 10:16:44 -0500
X-IronPort-AV: E=Sophos;i="5.31,500,1473138000"; 
   d="scan'208";a="652527218"
Received: from irmelr25.uhc.com (HELO mail15.uhc.com) ([10.177.105.52])
  by mail18.uhc.com with ESMTP; 16 Nov 2016 09:16:42 -0600
X-IronPort-AV: E=Sophos;i="5.31,500,1473138000"; 
   d="scan'208";a="628599696"
X-CONF-FOOTER: True
Received: from apsep0935.ms.ds.uhc.com ([10.123.233.191])
  by mail15.uhc.com with ESMTP; 16 Nov 2016 09:16:42 -0600
Received: from apswp0428.ms.ds.uhc.com ([fe80::7cb7:a560:d0b0:bc2d]) by
 apsep0935.ms.ds.uhc.com ([fe80::b1af:873c:6d8:8173%19]) with mapi id
 14.03.0279.002; Wed, 16 Nov 2016 09:16:42 -0600
From:   "Vanderhoof, Tzadik" <tzadik.vanderhoof@optum360.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: merge --no-ff is NOT mentioned in help
Thread-Topic: merge --no-ff is NOT mentioned in help
Thread-Index: AdJAHG6Flm+eVlqaTkiiWd+ULmGgtw==
Date:   Wed, 16 Nov 2016 15:16:41 +0000
Message-ID: <2C8817BDA27E034F8E9A669458E375EF2BE63B@APSWP0428.ms.ds.uhc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.204.2.151]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-IP-VFilter-R: R
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I do: "git merge -h"  to get help, the option "--no-ff" is left out of the list of options.

This e-mail, including attachments, may include confidential and/or
proprietary information, and may be used only by the person or entity
to which it is addressed. If the reader of this e-mail is not the intended
recipient or his or her authorized agent, the reader is hereby notified
that any dissemination, distribution or copying of this e-mail is
prohibited. If you have received this e-mail in error, please notify the
sender by replying to this message and delete this e-mail immediately.

