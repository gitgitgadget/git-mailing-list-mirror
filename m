From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Core and Not-So Core
Date: Tue, 10 May 2005 18:03:29 +0100
Message-ID: <1115744609.16187.455.camel@hades.cambridge.redhat.com>
References: <2cfc40320505100800426d38ca@mail.gmail.com>
	 <1115739511.16187.432.camel@hades.cambridge.redhat.com>
	 <2cfc4032050510092238259b63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 10 18:57:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVY2B-0006cF-BH
	for gcvg-git@gmane.org; Tue, 10 May 2005 18:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVEJRDw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 13:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVEJRDw
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 13:03:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:64921 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261708AbVEJRDi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 13:03:38 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DVY8q-0000My-6v; Tue, 10 May 2005 18:03:35 +0100
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc4032050510092238259b63@mail.gmail.com>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-05-11 at 02:22 +1000, Jon Seymour wrote:
> So, no, it's not a religious issue. If anything, it is being dogmatic
> to insist that the sacred GIT repository structure only be manipulated
> by 'C' tools blessed by the hands of Linus.

Given the volatility of the structure -- at least the details if not the
fundamentals -- it seems bizarre to want to reimplement it rather than
just using the existing tools.

This is the same mentality which gives Eclipse a half-arsed SSH
reimplementation which doesn't behave like normal SSH is configured to
behave either, right?

-- 
dwmw2

