From: Bart Trojanowski <bart@jukie.net>
Subject: Re: To page or not to page
Date: Fri, 2 May 2008 09:47:25 -0400
Message-ID: <20080502134725.GJ32313@jukie.net>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org> <20080502054508.GA28506@sigill.intra.peff.net> <7vlk2txn8n.fsf@gitster.siamese.dyndns.org> <8C3474E2-3A4F-44E8-B301-C36939C7BA11@sb.org> <7vhcdhxmpr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 15:53:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrvhO-0002hY-8M
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 15:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764927AbYEBNwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 09:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764910AbYEBNwb
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 09:52:31 -0400
Received: from tau.jukie.net ([216.239.93.128]:52691 "EHLO tau.jukie.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762003AbYEBNwa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 09:52:30 -0400
Received: by tau.jukie.net (Postfix, from userid 1000)
	id 929D0C00CA2; Fri,  2 May 2008 09:47:25 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vhcdhxmpr.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80998>

* Junio C Hamano <gitster@pobox.com> [080502 02:03]:
> Kevin Ballard <kevin@sb.org> writes:
> 
> > Is there any good reason to make git-status use the pager? The output
> > is very rarely long enough to warrant it, and if I need a pager I can
> > always just pipe it to less myself.
> 
> I have no motivation to defend that change.  I'll leave that to the
> original submitter and list archive ;-)

My goal was to improve consistency with git log and git diff.  

-Bart

-- 
				WebSig: http://www.jukie.net/~bart/sig/
