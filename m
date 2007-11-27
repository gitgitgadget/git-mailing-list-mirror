From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 27 Nov 2007 13:54:17 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711271352050.27959@racer.site>
References: <200711270622.lAR6MFXQ010010@mi0.bluebottle.com>
 <Pine.LNX.4.64.0711271109130.27959@racer.site> <474C1F80.5060404@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?UTF-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Nov 27 14:54:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix0ti-0006mA-Ln
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 14:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbXK0Ny1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 08:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbXK0Ny1
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 08:54:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:38301 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750793AbXK0Ny0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 08:54:26 -0500
Received: (qmail invoked by alias); 27 Nov 2007 13:54:22 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp008) with SMTP; 27 Nov 2007 14:54:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Shnh3RSnSWogbd6dcIKBgxXibhGAn2ZmO5a66k7
	dN/npalqDQPoZC
X-X-Sender: gene099@racer.site
In-Reply-To: <474C1F80.5060404@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66210>

Hi,

On Tue, 27 Nov 2007, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> 
> >  One thing that could go possibly wrong, for example, is to rebase 
> > commits that you already published.
> 
> For the vast majority of git users, that's a non-issue as "published" is 
> usually defined as "pushed to the publicly advertised watering hole".

No.  This is only the "vast majority of git users told by their peers to 
use a central repository".

Just because you use git like cvs does not mean that you "use git".

> Yes, I'm aware that git is distributed. That doesn't mean that it's not 
> convenient to have one single place where all code meant to be released 
> eventually ends up.

It may be convenient for you.  I do not like it.  Yes, I even made the 
mistake with msysGit.  In the end, it would have been much more 
intelligent to set up a repository which others would have had to fork 
from.

Ciao,
Dscho
