From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: HTTP pushes
Date: Tue, 1 Nov 2005 15:06:42 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511011500580.25300@iabervon.org>
References: <20051101020248.GA3928@reactrix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 21:09:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX2PV-0007BO-GT
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 21:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbVKAUHG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 15:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVKAUHF
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 15:07:05 -0500
Received: from iabervon.org ([66.92.72.58]:16912 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751306AbVKAUHC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 15:07:02 -0500
Received: (qmail 22378 invoked by uid 1000); 1 Nov 2005 15:06:42 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Nov 2005 15:06:42 -0500
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051101020248.GA3928@reactrix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10950>

On Mon, 31 Oct 2005, Nick Hengeveld wrote:

> HTTP is currently listed as a read-only/unsupported method for doing
> pushes, is that due to inherent problems with HTTP or just because
> it hasn't been written yet?

You obviously need a bit more than HTTP, and I don't personally know DAV. 
Also, I was writing things with all of the control on the receiving side, 
which isn't going to be the case here. If you've got a suitable 
environment for that sort of thing, I say go for it.

	-Daniel
*This .sig left intentionally blank*
