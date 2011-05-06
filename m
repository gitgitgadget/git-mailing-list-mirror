From: chris <jugg@hotmail.com>
Subject: Re: error with $ git push origin HEAD:newbranch
Date: Fri, 6 May 2011 06:35:51 +0000 (UTC)
Message-ID: <loom.20110506T081810-948@post.gmane.org>
References: <loom.20110505T103708-225@post.gmane.org> <20110505093752.GB29595@sigill.intra.peff.net> <loom.20110505T114511-660@post.gmane.org> <20110505105914.GA464@sigill.intra.peff.net> <loom.20110506T034552-210@post.gmane.org> <7v39ks4ebd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 08:36:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIEe3-0007J5-2m
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 08:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745Ab1EFGgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 02:36:05 -0400
Received: from lo.gmane.org ([80.91.229.12]:56949 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338Ab1EFGgE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 02:36:04 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QIEdu-0007EX-Lx
	for git@vger.kernel.org; Fri, 06 May 2011 08:36:02 +0200
Received: from 114-38-69-159.dynamic.hinet.net ([114.38.69.159])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 May 2011 08:36:02 +0200
Received: from jugg by 114-38-69-159.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 May 2011 08:36:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 114.38.69.159 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.24 (KHTML, like Gecko) Ubuntu/10.04 Chromium/11.0.696.57 Chrome/11.0.696.57 Safari/534.24)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172946>

Junio C Hamano <gitster <at> pobox.com> writes:
> 
> chris <jugg <at> hotmail.com> writes:
> 
> > All of that to say, it isn't exactly clear what one should expect.
> 
> The take-home lesson is that if you want to be explicit and exactly clear,
> you can and should spell things out in full, and you can sleep well at
> night if you did so.

Yes, in order to be clear, one should be explicit.  But that was never in 
question here.  The discussion revolved around the non-explicit refspec usage 
with git-push.

And certainly there seems to have been attempts in the past to provide sensible 
short-hand usage for the command, but it would appear the accumulation lacks 
consistency.  If the expectation is that one should always be explicit, then I 
assume the short-hand will begin to become deprecated?  If not, then discussing 
it and improving it where possible seems rather acceptable.

chris
