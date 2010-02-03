From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: extra headers in commit objects
Date: Wed, 03 Feb 2010 13:15:45 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002031311010.1681@xanadu.home>
References: <20100203174041.GC14799@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 19:15:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcjlY-0005SJ-8J
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 19:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013Ab0BCSPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 13:15:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:12672 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951Ab0BCSPq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 13:15:46 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KXA00LJR2Q9TV20@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 03 Feb 2010 13:15:45 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100203174041.GC14799@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138852>

On Wed, 3 Feb 2010, Shawn O. Pearce wrote:

> Am I correct that core C developers are still under the opinion
> that extra headers in a commit object aren't encouraged?

I would say so.

[...]
> At the end of the day, is it a bug that C git doesn't support
> working with extra commit headers?  IMHO, no, because, we've
> rejected these in the past, and its not part of the Git standard.
> And other implementations shouldn't be trying to sell it that way.

Agreed.  And this was discussed in great length on this list on few 
occasions already (probably more than a year back).


Nicolas
