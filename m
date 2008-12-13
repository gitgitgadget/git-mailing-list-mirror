Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,TVD_SPACE_RATIO,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 23506 invoked by uid 111); 13 Dec 2008 22:47:47 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 13 Dec 2008 17:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbYLMWrf (ORCPT <rfc822;peff@peff.net>);
	Sat, 13 Dec 2008 17:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbYLMWrf
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 17:47:35 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:16996 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbYLMWre (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 17:47:34 -0500
Received: by nf-out-0910.google.com with SMTP id d3so326824nfc.21
        for <git@vger.kernel.org>; Sat, 13 Dec 2008 14:47:32 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Qhmc3PsaDBFa5E+BE/Y+QJ/dUKlvDF/ZZSRdfpEFzdfcEbJkAhftGl3dowaq5yuv8N
         GO4guimmo/XJOCYk+d6tUrwcouB65dRvkjwcooFuKBrOvdyADvu9s8zC4NNc2fhLkRau
         9Df1XBFI7lkv5LiLZFlhIZzPIoEnH3xQwrF+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=Pk3vuzgKdoXcKjzqmU3PADgJ3zCPwyPkWRG8sMILK9sLKC39jNsMvUeKlnxSRjmb0M
         D/aaOTdEBz/ZP4igtj9MKFyVo8iza2jhpUkuxRlys33RFT1Kyh3w9BVNNSlk7LIGTHeU
         /msdB5uypS2CqFI8nNVurcb6xboS4gfLG3Ra4=
Received: by 10.210.51.18 with SMTP id y18mr5937832eby.103.1229208452799;
        Sat, 13 Dec 2008 14:47:32 -0800 (PST)
Received: from ?10.0.0.3? (bl7-9-231.dsl.telepac.pt [85.240.9.231])
        by mx.google.com with ESMTPS id g12sm1323914nfb.46.2008.12.13.14.47.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Dec 2008 14:47:31 -0800 (PST)
Message-Id: <8836F27A-CEE2-4D72-B2D1-7A3D19975D4F@alcidesfonseca.com>
From:	Alcides Fonseca <me@alcidesfonseca.com>
To:	git@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: TortoiseGit
Date:	Sat, 13 Dec 2008 22:47:28 +0000
X-Mailer: Apple Mail (2.929.2)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

