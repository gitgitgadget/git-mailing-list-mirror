From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] Document how to tell git to not launch a pager
Date: Thu, 19 Jul 2007 12:38:23 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707191235490.32611@reaper.quantumfyre.co.uk>
References: <20070719104351.GA17182@midwinter.com>
 <20070719110224.GA4293@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0707191211010.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 19 13:39:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBULf-0001K6-HR
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 13:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764399AbXGSLi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 07:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758467AbXGSLi2
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 07:38:28 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:39172 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755528AbXGSLi1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jul 2007 07:38:27 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 38EEAD75E1
	for <git@vger.kernel.org>; Thu, 19 Jul 2007 12:38:26 +0100 (BST)
Received: (qmail 21701 invoked by uid 103); 19 Jul 2007 12:38:23 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3697. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.030832 secs); 19 Jul 2007 11:38:23 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 19 Jul 2007 12:38:23 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <Pine.LNX.4.64.0707191211010.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52973>

On Thu, 19 Jul 2007, Johannes Schindelin wrote:

> Hi,
>
> On Thu, 19 Jul 2007, martin f krafft wrote:
>
>> [...] I also wonder why use of a pager is default in git anyway. At
>> least I find it to be contrary to what I am used to on the Unix command
>> line.
>
> It was evidently liked unilaterally amongst the big whigs in the git
> community.  Me too, I like it (which says nothing about my hair style).
> Often it annoys me tremendously that all the other programs like make, ls,
> etc. do not have this nice "-p" flag.

I love it. It's currently playing merry havoc with my Subversion usage at 
work though.  I've got so used to git never chucking things off the top of 
the screen that I keep forgetting to run 'svn ... | less'.

Also searching in a console isn't anywhere near as easy.

-- 
Julian

  ---
Sometimes a man who deserves to be looked down upon because he is a
fool is despised only because he is a lawyer.
 		-- Montesquieu
