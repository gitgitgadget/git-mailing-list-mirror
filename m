From: Nicolas Pitre <nico@cam.org>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 16:27:14 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807161611540.3110@xanadu.home>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 16 22:28:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJDbk-0006Xn-NY
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 22:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630AbYGPU1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 16:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753589AbYGPU1Q
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 16:27:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61216 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087AbYGPU1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 16:27:16 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K44003BR8SQOA31@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 16 Jul 2008 16:26:50 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.0807161804400.8950@racer>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88743>

On Wed, 16 Jul 2008, Johannes Schindelin wrote:

> I had the pleasure of introducing Git to a few users in the last months 
> and in my opinion, restricting myself to teaching them these commands 
> first helped tremendously:
> 
> - clone, pull, status, add, commit, push, log
> 
> All of these were presented without options, to keep things simple.

I completely agree with you.

In the context of remote tracking branches, I usually talk about
'git init' + 'git remote' + 'git fetch' + 'git merge' and/or
'git rebase' which is somehow simpler to really understand than
'git clone' + 'git pull'.  At that point the branch concept is usually
clear.


Nicolas
