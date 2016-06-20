Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27B871FEAA
	for <e@80x24.org>; Mon, 20 Jun 2016 20:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933696AbcFTUeq (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 16:34:46 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:41462 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932660AbcFTUej (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 16:34:39 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3rYMqZ6Xx6z3hjYH;
	Mon, 20 Jun 2016 22:27:54 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3rYMqZ6GylzvjNC;
	Mon, 20 Jun 2016 22:27:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 1DkNky2qa_zw; Mon, 20 Jun 2016 22:27:53 +0200 (CEST)
X-Auth-Info: Hp3sc9y49gM3iioAdyrku+9kISRREg4yx/wn1zmAgaVEInPeJivJabSq5jYSYnVt
Received: from igel.home (ppp-88-217-7-154.dynamic.mnet-online.de [88.217.7.154])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon, 20 Jun 2016 22:27:53 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 6481F2C346B; Mon, 20 Jun 2016 22:27:53 +0200 (CEST)
From:	Andreas Schwab <schwab@linux-m68k.org>
To:	Norbert Kiesel <nkiesel@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: unable to pull from remote if commit date is in the future
References: <CAM+g_NswH8fd8aFPEHfSLYnZWptNU2GX=xTWpehzjTJfJM_GfQ@mail.gmail.com>
X-Yow:	My haircut is totally traditional!
Date:	Mon, 20 Jun 2016 22:27:53 +0200
In-Reply-To: <CAM+g_NswH8fd8aFPEHfSLYnZWptNU2GX=xTWpehzjTJfJM_GfQ@mail.gmail.com>
	(Norbert Kiesel's message of "Mon, 20 Jun 2016 11:41:40 -0700")
Message-ID: <87porbip12.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.95 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Norbert Kiesel <nkiesel@gmail.com> writes:

> For the record: the faulty commit is
> https://github.com/seandepagnier/weather_routing_pi/commit/23c07cc5d2be7ce68349f4b3719b6fa6fe90e0bf

That commit is part of master.  Are you sure you don't have it already?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
