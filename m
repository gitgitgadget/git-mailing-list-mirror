Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,BODY_URI_ONLY,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A1B51F403
	for <e@80x24.org>; Sun, 10 Jun 2018 00:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753538AbeFJAJq (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 20:09:46 -0400
Received: from m13-86.163.com ([220.181.13.86]:36893 "EHLO m13-86.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753525AbeFJAJq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 20:09:46 -0400
X-Greylist: delayed 910 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Jun 2018 20:09:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=uO+oe
        rncPpWi5iHPsoLwHQZy3yHof9oAnLk1f2OIMxY=; b=Gz7VLY+kHPlGRNDEJ5d51
        T60de3ywjWXEFmptG95dKfa6/v8+9xF2HZ0rQf2x0Bfa3pmI6YG9qpyFrLtZ2ars
        ecAvZ8E4AvfIMwcol27ieWrDTBc71612MoZ12LH1+t7UbrP6y7ixgAStZVyyp+28
        iknJscp2nvSlLwMKue+Crw=
Received: from 18335124969$163.com ( [61.171.231.65] ) by
 ajax-webmail-wmsvr86 (Coremail) ; Sun, 10 Jun 2018 07:54:30 +0800 (CST)
X-Originating-IP: [61.171.231.65]
Date:   Sun, 10 Jun 2018 07:54:30 +0800 (CST)
From:   Qingyun <18335124969@163.com>
To:     git@vger.kernel.org
Cc:     Qingyun <845767657@qq.com>
Subject: test
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20160729(86883.8884) Copyright (c) 2002-2018 www.mailtech.cn 163com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6179ab9d.6c0.163e6f90934.Coremail.18335124969@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: VsGowAB3ST22aBxb68UUAA--.61951W
X-CM-SenderInfo: zpryjjqvrskmiwz6il2tof0z/1tbiWRZgK1WBc9uRFQAAs8
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

U29ycnkgdG/CoGludHJ1ZGUsIGJ1dCBJIGNhbid0IHNlbmQgYSBwYXRjaCB0byB0aGUgbWFpbGxp
c3TCoHVzaW5nIHFxLmNvbSBTTVRQIHNlcnZlci4=
