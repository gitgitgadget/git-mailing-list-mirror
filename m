From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Core and Not-So Core
Date: Wed, 11 May 2005 08:17:17 +0100
Message-ID: <20050511071717.GB23090@infradead.org>
References: <2cfc40320505100800426d38ca@mail.gmail.com> <1115739511.16187.432.camel@hades.cambridge.redhat.com> <17115.200.158.14.67.1115740220.squirrel@www.tendencies.com.br> <1115740844.16187.445.camel@hades.cambridge.redhat.com> <26021.200.158.14.67.1115741989.squirrel@www.tendencies.com.br> <20050510234501.79eea7a4.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: eduardo@tendencies.com.br, dwmw2@infradead.org,
	jon@blackcubes.dyndns.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 09:11:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVlN0-00032r-JW
	for gcvg-git@gmane.org; Wed, 11 May 2005 09:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVEKHRx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 03:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVEKHRx
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 03:17:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61096 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261910AbVEKHR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 03:17:28 -0400
Received: from hch by pentafluge.infradead.org with local (Exim 4.43 #1 (Red Hat Linux))
	id 1DVlT3-00064K-Cv; Wed, 11 May 2005 08:17:17 +0100
To: Diego Calleja <diegocg@gmail.com>
Content-Disposition: inline
In-Reply-To: <20050510234501.79eea7a4.diegocg@gmail.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, May 10, 2005 at 11:45:01PM +0200, Diego Calleja wrote:
> ...and I don't think people who use eclipse wants to have the fastest tool
> on earth, so "java-invoking-C is slower than pure java" is not a great excuse
> either...

Note that it's also not true.  At least if you use the gcj-specific CNI
mechanisms instead of Sun's braindead JNI.

