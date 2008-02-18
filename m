From: Bob Copeland <me@bobcopeland.com>
Subject: Re: segfault in http-push
Date: Sun, 17 Feb 2008 21:05:55 -0500
Message-ID: <20080218020555.GA12814@hash.localnet>
References: <20080217220013.GA12419@hash.localnet> <alpine.LSU.1.00.0802172321551.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 03:06:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQvP4-000837-4s
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 03:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbYBRCGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 21:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbYBRCGI
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 21:06:08 -0500
Received: from mail.deathmatch.net ([70.167.247.36]:56992 "EHLO
	mail.deathmatch.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662AbYBRCGH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 21:06:07 -0500
Received: from hash.localnet ([72.196.246.81])
	(authenticated user bob@bobcopeland.com)
	by mail.deathmatch.net (Kerio MailServer 6.3.0)
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Sun, 17 Feb 2008 21:06:08 -0500
Received: from bob by hash.localnet with local (Exim 4.63)
	(envelope-from <me@bobcopeland.com>)
	id 1JQvOF-0003NG-5m; Sun, 17 Feb 2008 21:05:55 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802172321551.30505@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74217>

On Sun, Feb 17, 2008 at 11:23:38PM +0000, Johannes Schindelin wrote:
> I can only suspect that you mean 1.5.4.2, not 1.4.5.2 (which I could not 
> find).

Just so...

> Alas, a fix I provided for exactly this case did not make it into master 
> yet, let alone into any released version.  Can you please test the current 
> "next"?

Yep, next fixes it for me, thanks!

-- 
Bob Copeland %% www.bobcopeland.com 
