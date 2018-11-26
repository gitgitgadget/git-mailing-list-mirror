Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 288641F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 15:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbeK0CIq (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 21:08:46 -0500
Received: from smtp45.i.mail.ru ([94.100.177.105]:34612 "EHLO smtp45.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbeK0CIq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 21:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=4mIrViR5npsRD6F/B1VPcjwERUR2r2bOQI8NKxm0QEM=;
        b=U+t9UO0key+8yQ8wXxSZEhv1FuBjdTz3qN1jGfLxEKeqGdsHs5W/mWoDbXy9uYTp0b9LM5EoP4OX5Qemk1so9rcNlC0BPBMxZYAiH2oWMCUU/9AFtJYb4cPBq2W2ACZ6qp+guH8pKa41ncBCz8OsrT11V2dRxQBPqfhyfXjvGqE=;
Received: by smtp45.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1gRIaY-0008M0-Sn; Mon, 26 Nov 2018 18:14:20 +0300
Date:   Mon, 26 Nov 2018 18:14:16 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Chandra Shekhar <ace.cs99@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git bash lunching error
Message-ID: <20181126151416.fcriudear4gvlvji@tigra>
References: <CALBWQ8cE_Y5GCPtsd7PRoTPixKgHRy1BSgfVQKg=n9_TGa5Ohg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALBWQ8cE_Y5GCPtsd7PRoTPixKgHRy1BSgfVQKg=n9_TGa5Ohg@mail.gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Authentication-Results: smtp45.i.mail.ru; auth=pass smtp.auth=kostix@bswap.ru smtp.mailfrom=kostix@bswap.ru
X-77F55803: 260C666A7D66B36A5A78504BD2AC2941ECAAFFEC324CE74D2F554EBCC324B5FF6792E9759AF0CA0772A5C993EA1D8F9A
X-7FA49CB5: 0D63561A33F958A573D519A77AAAC470B0E35BDA5D56C8661DCFDA3E963A50288941B15DA834481FA18204E546F3947C2FFDA4F57982C5F4F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BF1175FABE1C0F9B6A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249A5DF9383870C0FED3AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE767C209D01CC1E34BCD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE750B7096A87611EFE5F39BCD0028C09E275ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57D4B828FA1BC0F1ACBD9CCCA9EDD067B1EDA766A37F9254B7
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA4C2C713753761E9D2C31444E26122096B0C0F1FA48E969E66FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 26, 2018 at 08:32:27PM +0530, Chandra Shekhar wrote:

> cess: Resource temporarily unavailable (-1).
> DLL rebasing may be required; see 'rebaseall / rebase --help'.

This <https://github.com/git-for-windows/git/issues/1015> ?

Please do not post screenshots, post text.
Also please copy and paste correctly when you do this.

