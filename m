From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: fact-import: failed to apply delta
Date: Tue, 10 Feb 2009 15:16:53 -0800
Message-ID: <20090210231653.GY30949@spearce.org>
References: <alpine.LNX.1.00.0902101427300.19665@iabervon.org> <20090210201203.GU30949@spearce.org> <alpine.LNX.1.00.0902101520240.19665@iabervon.org> <20090210212539.GV30949@spearce.org> <alpine.LNX.1.00.0902101628140.19665@iabervon.org> <20090210213612.GW30949@spearce.org> <7vprhqkjrr.fsf@gitster.siamese.dyndns.org> <7vfxillxiu.fsf@gitster.siamese.dyndns.org> <20090210230950.GX30949@spearce.org> <7vtz71khoi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 00:18:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX1rx-0002sW-Pa
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 00:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756404AbZBJXQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 18:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756566AbZBJXQz
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 18:16:55 -0500
Received: from george.spearce.org ([209.20.77.23]:56561 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756187AbZBJXQy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 18:16:54 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id CC14138210; Tue, 10 Feb 2009 23:16:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vtz71khoi.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109341>

Junio C Hamano <gitster@pobox.com> wrote:
> 
> The patch can and should go to maint, right?

Yea, maint.  Don't forget the ';' I forgot in sha1_file.c.

Clearly, I failed to compile-test it before sending.  :-)

-- 
Shawn.
