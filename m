From: Ingo Molnar <mingo@elte.hu>
Subject: Re: qgit-0.6
Date: Sun, 19 Jun 2005 15:02:57 +0200
Message-ID: <20050619130257.GA18226@elte.hu>
References: <20050618103805.8461.qmail@web26302.mail.ukl.yahoo.com> <20050619130035.GA15355@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, berkus@gmail.com
X-From: git-owner@vger.kernel.org Sun Jun 19 14:58:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjzNY-0000jy-IQ
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 14:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVFSNDx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 09:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVFSNDx
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 09:03:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:8069 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261954AbVFSNDp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2005 09:03:45 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 075EE31E670;
	Sun, 19 Jun 2005 15:00:30 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id E707E1FC2; Sun, 19 Jun 2005 15:03:36 +0200 (CEST)
To: Marco Costalba <mcostalba@yahoo.it>
Content-Disposition: inline
In-Reply-To: <20050619130035.GA15355@elte.hu>
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

> works fine here and is nice and fast, but there are a few minor visual 
> glitches:

one more thing: for the annotated output it would be nicer to have 
fixed-width fonts to display code. For commit messages the current 
output is fine, but code is much more readable in fixed-width output.

	Ingo
