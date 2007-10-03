From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: metastore
Date: Wed, 3 Oct 2007 01:52:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710030151270.28395@racer.site>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <20070916060859.GB24124@piper.oerlikon.madduck.net>
 <20070919191607.GE13683@hardeman.nu> <20071002195301.GB14171@lapse.madduck.net>
 <20071002195816.GA6759@hardeman.nu> <85lkalz3iv.fsf@lola.goethe.zz>
 <20071002211518.GA10445@hardeman.nu> <Pine.LNX.4.64.0710030018240.4087@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0710021743270.25489@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	David H?rdeman <david@hardeman.nu>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Wed Oct 03 02:53:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcsUc-0006s5-Hp
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 02:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003AbXJCAxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 20:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752934AbXJCAxa
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 20:53:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:44590 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752509AbXJCAxa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 20:53:30 -0400
Received: (qmail invoked by alias); 03 Oct 2007 00:53:28 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 03 Oct 2007 02:53:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19gyvJRhxVgSqKND7pOloBzao5zQwHumwa5zqcv6b
	0j+s0Eb3H7wa+j
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0710021743270.25489@asgard.lang.hm>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59764>

Hi,

On Tue, 2 Oct 2007, david@lang.hm wrote:

> in the discussion a few weeks ago I was told that there is a way to look 
> at the contents of a file that hasn't been checked out yet (somehow it 
> exists in a useable form 'in the index') but when I asked for 
> information about how to do this I never got a response.

git show :<filename>

(Note the ":")

Hth,
Dscho
