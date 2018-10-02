Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 382701F453
	for <e@80x24.org>; Tue,  2 Oct 2018 07:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbeJBNqr (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 09:46:47 -0400
Received: from mail.body-piercing.com ([61.19.42.229]:50037 "EHLO
        mail.body-piercing.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeJBNqq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 09:46:46 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Oct 2018 09:46:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=body-piercing.com; s=dkim;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Reply-To:To:From:Subject:Date:Message-ID; bh=r1l7xbNNgykL144pRa3jG7UBaNG2cQwdZEDU0A3g5Uw=;
        b=D2tGiqnrduhzUKuSjC0jBfwTNUZW7yYCuPZm69a4Cpe6Uz7tvOBUxEMsSFd4akktEp2BY5vSBelHhtrstfMKXg6PQpw8oHjtu/Qj6bgluXSidXkB/UHvkcuTkK5AJJGW2VDasfWcNLg8t4YXTd5m+/uO+cAwzJ2226cmSIf07Ac=;
Received: from mail1.body-piercing.com ([192.168.80.205]:16033 helo=mail.body-piercing.com)
        by mail.body-piercing.com with esmtps (TLSv1.2:AES256-SHA256:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <pd_web0@body-piercing.com>)
        id 1g7Eev-0007ZJ-0j
        for git@vger.kernel.org; Tue, 02 Oct 2018 13:59:53 +0700
Received: from [192.168.80.240] (192.168.80.240) by MAIL1.body-piercing.com
 (192.168.80.205) with Microsoft SMTP Server id 15.1.669.32; Tue, 2 Oct 2018
 13:59:52 +0700
Received: from 192.168.80.184
        (SquirrelMail authenticated user pd_web0@body-piercing.com)
        by 192.168.80.240 with HTTP;
        Tue, 2 Oct 2018 13:59:51 +0700
Message-ID: <e7f885a203122612b8dd343212c4e0a9.squirrel@192.168.80.240>
Date:   Tue, 2 Oct 2018 13:59:51 +0700
Subject: cannot dowload from your amazon server a windows git distro
From:   WEB0 - Helmut <pd_web0@body-piercing.com>
To:     <git@vger.kernel.org>
Reply-To: <pd_web0@body-piercing.com>
User-Agent: SquirrelMail/1.5.2 [SVN]
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

aGksDQp5b3UgYW1hem9uIGRvd25sb2FkIGlzIG5vdCB3b3JraW5nLg0KZG8geW91IGhhdmUgc29t
ZSBmcmVlIGxvY2F0aW9uIHRvIGRvd25sb2FkIHBsZWFzZT8NCg0KDQoNCmh0dHBzOi8vZ2l0aHVi
LXByb2R1Y3Rpb24tcmVsZWFzZS1hc3NldC0yZTY1YmUuczMuYW1hem9uYXdzLmNvbS8yMzIxNjI3
Mi81MDgzNDM4MC1iNmQxLTExZTgtOTE0Zi1mMDhhMWNiMzhmMmI/WC1BbXotQWxnb3JpdGhtPUFX
UzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBSVdOSllBWDRDU1ZFSDUzQSUyRjIw
MTgxMDAyJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDE4MTAw
MlQwNjU1MjBaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT04OWYyYmFkNGNmMjEz
NmZlNzRlYTY4ZTZmZTZlZGVlY2UxOTUyNWNlZDYwNmNhYWJiYmEzM2I3ZGU1NDdhNmE5JlgtQW16
LVNpZ25lZEhlYWRlcnM9aG9zdCZhY3Rvcl9pZD0wJnJlc3BvbnNlLWNvbnRlbnQtZGlzcG9zaXRp
b249YXR0YWNobWVudCUzQiUyMGZpbGVuYW1lJTNER2l0LTIuMTkuMC02NC1iaXQuZXhlJnJlc3Bv
bnNlLWNvbnRlbnQtdHlwZT1hcHBsaWNhdGlvbiUyRm9jdGV0LXN0cmVhbQ0KDQoNCg0KVGhpcyBt
ZXNzYWdlIGhhcyBiZWVuIHNjYW5uZWQgYnkgU09QSE9TIFB1cmVNZXNzYWdlLiBJVCBEZXB0Lg==
