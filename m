Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3996C282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 00:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42636206F0
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 00:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.mil header.i=@mail.mil header.b="dwmgZdqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgAIAGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 19:06:14 -0500
Received: from UCOL19PA39.eemsg.mail.mil ([214.24.24.199]:44134 "EHLO
        UCOL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgAIAGO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 19:06:14 -0500
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jan 2020 19:06:14 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=mail.mil; i=@mail.mil; q=dns/txt; s=EEMSG2018v1a;
  t=1578528374; x=1610064374;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=t/40THHo4tpz7JfMd1/xacp/EudWax97DtcCjE/QWEc=;
  b=dwmgZdqkRjTgULe+Eh/3a9HsZ9luy6vPnMovtG+nDkTAfWwhRcZ0Fjth
   tE4d+08K+RGnuMsrz57jwUAq2mUbs5iZnpDnoEhfWmhmtCuuAkng+QyVg
   /zgRn9lb9m9/H2tBf/2Nn9q9gj2RwgHEbOexNjQ+BLquDMDiS3fBTqx8D
   M6DnwqYsGvAqCa8fzxpVsYGavtDUBAi6NistTKIXK51hqvNpmc+qf82Tu
   0UKOJ2Q19m1bPRb47N4fGwMIpaJSOLk23nFVh1fcPpqqw0fYafEXaajdV
   8CANy+bgnfkOg2LjButpTlNrlAExUlu2wlGEvGlKdN9cN5SWZ2zz34rZI
   w==;
X-EEMSG-check-017: 69995512|UCOL19PA39_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,411,1571702400"; 
   d="scan'208";a="69995512"
Received: from edge-mont01.mail.mil ([158.15.164.100])
  by UCOL19PA39.eemsg.mail.mil with ESMTP; 08 Jan 2020 23:59:00 +0000
Received: from UGUNHU2M.easf.csd.disa.mil (158.15.164.38) by
 edge-mont01.mail.mil (158.15.164.100) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Wed, 8 Jan 2020 23:58:59 +0000
Received: from UGUNHU4M.easf.csd.disa.mil ([169.254.7.202]) by
 ugunhu2m.easf.csd.disa.mil ([158.15.164.38]) with mapi id 14.03.0468.000;
 Wed, 8 Jan 2020 23:58:58 +0000
From:   "Jones, Amy E CTR USARMY ATEC (USA)" <amy.e.jones49.ctr@mail.mil>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Cyber Security questions (UNCLASSIFIED)
Thread-Topic: Cyber Security questions (UNCLASSIFIED)
Thread-Index: AdXGf5W+++qFX1wYRy2DIazup2770w==
Date:   Wed, 8 Jan 2020 23:58:57 +0000
Message-ID: <3DDB5EB393DC7E4A810C3651CC0B08101780A52F@ugunhu4m.easf.csd.disa.mil>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [158.15.204.13]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CLASSIFICATION: UNCLASSIFIED

We've had a request at this company to acquire GIT software, but all new so=
ftware has to be approved by our cyber security team. I have a list of ques=
tions that need to be answered before we can start the approval process, an=
d some of those questions are very technical, is there someone who could fi=
ll out the question form?

Amy Jones
Team SURVICE
435-831-7168
amy.e.jones49.ctr@mail.mil



CLASSIFICATION: UNCLASSIFIED
