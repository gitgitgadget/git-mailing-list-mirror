From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: push problem for new repo on repo.or.cz
Date: Mon, 9 Mar 2009 17:59:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903091758390.6358@intel-tinevez-2-302>
References: <49B53DAF.9080004@drmicha.warpmail.net> <20090309165139.GV8940@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Mar 09 18:01:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgiqw-0001hb-6j
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 18:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbZCIQ7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 12:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752251AbZCIQ7x
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 12:59:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:41154 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751382AbZCIQ7w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 12:59:52 -0400
Received: (qmail invoked by alias); 09 Mar 2009 16:59:49 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp064) with SMTP; 09 Mar 2009 17:59:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+6CKYeaN66CFswh7XEiWwy6A6sJYt3IxgDj0HO9A
	5161ec7UkYBAsN
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090309165139.GV8940@machine.or.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112719>

Hi,

On Mon, 9 Mar 2009, Petr Baudis wrote:

> On Mon, Mar 09, 2009 at 05:02:55PM +0100, Michael J Gruber wrote:
> > I have problems pushing into a new project on repo.or.cz. My user 
> > (mjg) is added in the admin interface, the key is correct because I've 
> > been using it for a while already for other projects (forks though). 
> > I'm using a qualified refspec. What else could be wrong on my side, 
> > assuming it's not the scripts on repo.or.cz? My git is 1.6.2.
>
> your user has actually not been added in the admin interface, please try 
> again.

Indeed.  I should have checked before giving a smart-ass answer ;-)

Note: when adding a user, you have to enter the admin password...  Failing 
that, you will see exactly the same form, but a red warning saying that 
the user has not been added.

Ciao,
Dscho
