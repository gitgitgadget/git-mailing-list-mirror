From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-fetch, was Re: [PATCH] Port git-tag.sh to C.
Date: Tue, 12 Jun 2007 12:51:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706121237400.5848@iabervon.org>
References: <11813427591137-git-send-email-krh@redhat.com>
 <1b46aba20706081858u7f18d9b2o5602db43d396c19@mail.gmail.com>
 <Pine.LNX.4.64.0706112314300.5848@iabervon.org> <Pine.LNX.4.64.0706121341250.4059@racer.site>
 <Pine.LNX.4.64.0706121427410.18585@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Carlos Rica <jasampler@gmail.com>,
	=?X-UNKNOWN?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Jun 12 18:51:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy9aZ-0007xG-5K
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 18:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896AbXFLQvZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 12:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754795AbXFLQvZ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 12:51:25 -0400
Received: from iabervon.org ([66.92.72.58]:3190 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754639AbXFLQvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 12:51:25 -0400
Received: (qmail 13417 invoked by uid 1000); 12 Jun 2007 16:51:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jun 2007 16:51:24 -0000
In-Reply-To: <Pine.LNX.4.64.0706121427410.18585@reaper.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49972>

On Tue, 12 Jun 2007, Julian Phillips wrote:

> On Tue, 12 Jun 2007, Johannes Schindelin wrote:
> 
> > How about pushing them onto repo.or.cz as a fork of git.git?
> 
> I'd quite like to see these changes too - since I haven't finished the fetch
> work yet, and I don't want to duplicate effort ;)

I'll put it up on my server this evening; I forgot to push the latest 
version from my laptop to somewhere I can get it.

> (It seems that the closer I get to a working fetch the less time I spend on it
> ... :$)

My efforts have similarly stagnated, but the GSoC talk reminded me that a 
third person could take over. Although the series I just posted adds 
branch config parsing, which is helpful for making fetch clean, even if it 
doesn't make it closer to working completely.

	-Daniel
*This .sig left intentionally blank*
