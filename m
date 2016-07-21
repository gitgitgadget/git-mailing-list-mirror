Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FE2E203C2
	for <e@80x24.org>; Thu, 21 Jul 2016 12:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbcGUM1U (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 08:27:20 -0400
Received: from lixid.tarent.de ([193.107.123.118]:48359 "EHLO mail.lixid.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964AbcGUM1T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jul 2016 08:27:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.lixid.net (MTA) with ESMTP id 64F1F14111A;
	Thu, 21 Jul 2016 14:27:16 +0200 (CEST)
Received: from mail.lixid.net ([127.0.0.1])
	by localhost (mail.lixid.net [127.0.0.1]) (MFA, port 10024) with LMTP
	id wDxnglzKj7w8; Thu, 21 Jul 2016 14:27:16 +0200 (CEST)
Received: from tglase.lan.tarent.de (tglase.lan.tarent.de [172.26.3.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.lixid.net (MTA) with ESMTPS id 27CAD141112;
	Thu, 21 Jul 2016 14:27:16 +0200 (CEST)
Received: by tglase.lan.tarent.de (Postfix, from userid 2339)
	id C188E2224D5; Thu, 21 Jul 2016 14:27:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by tglase.lan.tarent.de (Postfix) with ESMTP id AA4522224CF;
	Thu, 21 Jul 2016 14:27:15 +0200 (CEST)
Date:	Thu, 21 Jul 2016 14:27:15 +0200 (CEST)
From:	Thorsten Glaser <t.glaser@tarent.de>
X-X-Sender: tglase@tglase.lan.tarent.de
To:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:	git@vger.kernel.org
Subject: Re: Server-side preventing some files from being overwritten
In-Reply-To: <5790B055.4060603@gmail.com>
Message-ID: <alpine.DEB.2.20.1607211426450.12455@tglase.lan.tarent.de>
References: <alpine.DEB.2.20.1607141725390.25238@tglase.lan.tarent.de> <CAGZ79kb=2rpYucjhavNB_XHLk9rjKSoHzL9bwM5buDO0GyW3vw@mail.gmail.com> <5790B055.4060603@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
Content-Language: de-DE-1901
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, 21 Jul 2016, Jakub Narębski wrote:

> Or you can use third-party tools with support for such cases, such

Not if the repository is already managed by some other tool
(FusionForge, in this case).

Thanks anyway,
//mirabilos
-- 
tarent solutions GmbH
Rochusstraße 2-4, D-53123 Bonn • http://www.tarent.de/
Tel: +49 228 54881-393 • Fax: +49 228 54881-235
HRB 5168 (AG Bonn) • USt-ID (VAT): DE122264941
Geschäftsführer: Dr. Stefan Barth, Kai Ebenrett, Boris Esser, Alexander Steeg
