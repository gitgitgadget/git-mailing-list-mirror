Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84144C433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 18:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E587613CC
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 18:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhDWSfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 14:35:40 -0400
Received: from pv50p00im-ztdg10012001.me.com ([17.58.6.51]:55711 "EHLO
        pv50p00im-ztdg10012001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232238AbhDWSfj (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Apr 2021 14:35:39 -0400
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Apr 2021 14:35:39 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1619202382;
        bh=oAcNIXGOj4meKDpG3nzb6NwOEpZcxck8nvTH8eEzuPA=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=Oc5r9J3WuUq//hHxTHTk4VVs8A8agwR/W1wLQ6jIXcugdqM31SsLIonw3CyfOvnM8
         Bf2YZaeNjjZQQc4XnJKCBldTfWSK2L+b3YrF1ZS86ODJW0VHC2ckk2iVIXqMj/CfwW
         U7F9NYPnRRYoNPBMcHklOpnBwdkesKhq9ubviRJDtCLLEZSmkhOlrlOpRmCN2Ocnhl
         K02QmUm+Rd08lp+5snZKooWxLb9edLg8uLOKDSMbP9wzzoepy8rKYimY2hIpw9Pxxs
         060iyOoMI3Px09j+UM04dvnrfRbzwnNGS7nSZumrEWarc9Nu8l9DvLR/r1sP5zrNLG
         Ebv0ysrADNyHg==
Received: from [192.168.1.103] (unknown [182.241.243.220])
        by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 679FB280405;
        Fri, 23 Apr 2021 18:26:21 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?Nguy=E1=BB=85n_Y=E1=BA=BFn?= <nguyen_yen_fabg@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Sat, 24 Apr 2021 00:56:13 +0630
Subject: =?utf-8?B?IOacjeWKoeadoeasvuWSjOacrOmakOengeaUv+etlg==?=
Message-Id: <A9A00F50-B6A3-45EF-AAD7-68404DB801AD@icloud.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (18D70)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-23_07:2021-04-23,2021-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=378 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2104230121
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Nguy=E1=BB=85n Y=E1=BA=BFn=20=
