From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Google Summer of Code 2008
Date: Sat, 1 Mar 2008 01:37:58 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0803010132590.4091@kaos.quantumfyre.co.uk>
References: <200802262356.28971.jnareb@gmail.com> <20080228063621.GR8410@spearce.org>
 <alpine.LSU.1.00.0802281021070.22527@racer.site> <200802291304.16026.jnareb@gmail.com>
 <Pine.LNX.4.64.0802291241400.18516@reaper.quantumfyre.co.uk>
 <alpine.LSU.1.00.0802291302560.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org, John Hawley <warthog9@kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 01 02:38:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVGgP-0002QU-L6
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 02:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757147AbYCABiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 20:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755765AbYCABiA
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 20:38:00 -0500
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:49439 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755500AbYCABiA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Feb 2008 20:38:00 -0500
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id CE2A9127130
	for <git@vger.kernel.org>; Sat,  1 Mar 2008 01:37:58 +0000 (GMT)
Received: (qmail 10807 invoked by uid 103); 1 Mar 2008 01:37:58 +0000
Received: from 192.168.0.4 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.4):. 
 Processed in 0.029944 secs); 01 Mar 2008 01:37:58 -0000
Received: from elfhelm.quantumfyre.co.uk (HELO kaos.quantumfyre.co.uk) (192.168.0.4)
  by neutron.datavampyre.co.uk with SMTP; 1 Mar 2008 01:37:58 +0000
X-X-Sender: jp3@kaos.quantumfyre.co.uk
In-Reply-To: <alpine.LSU.1.00.0802291302560.22527@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75600>

On Fri, 29 Feb 2008, Johannes Schindelin wrote:

> Hi,
>
> On Fri, 29 Feb 2008, Julian Phillips wrote:
>
>> FWIW: I have a partially implemented python git-svnserver that speaks the
>> svn:// protocol ... so far I can checkout from a git repos using the svn
>> client, and not much else.  It's been on the backburner for a while, but I had
>> recently thought about revisiting it - but getting someone else to do the
>> implementation works too ;)
>
> How about publishing it, so other people can take up the ball?

It did work very well for the builtin fetch, didn't it?
(thanks Daniel)

Progress so far can be found at:

http://git.q42.co.uk/w/git_svn_server.git

>
> Ciao,
> Dscho
>

-- 
Julian

  ---
Nature, to be commanded, must be obeyed.
 		-- Francis Bacon
