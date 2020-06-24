Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526C0C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E5EF206F7
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pdinc.us header.i=@pdinc.us header.b="DWmr9fhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404680AbgFXP66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:58:58 -0400
Received: from mail2.pdinc.us ([67.90.184.28]:56654 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404558AbgFXP65 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 11:58:57 -0400
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 05OFwrnY007391
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 24 Jun 2020 11:58:54 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 05OFwrnY007391
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1593014334; bh=p7jz9qhNnv/9iC531qTblOiDcAnoaecSeuNqhK/+NwU=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=DWmr9fhmru+OJoKYW39VNVl536t4q7q4YkRoPTu/5G310wXMDLjAainIUhd9yzU9n
         uAaoXe8NRUhZqOWgCEbkZdcxIRkiXF4Sbi2+TbkcW8xdWumd3NuNmC2/WGtuHwXKS8
         wVo/s+WRrC2ZUZttq2YvZycFIun+emsV0JXzPE1cB2KwNzSQr9aBNO3bCu1ALUbatu
         IllSyj4XH/TrWAHtLLyHoUaxsiw+i1WlLng5Eo0TaUx3gOLwFKEPjSPazd2nTHUzZq
         f3/l0HIWLA3sGO+QHDiaU5WhXVLsAv1TQCnOQfSrm+bz6zGdZJSwPAMTxxFzeZMkL5
         Jt2cu1qYF+Wvg==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     "'Jesse Earles'" <jesse.earles@aero.org>
Cc:     <git@vger.kernel.org>
References: <BY5PR09MB4504218AEF2DFD593843A41EFF950@BY5PR09MB4504.namprd09.prod.outlook.com>
In-Reply-To: <BY5PR09MB4504218AEF2DFD593843A41EFF950@BY5PR09MB4504.namprd09.prod.outlook.com>
Subject: RE: Are there MPU/SKU's for these products?
Date:   Wed, 24 Jun 2020 11:59:04 -0400
Organization: PD Inc
Message-ID: <25d501d64a40$62991410$27cb3c30$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
thread-index: AQHSB2ADz8zCfa4zmKyiaoVbsYQIDqjwcb8A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The unique identifier for that version is: e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7

commit e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7 (tag: v2.12.0)
Author: Junio C Hamano <gitster@pobox.com>
Date:   Fri Feb 24 10:49:58 2017 -0800

    Git 2.12

    Signed-off-by: Junio C Hamano <gitster@pobox.com>


> -----Original Message-----
> From: git-owner@vger.kernel.org <git-owner@vger.kernel.org> On Behalf Of Jesse Earles
> Sent: Wednesday, June 24, 2020 11:43 AM
> To: git@vger.kernel.org
> Subject: Are there MPU/SKU's for these products?
> 
> Hello,
> 
> I am working with my software team on updating their internal catalog with current and accurate info
> and am needing to find the MPN/SKU for "Software Freedom Conservancy | Git | v2.12.0". I'm not certain
> if there even is one as I assume this is open-sourced, but I figured I'd reach out to get confirmation
> before I make an internal SKU for our records. Thanks.
> 
> 
> Jesse Earles
> Desktop Support Specialist
> EIS/IT Operations
> Digital Intelligence Systems, LLC (DISYS)
> The Aerospace Corporation
> 14745 Lee Rd. Chantilly, VA 20151
> 
> 
> 


