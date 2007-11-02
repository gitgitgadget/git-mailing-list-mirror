From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] New script: git-changelog.perl
Date: Fri, 02 Nov 2007 14:53:31 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0711021447510.21255@xanadu.home>
References: <67837cd60711020855v5badf7a6o9b777f339df070f@mail.gmail.com>
 <Pine.LNX.4.64.0711021821410.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ronald Landheer-Cieslak <ronald@landheer-cieslak.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 02 19:53:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io1eN-0001W0-1T
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 19:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760413AbXKBSxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 14:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760063AbXKBSxc
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 14:53:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41596 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760405AbXKBSxc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 14:53:32 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQW0072H7579E15@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 02 Nov 2007 14:53:31 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <Pine.LNX.4.64.0711021821410.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63154>

On Fri, 2 Nov 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Fri, 2 Nov 2007, Ronald Landheer-Cieslak wrote:
> 
> > I've written a little script that will format the changes as reported
> > by git-log in a ChangeLog-like format.
> 
> Jakub already commented on the availability of git2cl, but I thought I'd 
> clarify: once upon a time I even wrote some builtin to perform that 
> transformation, and it was met with unilateral disgus^Wagreement not to 
> include it into core git.
> 
> Therefore I think it would be sanest to enhance git2cl until it does what 
> you want to do.

The contrib directory is certainly a good place for such scripts as 
well.


Nicolas
