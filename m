From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's in git.git
Date: Wed, 01 Mar 2006 16:28:07 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0603011625250.29834@localhost.localdomain>
References: <7vmzgagxox.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 22:28:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEYrh-0005V6-KY
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 22:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWCAV2G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 16:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbWCAV2G
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 16:28:06 -0500
Received: from relais.videotron.ca ([24.201.245.36]:21577 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751262AbWCAV2F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 16:28:05 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IVG00F56WYSAQO0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 01 Mar 2006 16:28:04 -0500 (EST)
In-reply-to: <7vmzgagxox.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17015>

On Wed, 1 Mar 2006, Junio C Hamano wrote:

>   These are waiting for further progress by authors:
> 
>   - delta packer updates for tighter packs (Nicolas Pitre)

Please don't wait to merge the first two patches to diff-delta.c.  They 
are purely cleanups with no functional differences.


Nicolas
