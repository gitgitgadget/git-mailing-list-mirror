Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MISSING_SUBJECT,PI_EMPTY_SUBJ,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1628C208B8
	for <e@80x24.org>; Sun, 13 Aug 2017 01:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbdHMByC (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 21:54:02 -0400
Received: from mr25p46im-ztdg02101301.me.com ([17.111.255.91]:20097 "EHLO
        mr25p46im-ztdg02101301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752156AbdHMByC (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Aug 2017 21:54:02 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Aug 2017 21:54:02 EDT
Received: from process-dkim-sign-daemon.mr25p46im-ztdg02101301.me.com by
 mr25p46im-ztdg02101301.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0OUL00E00MA5IX00@mr25p46im-ztdg02101301.me.com> for
 git@vger.kernel.org; Sun, 13 Aug 2017 00:54:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;     s=04042017;
 t=1502585641;  bh=nIZRZFAC45gClLvM64xTMMNgeHo2SseMupR74dQBqPU=;
        h=Content-type:From:MIME-version:Date:Message-id:To;
        b=R+GBJAiZY/Wu+BjJ50Set+OizUxbzR+A0OIRCZpCEiiG9SUdpsoLEapTPcS9kaV7H
 tPR6yLD+9+S6Aixt9myP30/GYfxvSPDIbjoXHuseAGTHJyJrJ3AOL0kCVxxiXYVxdx
 Cs0qtn8xBqYI8Z3Gx3cG2Sg8KHES1i8oKR10YuSMxqoIVVm7sl0oRMIbxgzs49M8ly
 1M8/V9jnxvAQBOm8nQEzem1MoVkZgOxZ22gHAmDhN9K0k4Rb3fIqOBsN5E7ZymaObN
 fyegu9uZETNfNBgAXmaYwOSaaXcMGq1fVKyoeLHcQ3hwAcChglYmTAxEYlIk1MuuxR
 aS6EKwJAPmNaQ==
Received: from icloud.com ([127.0.0.1]) by mr25p46im-ztdg02101301.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) with ESMTPSA id <0OUL00F7BMHW6900@mr25p46im-ztdg02101301.me.com> for
 git@vger.kernel.org; Sun, 13 Aug 2017 00:54:01 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2017-08-12_13:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1034 suspectscore=1 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1701120000 definitions=main-1708130014
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
From:   Stephanie Gomes <stephaniegomes1689@icloud.com>
MIME-version: 1.0 (1.0)
Date:   Sat, 12 Aug 2017 16:41:27 -0400
Message-id: <5E7A720C-09D1-4D5E-AD7A-505D562B9D7D@icloud.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (14F89)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

How I work this?

Sent from my iPhone
