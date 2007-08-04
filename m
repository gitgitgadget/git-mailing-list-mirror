From: Erik Colson <eco@ecocode.net>
Subject: Re: git-gui console app ?
Date: Sat, 4 Aug 2007 14:38:34 +0200
Message-ID: <20070804123834.GA3036@Mac2.local>
References: <20070804101058.GA520@Mac2.local> <Pine.LNX.4.64.0708041225520.14781@racer.site> <20070804115331.GA2962@Mac2.local> <20070804120342.GC9716@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 04 14:38:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHIu2-0000Zf-6H
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 14:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756421AbXHDMij (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 08:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756104AbXHDMij
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 08:38:39 -0400
Received: from 27.mail-out.ovh.net ([213.186.38.137]:46260 "HELO
	27.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754749AbXHDMij (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 08:38:39 -0400
Received: (qmail 31668 invoked by uid 503); 4 Aug 2007 12:40:49 -0000
Received: from unknown (HELO mail171.ha.ovh.net) (213.186.33.59)
  by 27.mail-out.ovh.net with SMTP; 4 Aug 2007 12:40:49 -0000
Received: from b0.ovh.net (HELO queue-out) (213.186.33.50)
	by b0.ovh.net with SMTP; 4 Aug 2007 12:38:27 -0000
Received: from 86-39-62-69.customer.fulladsl.be (HELO localhost) (erik.colson%beavernet.be@86.39.62.69)
  by ns0.ovh.net with SMTP; 4 Aug 2007 12:38:26 -0000
Mail-Followup-To: Erik Colson <eco@ecocode.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070804120342.GC9716@coredump.intra.peff.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Ovh-Remote: 86.39.62.69 (86-39-62-69.customer.fulladsl.be)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|H 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54839>

On Sat, Aug 04, 2007 at 08:03:42AM -0400, Jeff King wrote:
> On Sat, Aug 04, 2007 at 01:53:31PM +0200, Erik Colson wrote:
> 
> > Thanks for the very fast answer. I'm currently trying it out. However
> > I can't figure out how to view the 'changed but not updated' in diff
> > format...
> 
> git-diff ?
> 
> By default, it will show the changes between your working tree and the
> index (i.e., changed but not updated). You can show the diff of "updated
> but not commited" with "git-diff --cached".

Peff,

yep that is the info I would like to browse in a way git-gui does it...
showing a list of the files in the diff, and letting the user select a
file to show the part of the diff for that file.

-- 
Erik
