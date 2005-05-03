From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: gitweb on kernel.org lies?
Date: Tue, 03 May 2005 12:43:19 +0100
Message-ID: <1115120599.27227.297.camel@hades.cambridge.redhat.com>
References: <1115109604.8508.34.camel@localhost.localdomain>
	 <1115117537.21105.53.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 13:37:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSviD-0007Jk-NK
	for gcvg-git@gmane.org; Tue, 03 May 2005 13:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVECLn1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 07:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVECLn0
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 07:43:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46466 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261481AbVECLnX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 07:43:23 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DSvo8-0004i1-Kl; Tue, 03 May 2005 12:43:23 +0100
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <1115117537.21105.53.camel@localhost.localdomain>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 2005-05-03 at 12:52 +0200, Kay Sievers wrote:
> 
> The HEAD:
>   ftp://kernel.org/pub/scm/linux/kernel/git/dwmw2/audit-2.6.git/HEAD
> 
> points to:
>   42d4dc3f4e1ec1396371aac89d0dccfdd977191b
>   authorBenjamin Herrenschmidt <benh@kernel.crashing.org>
>   Fri, 29 Apr 2005 14:40:12 +0000 (07:40 -0700)
> 
> which is 3 days old, right?

Er, yeah... the active one is actually 'audit-2.6' not 'audit-2.6.git'.
Mea culpa -- I'd forgotten the latter was there, but it's the only one
that gitweb shows. 

-- 
dwmw2

