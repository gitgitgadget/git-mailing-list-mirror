From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 2/5] diff-highlight: don't highlight whole lines
Date: Tue, 14 Feb 2012 07:35:15 +0100
Message-ID: <20120214073515.3f2b6f59@mkiedrowicz.ivo.pl>
References: <20120213222702.GA19393@sigill.intra.peff.net>
	<20120213223247.GB19521@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 14 07:35:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxBzS-0001ns-4I
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 07:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593Ab2BNGfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 01:35:20 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:32870 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab2BNGfT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 01:35:19 -0500
Received: by eaah12 with SMTP id h12so2050100eaa.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 22:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=7PuRHWkNq2J+NpF9qrHP+ErMT/mVvsnB/Bsr7y0Zaas=;
        b=lht2irnYYamZPyvKqQhveJW6WvtfSle7yu6zixCVs+OcpxgN/p3Iw7zBENvkFltAxa
         8ZeyVbn0jDgGTrCQVbRIwoEN3xoP4ugNnK//jSsFBVPRo5CMaJa8dBPOlabCtVvhZCTq
         kWShZA6WW42YJQXojxnclnhgrwW5NP1XLcJPk=
Received: by 10.213.32.210 with SMTP id e18mr194454ebd.133.1329201318368;
        Mon, 13 Feb 2012 22:35:18 -0800 (PST)
Received: from mkiedrowicz.ivo.pl (pc10.ivo.park.gdynia.pl. [153.19.128.10])
        by mx.google.com with ESMTPS id c16sm69850330eei.1.2012.02.13.22.35.17
        (version=SSLv3 cipher=OTHER);
        Mon, 13 Feb 2012 22:35:18 -0800 (PST)
In-Reply-To: <20120213223247.GB19521@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190703>

Jeff King <peff@peff.net> wrote:

> Regarding attribution: I kept myself as author, because I rewrote it a
> bit and figured that I would take primary responsibility for bugs in
> this patch, and in the long run would be responsible for maintaining
> it. But the idea and the substance of the patch are yours, and I
> would be happy to list you as author if you prefer getting the credit
> that way (after all, it bumps your shortlog numbers :) ).

I'm completely OK with that. I don't care much about shortlog :). It's
nice enough to see that you liked my idea :) 
