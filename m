From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [ANNOUNCE] qgit 1.1.1
Date: Sun, 19 Mar 2006 22:49:07 +0100
Message-ID: <20060319214907.GA7294@elte.hu>
References: <e5bfff550603190853m2db7bb38gecc94934c4dfb89e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, proski@gnu.org
X-From: git-owner@vger.kernel.org Sun Mar 19 22:51:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FL5o1-0004e4-Je
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 22:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWCSVvT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 16:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWCSVvT
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 16:51:19 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:63898 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750923AbWCSVvS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Mar 2006 16:51:18 -0500
Received: from chiara.elte.hu ([157.181.151.252])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1FL5nv-0008Fw-L3
	from <mingo@elte.hu>; Sun, 19 Mar 2006 22:51:17 +0100
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 25DA21FC2; Sun, 19 Mar 2006 22:51:14 +0100 (CET)
To: Marco Costalba <mcostalba@gmail.com>
Content-Disposition: inline
In-Reply-To: <e5bfff550603190853m2db7bb38gecc94934c4dfb89e@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Received-SPF: softfail (mx2.mail.elte.hu: transitioning domain of elte.hu does not designate 157.181.151.252 as permitted sender) client-ip=157.181.151.252; envelope-from=mingo@elte.hu; helo=chiara.elte.hu;
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4999]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17729>


* Marco Costalba <mcostalba@gmail.com> wrote:

> This is a maintenance release, mainly performance tweaks and small bug 
> fixes.

looks good here. One small bug: when in 'patch view' mode (e.g. after 
having double-clicked on a commit), clicking on a merge commit produces 
an "Error - Qgit" window.

	Ingo
