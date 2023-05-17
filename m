Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF02CC77B7D
	for <git@archiver.kernel.org>; Wed, 17 May 2023 16:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjEQQdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 12:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjEQQdc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 12:33:32 -0400
X-Greylist: delayed 378 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 May 2023 09:33:31 PDT
Received: from pv50p00im-ztdg10021201.me.com (pv50p00im-ztdg10021201.me.com [17.58.6.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4AA2102
        for <git@vger.kernel.org>; Wed, 17 May 2023 09:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1684340832;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=xZa8Wo40tbIPHLZA9D3J3pWcFJKBqXu4I3e3TeLDfq5OSwmqeSgt05yvodc2ecUIJ
         xvuQD1qCYL4Ikx7oto+B1qW3AXUw5PrKXwx+WCLYeBbtr61e5SNhlxH1P4YtGPdw0V
         isHn5frNhkhKC1T5EDZPDhF0PSXAR/ayUDVae64v/4LxA57hbXr7wxMd08oIQwpRbA
         +7hvLaxigP168cpj9Grs8tb7jN1L59fJll6uya4PuDhfaT36TZLhXmX6Ebqo+GJFkp
         o6UgRVdZLKXu3VNVMREAp3tY59/Sd6WBBUMs4aqcMJfnI1R6RWftwpDMGqvzFxU228
         xRWOvnAPB+fIw==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPSA id 807FB680516
        for <git@vger.kernel.org>; Wed, 17 May 2023 16:27:11 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Thon Chanvannak <chanvannak7@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Wed, 17 May 2023 23:27:07 +0700
Subject: The new 
Message-Id: <04724FED-A629-47AB-AA00-192580B2E164@icloud.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (20F65)
X-Proofpoint-ORIG-GUID: cP3rq4EPgkTaeytlp5_Rv5megMR-CisV
X-Proofpoint-GUID: cP3rq4EPgkTaeytlp5_Rv5megMR-CisV
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 clxscore=1011 mlxlogscore=386
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2305170133
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone
