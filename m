Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_BASE64_TEXT,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDCF21F453
	for <e@80x24.org>; Thu, 25 Oct 2018 02:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeJYLKS (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 07:10:18 -0400
Received: from m12-16.163.com ([220.181.12.16]:44120 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbeJYLKS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 07:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Mime-Version:Message-ID; bh=BmkBR
        TIeD0x0xicFV6JdUXVvrkb/JouOhUAgPvzgeKc=; b=e46czqWEzuLKdEDiHbf8M
        EtRuu345Y95xsZbsbc9t9PRKvVf5a593BfpKm5mWF0I+eHMJq86ozX0G+L2IiIUQ
        ZAm4c3p3vxqVAf8A5KGzL/8Nee2/REjLWmz56CwwtVAi5x6uTSCQgWpc/4tQ72np
        +/L0axzCqNRfba9mqsVo+c=
Received: from USER-20170606YP (unknown [117.159.7.215])
        by smtp12 (Coremail) with SMTP id EMCowABHl0riLNFbXiC8Kg--.63040S2;
        Thu, 25 Oct 2018 10:39:31 +0800 (CST)
Date:   Thu, 25 Oct 2018 10:39:39 +0800
From:   "lhf635@163.com" <lhf635@163.com>
To:     git <git@vger.kernel.org>
Subject: the opposite of .gitignore, whitelist
X-Priority: 3
X-GUID: A679C16B-DC2F-444B-B030-528D8606E4C6
X-Has-Attach: no
X-Mailer: Foxmail 7.2.9.156[cn]
Mime-Version: 1.0
Message-ID: <201810251039388653199@163.com>
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: base64
X-CM-TRANSID: EMCowABHl0riLNFbXiC8Kg--.63040S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUoHq4UUUUU
X-Originating-IP: [117.159.7.215]
X-CM-SenderInfo: xokiljqv6rljoofrz/1tbiVw7qsletZbOnjAABsH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSBoYXZlIGEgZ29vZCBpZGVhLCBhZGQgYSBmaWxlIHRvIGdpdCB0aGF0IGlzIHRoZSBvcHBvc2l0
ZSBvZiAuZ2l0aWdub3JlLCB3aGl0ZWxpc3QsIHRoZSBjb2RlIGluIHRoZSBkZXZlbG9wbWVudCBk
aXJlY3RvcnkgY2FuIGJlIHN1Ym1pdHRlZCB0byBnaXQgdmVyc2lvbiBjb250cm9sLCB5b3UgY2Fu
IG9ubHkgc3VibWl0IHRoZSBzb3VyY2UgY29kZSBpbiB0aGUgc3JjIGRpcmVjdG9yeSwgd2l0aG91
dCBjb25jZXJuIGZvciBkZXZlbG9wbWVudCB0b29scyBhbmQgb3BlcmF0aW9ucy5TeXN0ZW0gYW5k
IG90aGVyIGZpbGVzLCBhZnRlciBhbGwsIHRoZSB0eXBlIG9mIGVhY2ggcHJvamVjdCBjb2RlIGlz
IGZpeGVkLCBJIGFtIGluIHRoZSBjb21tdW5pdHkgSSBkaWQgbm90IGZpbmQgYSB3YXkgdG8gc3Vi
bWl0IHJlcXVpcmVtZW50cyBpbiB0aGUgY29tbXVuaXR5LCBzbwotLS0tLS0tLS0tLS0tLQpsaGY2
MzVAMTYzLmNvbQ==


