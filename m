From: Nicolas Pitre <nico@cam.org>
Subject: Re: Git and GCC
Date: Thu, 06 Dec 2007 09:01:51 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712060901120.555@xanadu.home>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
 <20071205.202047.58135920.davem@davemloft.net>
 <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>
 <20071205.204848.227521641.davem@davemloft.net>
 <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>
 <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>
 <1196927361.13109.1.camel@brick>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Berlin <dberlin@dberlin.org>,
	David Miller <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, git@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 15:02:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0HIs-0004Z8-Ca
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 15:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbXLFOBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 09:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752763AbXLFOBy
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 09:01:54 -0500
Received: from relais.videotron.ca ([24.201.245.36]:20084 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbXLFOBw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 09:01:52 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSM006K4SB31S50@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 06 Dec 2007 09:01:51 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1196927361.13109.1.camel@brick>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67285>

On Wed, 5 Dec 2007, Harvey Harrison wrote:

> 
> > 	git repack -a -d --depth=250 --window=250
> > 
> 
> Since I have the whole gcc repo locally I'll give this a shot overnight
> just to see what can be done at the extreme end or things.

Don't forget to add -f as well.


Nicolas
