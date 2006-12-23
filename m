From: Nicolas Pitre <nico@cam.org>
Subject: Re: branch.<name>.merge specifying remote branch name
Date: Sat, 23 Dec 2006 09:26:11 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612230924110.18171@xanadu.home>
References: <emirt5$kh3$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 15:26:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy7pH-0001tu-UU
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 15:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbWLWO0N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 09:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753552AbWLWO0N
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 09:26:13 -0500
Received: from relais.videotron.ca ([24.201.245.36]:42971 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549AbWLWO0M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 09:26:12 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JAQ004CKDFN2C60@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 23 Dec 2006 09:26:12 -0500 (EST)
In-reply-to: <emirt5$kh3$2@sea.gmane.org>
X-X-Sender: nico@xanadu.home
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35317>

On Sat, 23 Dec 2006, Jakub Narebski wrote:

> About the discussion about branch.<name>.merge specifying remote branch name
> and relative merits of specifying remote branch name (without need for
> tracking branch), and local branch name (which is supposedly more user
> friendly, and branch name specifies also remote usually)...
> 
> Perhaps it is time to resurrect branch.<name>.mergeLocal (or localMerge)
> idea, and both sides would be happy (well, at least when one would code
> it ;-).

Adding more and more options doesn't make it friendlier to use.

Why couldn't both names (local and remote) be accepted by 
branch.blah.merge?


Nicolas
