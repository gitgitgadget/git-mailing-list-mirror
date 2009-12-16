From: Eric Paris <eparis@redhat.com>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Tue, 15 Dec 2009 22:31:29 -0500
Message-ID: <1260934289.2788.82.camel@localhost>
References: <1260822484.9379.53.camel@localhost>
	 <20091214211142.GC9364@coredump.intra.peff.net>
	 <1260825629.9379.56.camel@localhost>
	 <20091215023918.GA14689@coredump.intra.peff.net>
	 <alpine.LFD.2.00.0912142245240.23173@xanadu.home>
	 <1260851180.9379.88.camel@localhost>
	 <alpine.LFD.2.00.0912152201300.23173@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Dec 16 04:31:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKkbz-0001Np-LN
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 04:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760926AbZLPDbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 22:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760912AbZLPDbf
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 22:31:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32462 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755707AbZLPDbe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 22:31:34 -0500
Received: from int-mx04.intmail.prod.int.phx2.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.17])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nBG3VUih008823
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 15 Dec 2009 22:31:30 -0500
Received: from [10.11.8.210] (vpn-8-210.rdu.redhat.com [10.11.8.210])
	by int-mx04.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id nBG3VUhD022423;
	Tue, 15 Dec 2009 22:31:30 -0500
In-Reply-To: <alpine.LFD.2.00.0912152201300.23173@xanadu.home>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135319>

On Tue, 2009-12-15 at 22:03 -0500, Nicolas Pitre wrote:
> On Mon, 14 Dec 2009, Eric Paris wrote:
> 
> > The alternative repo is slowing pushing up to that same location.  That
> > tar is 855838982, so just a tad bit smaller.
> 
> It doesn't appear to be complete yet, and not progressing either.

I ran out of quota and ask for more, but IT departments moves at the
speed of IT departments.  I'll delete the first one and just push the
alternative repo.  Once I get more space I'll try to get them both up at
once....

-Eric
