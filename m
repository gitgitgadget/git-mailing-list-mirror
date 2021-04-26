Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02B1C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 08:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD8FC61139
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 08:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhDZImo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 04:42:44 -0400
Received: from m13122.mail.163.com ([220.181.13.122]:1396 "EHLO
        m13122.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhDZImn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 04:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=VtPvj
        ojUoF16jSoMLJmKPo0XzQGyFv04xjfywwoa8L4=; b=PLwKn/woqhsdUbNdftS2P
        P17rVP85WmrLzGtuF4psx8sSubSX4fyZ/eqLmUyt18Ra5HLBr8NCo0iUpzE1pHHJ
        bOdB3HEEKF4/ed1n6GOCeW0cnX+RUtto6UVcE2K36b81bhNNkANv0to3cXkJv9vS
        feh2zpQG/TGeIun7UwnOas=
Received: from zdl8255$163.com ( [124.42.103.98] ) by ajax-webmail-wmsvr122
 (Coremail) ; Mon, 26 Apr 2021 16:42:00 +0800 (CST)
X-Originating-IP: [124.42.103.98]
Date:   Mon, 26 Apr 2021 16:42:00 +0800 (CST)
From:   zdl8255 <zdl8255@163.com>
To:     git@vger.kernel.org
Subject: not found the clone or pull log
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <b5770c8.42d8.1790d57af75.Coremail.zdl8255@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: esGowACnRS3YfIZgy8muAA--.16329W
X-CM-SenderInfo: h2gomjivv6il2tof0z/1tbiMxeAyFXl8zsNfAACsn
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CgpIaSwKSSB3YW50IHRvIHJldHJpZXZlIHRoZSBjbG9uZSBvciBwdWxsIGxvZyBvZiBzb21lb25l
IHByb2plY3QsIGJ1dCBub3cgSSBjYW4gb25seSBmaW5kIHRoZSBzdWJtaXR0ZWQgbG9nCmNhbiB5
b3UgaGVscCBtZT8KCgrCoA==
