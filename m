Return-Path: <SRS0=89BL=BL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4339C433DF
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 03:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B621D20838
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 03:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="swqN3paU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgHADgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 23:36:44 -0400
Received: from st43p00im-ztdg10061801.me.com ([17.58.63.170]:40539 "EHLO
        st43p00im-ztdg10061801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727978AbgHADgo (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 Jul 2020 23:36:44 -0400
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Jul 2020 23:36:43 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1596252668;
        bh=HM/kSjIvMa1mrdwkj1ZNZIQ7OJVvmvI0FyzCyo30Dq0=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=swqN3paUUnPrD/G0df+nQBvwYgMEkRbY41INtI7kXN3NEWwhf72KhjVQFrRPJ8U9h
         3ntMtXCGMjLqS7PeMgfs1a7lWfC/2MBjlc/0+LoEoCP2CsCJLr2tX6a4hFqvJSASrL
         Y95bJFTHUFO3CSNnVaj81Dy31lHtcHaM8saGXBizJ9mGJHlPV6qPJmzlGHMAonklq2
         AgwcHZ+V6USbrdSdimcnI+Uu16au55HoA4WlxCIBrL0RTFUJpkKuJcKCP+Ugzz9pc6
         TrbpmKofTSNzhaNR2wVDt9jTOZseZGQeeAHv9RPoCw1grJnc6PtU6b6PGpykT3mlMz
         H1aN8OxQxSVWw==
Received: from [10.141.112.248] (mobile-166-175-190-121.mycingular.net [166.175.190.121])
        by st43p00im-ztdg10061801.me.com (Postfix) with ESMTPSA id 729EE8C075E
        for <git@vger.kernel.org>; Sat,  1 Aug 2020 03:31:08 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Cj Anderson <andersonbrothersco@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Fri, 31 Jul 2020 22:31:06 -0500
Subject: Privacy invasion 
Message-Id: <54D2F2A0-BFC1-4A2B-A3FE-4A4BBCCEF1B5@icloud.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (17G68)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-01_01:2020-07-31,2020-08-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=274 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2004280000 definitions=main-2008010024
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I send this to git all the time no help

Sent from my iPhone
