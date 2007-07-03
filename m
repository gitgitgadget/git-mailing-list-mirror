From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Problems with git-svnimport
Date: Wed, 4 Jul 2007 00:19:55 +0200
Message-ID: <20070703221955.GG4580@xp.machine.xx>
References: <Pine.LNX.4.64.0706071639190.12111@www.mintpixels.com> <Pine.LNX.4.64.0706072329020.4046@racer.site> <loom.20070703T214211-88@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 00:19:48 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5qip-0004No-0o
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 00:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757023AbXGCWTo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 18:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756890AbXGCWTo
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 18:19:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:37393 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756761AbXGCWTn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 18:19:43 -0400
Received: (qmail invoked by alias); 03 Jul 2007 22:19:42 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp012) with SMTP; 04 Jul 2007 00:19:42 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18cvdtI9Y8c0Q824dK1CCyZJgWN0ZHTp8sxxxYTuY
	r6shHfBA3mo+BV
Mail-Followup-To: Matthias Urlichs <smurf@smurf.noris.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <loom.20070703T214211-88@post.gmane.org>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51545>

On Tue, Jul 03, 2007 at 07:45:12PM +0000, Matthias Urlichs wrote:
> Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:
> 
> > Let's deprecate git-svnimport, once for all.
> > 
> > git-svn should work much better.
> > 
> In other words, you volunteer to fold everything that git-svnimport can do into
> git-svn? The last time I checked, neither was a feature-complete subset of the
> other...
> 
> If so: don't let me hold you back. ;-)
> 

May I ask what is missing in git-svn to replace git-svnimport? As I
can't think of anything which is missing in git-svn.

-Peter
