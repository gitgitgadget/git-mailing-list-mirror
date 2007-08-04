From: Erik Colson <eco@ecocode.net>
Subject: Re: git-gui console app ?
Date: Sat, 4 Aug 2007 13:53:31 +0200
Message-ID: <20070804115331.GA2962@Mac2.local>
References: <20070804101058.GA520@Mac2.local> <Pine.LNX.4.64.0708041225520.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 04 13:53:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHICQ-0005yP-V4
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 13:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810AbXHDLxg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 07:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754491AbXHDLxg
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 07:53:36 -0400
Received: from 27.mail-out.ovh.net ([213.186.38.137]:55630 "HELO
	27.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753972AbXHDLxf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 07:53:35 -0400
Received: (qmail 16580 invoked by uid 503); 4 Aug 2007 11:55:46 -0000
Received: from unknown (HELO mail171.ha.ovh.net) (213.186.33.59)
  by 27.mail-out.ovh.net with SMTP; 4 Aug 2007 11:55:46 -0000
Received: from b0.ovh.net (HELO queue-out) (213.186.33.50)
	by b0.ovh.net with SMTP; 4 Aug 2007 11:53:24 -0000
Received: from 86-39-62-69.customer.fulladsl.be (HELO localhost) (erik.colson%beavernet.be@86.39.62.69)
  by ns0.ovh.net with SMTP; 4 Aug 2007 11:53:23 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708041225520.14781@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Ovh-Remote: 86.39.62.69 (86-39-62-69.customer.fulladsl.be)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|H 0.500001/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54830>

On Sat, Aug 04, 2007 at 12:29:03PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 4 Aug 2007, Erik Colson wrote:
> 
> > git-gui is a nice application and I like to use it while developping.
> > However as probably a lot of developpers do, I regularly code in Emacs
> > from a distant ssh client.
> > Therefor I'd want to find some app like git-gui running in console...
> > Does this exist or is there a project in development ?
> 
> There is tig.  http://repo.or.cz/w/tig.git
> 
> It is something similar to gitk but based on curses, so it is a viewer for 
> now.  But I do not see any fundamental reason why it should not be 
> possible to teach it many of the tricks git-gui does.
> 
> Just fork it (you can even do that on repo.or.cz; tig.git is mirrored 
> there), and give it a go!

Thanks for the very fast answer. I'm currently trying it out. However
I can't figure out how to view the 'changed but not updated' in diff
format...
Any clue what I'm missing ?

-- 
Erik
