From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: git push bug?
Date: Thu, 18 Oct 2007 18:31:56 +0200
Organization: Transmode AB
Message-ID: <1192725116.4954.7.camel@gentoo-jocke.transmode.se>
References: <1192719040.9433.5.camel@gentoo-jocke.transmode.se>
	 <0DAC53EF-021D-441C-9520-9795AAB6DE54@zib.de>
	 <1192723269.9433.21.camel@gentoo-jocke.transmode.se>
	 <Pine.LNX.4.64.0710181720010.25221@racer.site>
Reply-To: joakim.tjernlund@transmode.se
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 18 20:04:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiZj4-0001vC-Ia
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 20:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758153AbXJRSDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 14:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756776AbXJRSDz
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 14:03:55 -0400
Received: from mail.transmode.se ([83.241.175.147]:25540 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753183AbXJRSDy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 14:03:54 -0400
Received: mail.transmode.se 192.168.46.15 from 192.168.1.15 192.168.1.15 via HTTP with MS-WebStorage 6.0.6249
Received: from gentoo-jocke by mail.transmode.se; 18 Oct 2007 20:03:48 +0200
In-Reply-To: <Pine.LNX.4.64.0710181720010.25221@racer.site>
X-Mailer: Evolution 2.10.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61551>

On Thu, 2007-10-18 at 17:21 +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 18 Oct 2007, Joakim Tjernlund wrote:
> 
> > Seems like it is a bit too easy to make mistakes here. Why can I delete 
> > a branch with :linus but not create one with linus:linus?
> 
> I wonder why you bother with the colon at all.  Just
> 
> 	git push <remote> linus
> 
> and be done with it.  The colon is only there to play interesting games, 
> not something as simple as "push this branch" or "push this tag".

First, I didn't know that I could do that.
Secondly, I was also looking do v2.6.23:linus refspecs

 Jocke 
