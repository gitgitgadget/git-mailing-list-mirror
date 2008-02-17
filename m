From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add support for host aliases in config files
Date: Sun, 17 Feb 2008 13:58:43 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802171357510.5816@iabervon.org>
References: <alpine.LNX.1.00.0802171337000.5816@iabervon.org> <m3zltza06r.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 19:59:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQojQ-0003Ho-6l
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 19:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbYBQS6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 13:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbYBQS6p
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 13:58:45 -0500
Received: from iabervon.org ([66.92.72.58]:47242 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190AbYBQS6o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 13:58:44 -0500
Received: (qmail 7930 invoked by uid 1000); 17 Feb 2008 18:58:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Feb 2008 18:58:43 -0000
In-Reply-To: <m3zltza06r.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74164>

On Sun, 17 Feb 2008, Jakub Narebski wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > +host.<name>.*::
> > +	These options provide a way to rewrite URLs when there is a
> > +	pattern of URLs with a common prefix which should be replaced
> > +	with a different prefix. For every 'alias' prefix given, any
> 
> You menat 'rewritebase' prefix here, isn't it?

Yes.

	-Daniel
*This .sig left intentionally blank*
