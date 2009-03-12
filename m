From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Google Summer of Code 2009: GIT
Date: Thu, 12 Mar 2009 14:07:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903121407070.6335@intel-tinevez-2-302>
References: <49B74373.3090609@gmail.com>  <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>  <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>  <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>  <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>
  <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302> <ab9fa62a0903110713k2a21cefbj1e7cd3c126aca8f9@mail.gmail.com> <alpine.LNX.1.00.0903111159530.19665@iabervon.org> <alpine.DEB.1.00.0903111742360.10498@intel-tinevez-2-302>
 <49B90683.1060501@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	saurabh gupta <saurabhgupta1403@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 14:09:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhkfG-0006LM-32
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 14:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126AbZCLNHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 09:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754158AbZCLNHx
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 09:07:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:43150 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753790AbZCLNHw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 09:07:52 -0400
Received: (qmail invoked by alias); 12 Mar 2009 13:07:49 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp068) with SMTP; 12 Mar 2009 14:07:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+frA5DCMufoNZdV4/rY0/qYrJL0YPXe2tGbyX1lM
	tgcIvN8SHtePuP
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49B90683.1060501@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113065>

Hi,

On Thu, 12 Mar 2009, Michael J Gruber wrote:

> Johannes Schindelin venit, vidit, dixit 11.03.2009 17:44:
> 
> > On Wed, 11 Mar 2009, Daniel Barkalow wrote:
> > 
> >> One thing that I think would be good whenever possible is to have the 
> >> merge program generate a file in the same format which is easily 
> >> recognizable as having conflict markers. For example, I think it 
> >> should be possible to show conflicts in the text of office documents 
> >> by having styles for each side of the merge, and show each side's 
> >> content in the appropriate style. Then the user opens the document 
> >> with their choice of office software, finds the things in the 
> >> conflict styles, and decides what the result should be.
> > That's a very good idea!  (Except for LaTeX, maybe...)
> 
> latexdiff (in perl) may give you a head start (or ache, I dunno).

No.  latexdiff is about diffing.  It does nothing to help me resolve a 
conflict.

Thanks,
Dscho
