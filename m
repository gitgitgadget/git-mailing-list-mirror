From: Nicolas Pitre <nico@cam.org>
Subject: Re: Unresolved issues #2
Date: Tue, 09 May 2006 09:09:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605090907260.24505@localhost.localdomain>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
 <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
 <1147174809.2794.12.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 15:09:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdRxn-0005Ga-LK
	for gcvg-git@gmane.org; Tue, 09 May 2006 15:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWEINJP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 09:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWEINJO
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 09:09:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44387 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932498AbWEINJO
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 9 May 2006 09:09:14 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IZ000E8E1VDCY50@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 09 May 2006 09:09:13 -0400 (EDT)
In-reply-to: <1147174809.2794.12.camel@pmac.infradead.org>
X-X-Sender: nico@localhost.localdomain
To: David Woodhouse <dwmw2@infradead.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19837>

On Tue, 9 May 2006, David Woodhouse wrote:

> I'm not sure about that. The payload is patches, isn't it? That's just
> text, too -- we aren't going to deal with diffs of binary content very
> well _anyway_, are we?

Yes we do.  GIT now has its own email friendly binary patch format.


Nicolas
