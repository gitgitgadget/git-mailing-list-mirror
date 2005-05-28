From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [gitweb bug] Pressing commitdiff on first commit returns 403
Date: Sat, 28 May 2005 02:02:11 +0200
Message-ID: <20050528000211.GA25299@vrfy.org>
References: <20050527233750.GB25491@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 02:00:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbokR-0008V9-Sr
	for gcvg-git@gmane.org; Sat, 28 May 2005 02:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbVE1ACR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 20:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbVE1ACR
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 20:02:17 -0400
Received: from soundwarez.org ([217.160.171.123]:30936 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262665AbVE1ACP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 20:02:15 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 8ABBE3A74F; Sat, 28 May 2005 02:02:11 +0200 (CEST)
To: Jonas Fonseca <fonseca@diku.dk>
Content-Disposition: inline
In-Reply-To: <20050527233750.GB25491@diku.dk>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, May 28, 2005 at 01:37:50AM +0200, Jonas Fonseca wrote:
> Just a minor issue. For example the URL below for the commitdiff of the
> first git commit gives me ``403 Forbidden - Reading diff-tree failed.''
> 
> http://kernel.org/git/?p=git/git.git;a=commitdiff;h=e83c5163316f89bfbde7d9ab23ca2e25604af290

That's already fixed in the next version.

thanks,
Kay
