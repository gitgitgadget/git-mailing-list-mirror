From: Erik Colson <eco@ecocode.net>
Subject: Re: git-gui console app ?
Date: Fri, 10 Aug 2007 16:25:40 +0200
Message-ID: <20070810142540.GE363@Mac2.local>
References: <20070804101058.GA520@Mac2.local> <Pine.LNX.4.64.0708041225520.14781@racer.site> <20070804115331.GA2962@Mac2.local> <20070804120342.GC9716@coredump.intra.peff.net> <20070804123834.GA3036@Mac2.local> <20070805101953.GI12507@coredump.intra.peff.net> <20070810133132.GA3770@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 10 16:25:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJVR0-0006AW-98
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 16:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734AbXHJOZr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 10:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753459AbXHJOZr
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 10:25:47 -0400
Received: from 30.mail-out.ovh.net ([213.186.62.213]:42765 "HELO
	30.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753292AbXHJOZq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 10:25:46 -0400
Received: (qmail 26244 invoked by uid 503); 10 Aug 2007 14:26:08 -0000
Received: (QMFILT: 1.0); 10 Aug 2007 14:26:08 -0000
Received: from b7.ovh.net (HELO mail93.ha.ovh.net) (213.186.33.57)
  by 30.mail-out.ovh.net with SMTP; 10 Aug 2007 14:26:08 -0000
Received: from b0.ovh.net (HELO queue-out) (213.186.33.50)
	by b0.ovh.net with SMTP; 10 Aug 2007 14:25:51 -0000
Received: from 213.219.143.110.adsl.dyn.edpnet.net (HELO localhost) (erik.colson%beavernet.be@213.219.143.110)
  by ns0.ovh.net with SMTP; 10 Aug 2007 14:25:50 -0000
Mail-Followup-To: Erik Colson <eco@ecocode.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070810133132.GA3770@diku.dk>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Ovh-Remote: 213.219.143.110 (213.219.143.110.adsl.dyn.edpnet.net)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|H 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55543>

On Fri, Aug 10, 2007 at 03:31:32PM +0200, Jonas Fonseca wrote:
> Not quite a one-liner, but I've implemented something that will show
> diffs of staged/unstaged changes as well as the content of untracked
> files when pressing Enter on a file in the status view. To update the
> status of a file (unstaged->staged, untracked->staged, etc) you now
> have to press 'u'.
> 
> Hope this helps.

Works like a charm ! Thanks for the implementation.  Btw, I'm using
git (and tig) on MacosX and got it compiled by using the same remarks
you mention for FreeBSD, so may be you could add this to the INSTALL
document...

-- 
Erik
