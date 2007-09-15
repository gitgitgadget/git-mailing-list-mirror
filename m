From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: metastore (was: Track /etc directory using Git)
Date: Sat, 15 Sep 2007 18:43:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709151842350.28586@racer.site>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.63.0709151819200.19941@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: Grzegorz Kulewski <kangur@polcom.net>
X-From: git-owner@vger.kernel.org Sat Sep 15 19:44:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWbhH-0003XT-5n
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 19:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137AbXIORom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 13:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753135AbXIORom
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 13:44:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:36039 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753116AbXIORol (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 13:44:41 -0400
Received: (qmail invoked by alias); 15 Sep 2007 17:44:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 15 Sep 2007 19:44:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196IPMt0rJ6ZJ9OyW4B4lzif+D6Iy1QdgwBh4FU75
	L5f25mJTNpeSlW
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.63.0709151819200.19941@alpha.polcom.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58269>

Hi,

On Sat, 15 Sep 2007, Grzegorz Kulewski wrote:

> On Sat, 15 Sep 2007, martin f krafft wrote:
> > I understand also that this is not top priority for git, which is why 
> > I said earlier in the thread that the real difficulty might be to get 
> > Junio to accept a patch. But I think that the patch would be rather 
> > contained and small, having it all configurable would make it 
> > unintrusive, and if we all test it real well, it should pass as a 
> > bonus. After all, git can e.g upload patches to IMAP boxes, which in 
> > my world clearly is bonus material as well.
> 
> I also think such configuration option would be cool.

Why don't you just give it a try?  Hack on git, make it work for what you 
want to do, clean it up, make a nice patch series, post it here.

Then we'll talk.

Ciao,
Dscho
