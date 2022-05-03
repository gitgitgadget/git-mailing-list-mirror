Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728DDC433EF
	for <git@archiver.kernel.org>; Tue,  3 May 2022 10:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiECLCH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 07:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbiECLCD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 07:02:03 -0400
X-Greylist: delayed 557 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 May 2022 03:58:30 PDT
Received: from pv50p00im-hyfv10021501.me.com (pv50p00im-hyfv10021501.me.com [17.58.6.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AD4FCC
        for <git@vger.kernel.org>; Tue,  3 May 2022 03:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1651574953;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=PlWueLgvrAV/ZQ6GwqniYZTN64b3UfsxVC1iq+MfAmBQE3Fk1XhxbjPJAE4+ysOXL
         e9z2RQSHQZL0scwhldR2k62ooEwK0Q4FM3sgeGw3K5021IsC2yQmSRairJHfE7NpK7
         y+t5faEfW8A4KJ/kDeAdqxy4PR+tNkL+DwSZiA0LGuKFzjEnfepmO3ePN6bSyIbzwE
         GelU7w3sQAJFYoy+lo+z+GCk60CAU47Vb3hy9m3InqqtOTyXjIZLC1xcJq5nlHRcBp
         4LaO+CExH4y05JqFSFiORCftLW8FP2WMzcPT5uAax978Jnm8yWJQ6i0cS1YoEPj80K
         lNzeAVsfJI9Zg==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id E5E702C035F;
        Tue,  3 May 2022 10:49:11 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   =?utf-8?Q?Nam_H=E1=BB=93?= <honamluxurychef@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Tue, 3 May 2022 17:48:55 +0700
Subject: active
Message-Id: <9705803E-BED4-44A6-BBA5-774D83BD9713@icloud.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (19E258)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_03:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=675 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2205030082
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone
