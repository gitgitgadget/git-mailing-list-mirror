From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/4] The rest of builtin-fetch
Date: Wed, 11 Jul 2007 21:49:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707112145220.6977@iabervon.org>
References: <Pine.LNX.4.64.0707112113460.6977@iabervon.org>
 <Pine.LNX.4.64.0707120244200.4516@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 12 03:49:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8nnp-00021V-BF
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 03:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761658AbXGLBtG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 21:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761561AbXGLBtF
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 21:49:05 -0400
Received: from iabervon.org ([66.92.72.58]:4630 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760309AbXGLBtE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 21:49:04 -0400
Received: (qmail 32060 invoked by uid 1000); 12 Jul 2007 01:49:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jul 2007 01:49:01 -0000
In-Reply-To: <Pine.LNX.4.64.0707120244200.4516@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52234>

On Thu, 12 Jul 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Wed, 11 Jul 2007, Daniel Barkalow wrote:
> 
> > This series is the rest of builtin-fetch. It should probably not be used 
> > without a "[PATCH 3.5/4] Support bundles in transport fetch" which 
> > Johannes was going to write.
> 
> 8-)
> 
> It is 3am, and I am already in the middle of git hacking, and should go to 
> bed, so that'll have to wait for tomorrow...

We're presumably waiting for 1.5.3 before this actually goes anywhere, so 
there's no big hurry. Just don't want it to get forgotten and have 
mainline versions where the tests don't pass due to bundles not working 
(or, worse, an actual release where we forget about them in this context).

	-Daniel
*This .sig left intentionally blank*
