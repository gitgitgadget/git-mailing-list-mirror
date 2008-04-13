From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Add examples section to 'git fetch' manual
Date: Sun, 13 Apr 2008 23:05:00 +0300
Message-ID: <20080413200500.GA5464@mithlond.arda.local>
References: <20080413093102.GC12107@mithlond.arda.local> <20080413093424.GA12861@mithlond.arda.local> <7v63uld1nu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 13 22:06:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jl8Sb-0003fp-SU
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 22:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbYDMUFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 16:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbYDMUFM
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 16:05:12 -0400
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:61505 "EHLO
	pne-smtpout3-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752298AbYDMUFL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Apr 2008 16:05:11 -0400
Received: from mithlond.arda.local (80.220.180.181) by pne-smtpout3-sn1.fre.skanova.net (7.3.129)
        id 47A78857003E90CF; Sun, 13 Apr 2008 22:05:02 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1Jl8Rg-0001Xt-Bk; Sun, 13 Apr 2008 23:05:00 +0300
Content-Disposition: inline
In-Reply-To: <7v63uld1nu.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79420>

Junio C Hamano wrote (2008-04-13 11:56 -0700):

> People look at examples section to look up something they need to do
> often; the section should describe the best practices we can suggest
> them in real life.

Thanks for your explanations, they made a lot of sense. I see, I gave
examples of various ways of using "git fetch" but they may not reflect
real life usage patterns very well. I still feel that refspecs need more
explaining (for newbies, that is) so I may later bring another patch
hopefully with better examples and applicable to real workflows.
