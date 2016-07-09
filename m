Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A338520705
	for <e@80x24.org>; Sat,  9 Jul 2016 07:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbcGIHaX (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 03:30:23 -0400
Received: from perdizione.investici.org ([94.23.50.208]:25971 "EHLO
	perdizione.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbcGIHaW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 03:30:22 -0400
Received: from [94.23.50.208] (perdizione [94.23.50.208]) (Authenticated sender: najamelan@autistici.org) by localhost (Postfix) with ESMTPSA id BEB701200F0;
	Sat,  9 Jul 2016 07:30:17 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=autistici.org;
	s=stigmate; t=1468049418;
	bh=ln0cwQLdza1tDOyfZXah7T+ws48k4mrUglexltKL7GU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To;
	b=bLE0NGxcD4JktO3LqzMlJPyzvJ6/xCgrFPKWa0Wgv9XhYFLQMKZ6onfMJSnHvsbg4
	 xJ2DIklxFYIHFm0/VOmuMdTJbjQQgZfk3XRf+w/Iu4yp6V2e1NCeMAG0zJd/8flJuI
	 gZPJ+WpwLmaB+gm+qlxYh6NffbO3UUb1JyJPnITs=
From:	Naja Melan <najamelan@autistici.org>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff: fix a double off-by-one with
 --ignore-space-at-eol
References: <cover.1468048754.git.johannes.schindelin@gmx.de>
 <daf43539479acdebe1c5799c38f3be75c2399feb.1468048754.git.johannes.schindelin@gmx.de>
Message-ID: <a72910ab-a396-00c6-6661-46c17e78fd4e@autistici.org>
Date:	Sat, 09 Jul 2016 07:28:00 +0000
MIME-Version: 1.0
In-Reply-To: <daf43539479acdebe1c5799c38f3be75c2399feb.1468048754.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Thanks,

you sure are efficient in bug fixing...

good day to you
Naja Melan
