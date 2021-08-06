Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44F1C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 03:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8624B611C9
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 03:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241420AbhHFDHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 23:07:17 -0400
Received: from smtp38.hk.chengmail.me ([113.10.190.104]:47056 "EHLO
        smtp38.hk.chengmail.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241518AbhHFDHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 23:07:16 -0400
X-CHENGMAILHOST: 113.10.190.104
X-CHENGMAIL-INSTANCEID: 3970.610ca742.683eb.0
Date:   Fri, 6 Aug 2021 11:06:43 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     git <git@vger.kernel.org>
Cc:     "Junio C Hamano" <gitster@pobox.com>
Subject: test failed for fetch shallow repo with ref-in-want enabled
X-Priority: 3
X-GUID: C112BB06-8EDB-4170-A622-D5A0F360203A
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
X-source-message-id: <2021080611013617796210@oschina.cn>
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <547b1164f66311eb96320026b95c99cc@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSBqdXN0IGdvdCB0aGlzIGtpbmQgb2YgZXJyb3I6CsKgIGZhdGFsOiBleHBlY3RlZCAncGFja2Zp
bGUnLCByZWNlaXZlZCAnc2hhbGxvdy1pbmZvJwoKd2hlbiByZW1vdGUgcmVwbyBpcyBhIHNoYWxs
b3cgcmVwbyhjcmVhdGVkIGJ5IHVzaW5nIC0tZGVwdGgpLCBhbmQgY29uZmlndXJlZCB3aXRoICdy
ZWYtaW4td2FudCcgZmVhdHVyZSwKdGhlbiAiZ2l0IGNsb25lIMKgLUMgcmVtb3RlX3JlcG8gwqBs
b2NhbCIgZmFpbGVkLiDCoCh0ZXN0ZWQgaW4gdC90NTcwMy11cGxvYWQtcGFjay1yZWYtaW4td2Fu
dC5zaCkKCkkgZG9uJ3Qga25vdyBpZiB0aGlzIHJlc3VsdCBpcyBleHBlY3RlZCzCoGFuZCBtYXli
ZSB0aGUgdGVzdCBzaG91bGQgY292ZXIgdGhpcyBjYXNlLg==

