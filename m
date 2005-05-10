From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Core and Not-So Core
Date: Tue, 10 May 2005 16:38:31 +0100
Message-ID: <1115739511.16187.432.camel@hades.cambridge.redhat.com>
References: <2cfc40320505100800426d38ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 10 17:34:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVWj8-0000rj-Kv
	for gcvg-git@gmane.org; Tue, 10 May 2005 17:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVEJPjN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 11:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVEJPjM
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 11:39:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:64663 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261689AbVEJPig (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 11:38:36 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DVWoa-0008MH-RM; Tue, 10 May 2005 16:38:33 +0100
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc40320505100800426d38ca@mail.gmail.com>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-05-11 at 01:00 +1000, Jon Seymour wrote:
> I have been experimenting with pure-Java implementation of GIT
> concepts with a goal of eventually providing plugins to Eclipse to
> allow the Eclipse GUI to interact with GIT repositories.

It's not April 1st. Why would you want to reimplement it in Java instead
of just using the existing implementation? Is this a religious issue?

-- 
dwmw2

