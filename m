Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D464C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 03:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C142B6100B
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 03:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhDTDtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 23:49:31 -0400
Received: from smtp516.hk.chengmail.me ([113.10.190.199]:34386 "EHLO
        smtp516.hk.chengmail.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhDTDtb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 23:49:31 -0400
X-CHENGMAILHOST: 113.10.190.199
X-CHENGMAIL-INSTANCEID: 508c.607e4f26.c6ad1.0
Date:   Tue, 20 Apr 2021 11:48:56 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     git <git@vger.kernel.org>
Subject: [Question] git cat-file --batch cannot handle irregular path
X-Priority: 3
X-GUID: 9F78FC7B-F1AB-48C8-9F33-FD938BA2E679
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
X-source-message-id: <2021042011475635783520@oschina.cn>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Message-ID: <54526f48a18b11ebad130024e87935e7@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGksIGFsbAoKV2hlbiBJIHVzZSAiZ2l0IGNhdC1maWxlIC0tYmF0Y2giIGNvbW1hbmQsIHdpdGgg
dGhlIGZvcm0KPHRyZWUtaXNoPjpwYXRoLCBoZXJlIHBhdGggaXMgdGhlIHdvcmtpbmcgdHJlZSBp
biBteSByZXBvc2l0b3J5LApidXQgaXQgaXMgaXJyZWd1bGFyLCBzdWNoIGFzICLms5XlvotcKExh
d1wpL+awkeazlVwoY2l2aWxcIGxhdyQnXG4nXClcIiwKdGhpcyBraW5kIG9mIHBhdGggaXMgdW5p
bnRlbnRpb25hbGx5IGNyZWF0ZWQuIMKgClRoZSBwcm9jZXNzIGNhbm5vdCBjb3JyZWN0bHkgaGFu
ZGxlIHRoaXMga2luZCBvZiBjYXNlOgoKJMKgZ2l0IGNhdC1maWxlIC0tYmF0Y2gKZDA3MWVhOTcx
ZmI5M2ViYzkzNzUxNzczNmMyYTYzZDY0ZGRiZTBkOTrms5XlvosoTGF3KS/msJHms5UoY2l2aWwg
bGF3KQpkMDcxZWE5NzFmYjkzZWJjOTM3NTE3NzM2YzJhNjNkNjRkZGJlMGQ5OuazleW+iyhMYXcp
L+awkeazlShjaXZpbCBsYXcpIG1pc3NpbmcKCkhvdyBjYW4gSSBkZWFsIHdpdGggdGhpcyBjYXNl
wqB3aGVuIGlycmVndWxhciBwYXRocyBjYW5ub3QgYmUgYXZvaWRlZD8KClRoYW5rcyBpbiBhZHZh
bmNlLg==

