Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E9231FEAA
	for <e@80x24.org>; Thu, 23 Jun 2016 11:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbcFWLyj (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 07:54:39 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:50440 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbcFWLyj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 07:54:39 -0400
Received: from mfilter49-d.gandi.net (mfilter49-d.gandi.net [217.70.178.180])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id 4D3F341C07F
	for <git@vger.kernel.org>; Thu, 23 Jun 2016 13:54:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter49-d.gandi.net
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
	by mfilter49-d.gandi.net (mfilter49-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id jBFCgZE58H6i for <git@vger.kernel.org>;
	Thu, 23 Jun 2016 13:54:34 +0200 (CEST)
X-Originating-IP: 90.127.150.110
Received: from Lumpy.local.mail (LFbn-1-3387-110.w90-127.abo.wanadoo.fr [90.127.150.110])
	(Authenticated sender: scourtois@cubyx.fr)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id F03FF41C0AC
	for <git@vger.kernel.org>; Thu, 23 Jun 2016 13:54:34 +0200 (CEST)
Date:	Thu, 23 Jun 2016 13:54:34 +0200
From:	Simon Courtois <scourtois@cubyx.fr>
To:	git@vger.kernel.org
Message-ID: <etPan.576bcdfa.7aee6fa4.9bf5@cubyx.fr>
Subject: Italics formatting
X-Mailer: Airmail Beta (369)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

I was looking for a way to use italics in my git log. I ended-up looking at the code dealing with colors and style and noticed that the italic code was skipped when defining the list (color.c:128 if I'm not mistaken).

I'd love to propose a contribution but I'm sadly not very well versed with C.

So I'm asking you if this could be something that's part of Git someday. I don't know the extent of dim/ul/blink support across the terms but since some of them support italics the style would have its rightful place amongst the others.

And I'd also like to take the occasion to thank everybody working on Git, I've been using it for 7 years now and it's a real pleasure! Thank you all.

Regards,

Simon Courtois

