From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 11:43:09 +0100
Message-ID: <1115894589.16187.570.camel@hades.cambridge.redhat.com>
References: <1115847510.22180.108.camel@tglx>
	 <2780.10.10.10.24.1115848852.squirrel@linux1>
	 <1115849141.22180.123.camel@tglx>
	 <2807.10.10.10.24.1115850254.squirrel@linux1>
	 <1115850619.22180.133.camel@tglx>
	 <2853.10.10.10.24.1115850996.squirrel@linux1>
	 <1115851718.22180.153.camel@tglx>
	 <2883.10.10.10.24.1115852463.squirrel@linux1>
	 <1115854419.22180.196.camel@tglx>
	 <2997.10.10.10.24.1115855049.squirrel@linux1>
	 <1115857838.22180.250.camel@tglx>
	 <3185.10.10.10.24.1115858739.squirrel@linux1>
	 <1115859372.22180.266.camel@tglx>
	 <3259.10.10.10.24.1115859535.squirrel@linux1>
	 <1115892451.16187.561.camel@hades.cambridge.redhat.com>
	 <3203.10.10.10.24.1115893120.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 12:35:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWB2X-0005Yk-49
	for gcvg-git@gmane.org; Thu, 12 May 2005 12:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVELKnP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 06:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVELKnP
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 06:43:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61637 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261420AbVELKnM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 06:43:12 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DWB9q-0003vP-Kh; Thu, 12 May 2005 11:43:11 +0100
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <3203.10.10.10.24.1115893120.squirrel@linux1>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-05-12 at 06:18 -0400, Sean wrote:
> Does BK use a repo ID ?  If not, can you not apply the same process to
> git?   Seems the fast forward heads might complicate things
> slightly....

BK doesn't fast-forward in quite the same way as git does. But we're not
really supposed to be paying too much attention to how BK works.

Your claim is that you can do this with existing git tools. I await that
demonstration.

-- 
dwmw2

