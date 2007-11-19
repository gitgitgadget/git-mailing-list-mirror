From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Documentation: Fix references to deprecated commands
Date: Mon, 19 Nov 2007 08:44:27 +0100
Message-ID: <20071119074426.GA8700@diku.dk>
References: <Pine.LNX.4.64.0711080041120.4362@racer.site> <20071108145435.GA18727@diku.dk> <4733249B.9020504@op5.se> <20071108160114.GB20988@diku.dk> <7vzlxo1mga.fsf@gitster.siamese.dyndns.org> <20071109002001.GB5082@diku.dk> <7vy7d8xlej.fsf_-_@gitster.siamese.dyndns.org> <20071112002410.GA21970@diku.dk> <20071112003251.GB21970@diku.dk> <20071119015411.GA4978@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Nov 19 08:44:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu1JH-0004K8-LB
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 08:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbXKSHob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 02:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbXKSHob
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 02:44:31 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:43834 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbXKSHoa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 02:44:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id AAA8F77000E;
	Mon, 19 Nov 2007 08:44:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IJMIXoXqiCfR; Mon, 19 Nov 2007 08:44:27 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 2B745770009;
	Mon, 19 Nov 2007 08:44:27 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id A85876DFFCA; Mon, 19 Nov 2007 08:43:50 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 0EEDB5B8001; Mon, 19 Nov 2007 08:44:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071119015411.GA4978@fieldses.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65409>

J. Bruce Fields <bfields@fieldses.org> wrote Sun, Nov 18, 2007:
> On Mon, Nov 12, 2007 at 01:32:51AM +0100, Jonas Fonseca wrote:
> > Subject: [PATCH] Documentation: Fix references to deprecated commands
> > 
> > ... by changing git-tar-tree reference to git-archive and removing
> > seemingly unrelevant footnote about git-ssh-{fetch,upload}.
> 
> Makes sense to me, but for some reason git-am complains about a corrupt
> patch when I feed it this email.  I reconstructed it by hand, fixed up
> one more reference to git-tar-tree, and applied to my tree.

It should have been merged in a4e57e75c95c66c32da6b106313bc847110794ba.
And yes, as Junio also pointed out, I deleted some context lines at the
end of the patch.

-- 
Jonas Fonseca
