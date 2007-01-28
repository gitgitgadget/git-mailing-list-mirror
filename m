From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] user-manual: set user.name and user.email with repo-config
Date: Sat, 27 Jan 2007 21:55:10 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701272153400.3021@xanadu.home>
References: <20070127062826.GE14205@fieldses.org>
 <20070128002246.GA10179@moooo.ath.cx>
 <Pine.LNX.4.64.0701271625120.25027@woody.linux-foundation.org>
 <20070128013452.GA11244@moooo.ath.cx>
 <Pine.LNX.4.64.0701271745000.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matthias Lederhofer <matled@gmx.net>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 28 03:55:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HB0CN-0001EY-TT
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 03:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbXA1CzN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 21:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbXA1CzN
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 21:55:13 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27100 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932368AbXA1CzL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 21:55:11 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCK00DQC5FY9XH0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 27 Jan 2007 21:55:10 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0701271745000.25027@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38014>

On Sat, 27 Jan 2007, Linus Torvalds wrote:

> Many people thought "git init-db" was confusing, and now we call it just 
> "git init".
> 
> Can I vote for doing that for "git repo-config" too? Is there something 
> wrong with just calling it "git config"?

I really think this is an excellent suggestion.

In fact I wonder why I didn't suggest it myself in the first place.  ;-)


Nicolas
