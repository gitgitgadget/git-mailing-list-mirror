From: Ingo Molnar <mingo@elte.hu>
Subject: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 15:35:13 +0200
Message-ID: <20050416133513.GA21678@elte.hu>
References: <20050416131528.GB19908@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Apr 16 15:33:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMnPV-0005N8-J2
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 15:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262664AbVDPNgM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 09:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVDPNgM
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 09:36:12 -0400
Received: from mx2.elte.hu ([157.181.151.9]:45500 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262664AbVDPNgJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 09:36:09 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 438D03197CC
	for <git@vger.kernel.org>; Sat, 16 Apr 2005 15:34:24 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id E5D401FC2; Sat, 16 Apr 2005 15:35:16 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050416131528.GB19908@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> the patches contain all the existing metadata, dates, log messages and 
> revision history. (What i think is missing is the BK tree merge 
> information, but i'm not sure we want/need to convert them to GIT.)

author names are abbreviated, e.g. 'viro' instead of 
viro@parcelfarce.linux.theplanet.co.uk, and no committer information is 
included (albeit commiter ought to be Linus in most cases). These are 
limitations of the BK->CVS gateway i think.

	Ingo
