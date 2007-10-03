From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: WIP: asciidoc replacement
Date: Wed, 3 Oct 2007 09:55:13 -0400
Message-ID: <20071003135513.GR21675@fieldses.org>
References: <Pine.LNX.4.64.0710030133020.28395@racer.site> <4702F6BB.60908@vilain.net> <Pine.LNX.4.64.0710030506360.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 03 15:55:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id4hE-0003kB-Mi
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 15:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754236AbXJCNzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 09:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753718AbXJCNzT
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 09:55:19 -0400
Received: from mail.fieldses.org ([66.93.2.214]:57416 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754150AbXJCNzS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 09:55:18 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1Id4gz-0001qj-N2; Wed, 03 Oct 2007 09:55:13 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710030506360.28395@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59839>

On Wed, Oct 03, 2007 at 05:23:35AM +0100, Johannes Schindelin wrote:
> On Wed, 3 Oct 2007, Sam Vilain wrote:
> > Johannes Schindelin wrote:
> > 
> > > I do not want to depend on more than necessary in msysGit, and 
> > > therefore I started to write an asciidoc replacement.
> > 
> > It's pretty good, I certainly wouldn't have trouble reading or 
> > maintaining it, but I'll give you suggestions anyway.
> 
> Thank you very much!  (On both accounts...)
> 
> > nice work, replacing a massive XML/XSL/etc stack with a small Perl 
> > script ;-)
> 
> Uhm... It is less capable, though...

By the way, without having looked at your script to see it does, a
couple things I know of that the user manual relies on that other docs
may not as much are automatic table of contents generation, and cross
references.

I'd be similarly inclined to work on improving asciidoc rather than
inventing something new, but I guess it's at least interesting to see
how far your approach gets us.

--b.
