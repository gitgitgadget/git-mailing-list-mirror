From: Nicolas Pitre <nico@cam.org>
Subject: Re: Applying patches from gmane can be dangerous.
Date: Wed, 06 Feb 2008 23:29:12 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802062327350.2732@xanadu.home>
References: <20080205211044.GP26392@lavos.net>
 <7vodatqu6w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Brian Downing <bdowning@lavos.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Magne Ingebrigtsen <larsi+gmane@gnus.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 05:29:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMyOS-0006iC-9E
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 05:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561AbYBGE3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 23:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756049AbYBGE3O
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 23:29:14 -0500
Received: from relais.videotron.ca ([24.201.245.36]:28425 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755786AbYBGE3N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 23:29:13 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JVU0081VPSOK6C0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 06 Feb 2008 23:29:12 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vodatqu6w.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72891>

On Wed, 6 Feb 2008, Junio C Hamano wrote:

> I picked up the qsort patch from Brian while reading the list
> via gmane's newsfeed and applied it without realizing that it
> was one of the articles whose addresses on all the address
> header fields _and_ all strings that look like e-mail addresses
> have been mangled by gmane.  Sign-offs by Dscho and Steffen
> Prohaska have also been munged (even though that are not part of
> headers).
> 
> It already is part of 'next', and we have the policy of not
> rewinding 'next', so the record of this mistake will
> unfortunately be with us forever.  Sorry, Brian, Dscho and
> Steffen.

Maybe you can make an exception for this time?  A single


Nicolas
