Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	TRACKER_ID autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACBDC4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 10:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE7B322207
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 10:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Gv+tdnKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgI0K6H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 06:58:07 -0400
Received: from pv50p00im-ztdg10012001.me.com ([17.58.6.51]:35348 "EHLO
        pv50p00im-ztdg10012001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726185AbgI0K6H (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Sep 2020 06:58:07 -0400
X-Greylist: delayed 562 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Sep 2020 06:58:07 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1601203724;
        bh=K2wAdUGfJ3PzeS9Q/+XdvHFxE4s1RIisrPYYshm2fz0=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=Gv+tdnKO33V6wYj/c+GpYUqFP5utZbQjcUC0b5u4ePTEhc8mT7RFbhUQ/LMmtU9Ch
         J/aM1krdgckzxtnaLjyrsxW7z9v99lhCgf6H2+U7cGhQa/drxcIuORpwXsF0r7baLY
         URpwt++VhIl+8ssbItWpAszqiSQis8JBZC1j00mp2G5/QotjG8Y4rYZt+u9YxTTi0n
         0ALxBCgM5nOrTxO2A7DTeYg14NqM97HTJGGxmopVDJzzlbpy0jMj7OaD4EI1PwUxfV
         OZc8pqz0xud0WmU5Z/S4pqBe2A4ol8Ib1aesod7SzolQTS0+rkuFQ3l1MsZYLUl2We
         xl4edCK+tINnQ==
Received: from [192.168.0.104] (unknown [117.5.146.184])
        by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 73F3328020E
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 10:48:44 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?B?6qeB4Ly6SOKDn0/ig5/DoE7ig59H4oOf4pmaIEPig59P4oOf?=
         =?utf-8?B?TuKDn+C8u+qngg==?= <hoangcon.com@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Sun, 27 Sep 2020 17:48:40 +0700
Subject: NL69S0O3196S79JTOJ7PDBJN50
Message-Id: <24C0DE2A-DDA4-4D8C-9BE5-6D81CE8D3BBC@icloud.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (16G201)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-27_07:2020-09-24,2020-09-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=11 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=11 clxscore=1011 mlxscore=11
 mlxlogscore=90 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2009270101
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



=C4=90=C6=B0=E1=BB=A3c g=E1=BB=ADi t=E1=BB=AB iPhone c=E1=BB=A7a t=C3=B4i=
