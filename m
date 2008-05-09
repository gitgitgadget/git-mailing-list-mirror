From: Nicolas Pitre <nico@cam.org>
Subject: Re: Java Git (aka jgit) library switching license to BSD/EPL
Date: Fri, 09 May 2008 12:26:39 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0805091214170.23581@xanadu.home>
References: <20080509021158.GA29038@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Dave Watson <dwatson@mimvista.com>,
	Philippe Ombredanne <philippe@easyeclipse.org>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 09 18:28:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuVRu-00072q-9s
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 18:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764146AbYEIQ1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 12:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756403AbYEIQ1E
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 12:27:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53332 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbYEIQ1B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 12:27:01 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K0M00F910BYH1C0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 09 May 2008 12:26:25 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080509021158.GA29038@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81622>

On Thu, 8 May 2008, Shawn O. Pearce wrote:

> Nico, Linus, Junio, Daniel, Dscho, et.al.:
> 
>   We would appreciate it if you could provide a statement saying
>   you have no current copyright ownership interest in jgit, and that
>   you do not currently own nor invented any patents related to the
>   "Git technology" that this code might need to use to function as
>   a Git implementation.

I do not have any such copyright nor patent claims for the jgit code.

As long as the C version remains the authoritative reference 
implementation for protocol and data format, and any algorithmic 
improvements made to the jgit source can be merged back into the C 
version using the GPL, then I have no issue with the license used by 
jgit either.


Nicolas
