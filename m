From: chris <jugg@hotmail.com>
Subject: Re: [PATCH 2/3] remote: separate the concept of push and fetch mirrors
Date: Thu, 31 Mar 2011 02:50:01 +0000 (UTC)
Message-ID: <loom.20110331T044824-341@post.gmane.org>
References: <20110330195139.GA814@sigill.intra.peff.net> <20110330195318.GB30624@sigill.intra.peff.net> <7vhbakmj5k.fsf@alter.siamese.dyndns.org> <20110330205734.GA2940@sigill.intra.peff.net> <7v62r0meok.fsf@alter.siamese.dyndns.org> <loom.20110331T040801-714@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 04:50:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q57xn-0007Nx-NS
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 04:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755710Ab1CaCuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 22:50:17 -0400
Received: from lo.gmane.org ([80.91.229.12]:37861 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754778Ab1CaCuP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 22:50:15 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Q57xf-0007Ky-3L
	for git@vger.kernel.org; Thu, 31 Mar 2011 04:50:15 +0200
Received: from 114-38-66-34.dynamic.hinet.net ([114.38.66.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 04:50:15 +0200
Received: from jugg by 114-38-66-34.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 04:50:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 114.38.66.34 (Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Ubuntu/10.04 Chromium/10.0.648.204 Chrome/10.0.648.204 Safari/534.16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170453>

chris <jugg <at> hotmail.com> writes:
> 
> I use the mirror for synchronizing "local" work between my workstations 
> (home/office).  So, I use the fact that I can fetch and pull from the mirror.

That of course should say:

So, I use the fact that I can fetch from and *push* to the mirror.

chris
