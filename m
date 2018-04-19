Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SBL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7520C1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 03:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbeDSDaO (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 23:30:14 -0400
Received: from m12-13.163.com ([220.181.12.13]:49249 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751032AbeDSDaO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 23:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:Subject:Message-ID:From:MIME-Version; bh=MhKBZ
        EkIH6BAGrq7PI4cWUABaqbaxzg24trVPwiKSTA=; b=BeFcZV6TARDBJDQj691LT
        hlZ0h62pd1xqvBxmhzHSdc1i6/fu8jZ+ghPtym/X4ChELcwol2AwVvJCnUrLQcF4
        Ko3wQht4idqjkcYBi1UdisSZE24MAuPdMWzkegh07xqMKIWybo7g8lhV5KdBKP35
        7FjnCb59hlOUNlIzgj+6eA=
Received: from [10.236.220.101] (unknown [112.17.238.97])
        by smtp9 (Coremail) with SMTP id DcCowAA3EO1CDdhakwcMBg--.62951S2;
        Thu, 19 Apr 2018 11:30:12 +0800 (CST)
Date:   Thu, 19 Apr 2018 11:30:08 +0800
Subject: Git issue report
X-Priority: 1
Message-ID: <-tc3xop-8i635uwx53zom190jcbwyrl587bgic1u7ogu-h5ta7c-vg7tsu-9tjre9eq72we-wflfrt-v7y1d7-7ekgia-gbrcn9of96to-6fxlag-u56rt19q40x9-ved85k-25erwyma9au4-fjthm4-fwargr.1524108608363@email.android.com>
From:   "xfswindy@163.com" <xfswindy@163.com>
To:     git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CM-TRANSID: DcCowAA3EO1CDdhakwcMBg--.62951S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUr5l8UUUUU
X-Originating-IP: [112.17.238.97]
X-CM-SenderInfo: 50iv4xxqg1qiywtou0bp/1tbiNgQt4FWBZzWiNgAAst
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGksCiAgSSBtZXQgYSBpc3N1ZSB3aGVuIHVzaW5nIGdpdC4KSSBjYW5ub3QgZGVsZXRlIHRoZSBm
aWxlIGJ5IHRoZSBjb21tb25kICdnaXQgcm0nLgpUaGUgZmlsZSBuYW1lIGlzIGEgbGl0dGxlIGRp
ZmYgZnJvbSBjb21tb24gZmlsZS4KSSBhY2NpZGVudGFsbHkgbmFtZWQgdGhlIGZpbGUgImZpbGVu
YW1lXHIiLCBkaXNwbGF5IHN1Y2ggYXMgZmlsZW5hbWVeTS4gVGhlbiBJIGNvbW1pdCB0aGUgZmls
ZSBieSAnZ2l0IGFkZCAuJy4KQWZ0ZXIgSSBmaW5kIHRoaXMgbWlzdGFrZSwgSSByZW1vdmUgdGhl
IGZpbGUsIHRoZW4gdHJ5IHRvIHVzZSBjb21tb25kICJnaXQgcm0iIHRvIGRlbGV0ZSB0aGUgZmls
ZSwgYnV0IGZhaWxlZC4KCk15IGdpdCB2ZXJzaW9uIGlzIDEuNy45LjUuCklzIHRoaXMgaXNzdWUg
cmVwb3J0ZWQ/CklmIHRoaXMgaXNzdWUgaXMgc29sdmVkLCBjb3VsZCB5b3UgdGVsbCBtZSB3aGlj
aCB2ZXJzaW9uIEkgc2hvdWxkIGdldC4KClRoYW5rcyEKWGlhb2ZlbmcgQ2hlbgowNC8xOS8yMDE4
Cgo=


