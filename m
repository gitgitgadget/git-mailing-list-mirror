From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: quiet some warnings when run only with --version/--help
Date: Tue, 17 Apr 2007 03:28:18 -0700
Message-ID: <20070417102818.GA20984@hand.yhbt.net>
References: <20070417094143.GB2778@muzzle> <7vvefvpc3b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 12:28:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdkv8-0007Id-5B
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 12:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbXDQK2T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 06:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753362AbXDQK2T
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 06:28:19 -0400
Received: from hand.yhbt.net ([66.150.188.102]:54821 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753354AbXDQK2T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 06:28:19 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id B758E7DC09F; Tue, 17 Apr 2007 03:28:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vvefvpc3b.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44757>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > These are harmless but annoying.  They were introduced in
> > 512b620bd9fef7f170562ecad835e37479f051ce
> >
> > Signed-off-by: Eric Wong <normalperson@yhbt.net>
> > ---
> >
> >  Junio: did you miss
> >  http://permalink.gmane.org/gmane.comp.version-control.git/44493 ?
> 
> Indeed.  Are these two 'maint' material?

Yes.  Definitely so.

-- 
Eric Wong
