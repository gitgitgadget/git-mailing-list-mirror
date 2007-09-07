From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 07 Sep 2007 00:30:27 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0709070020130.21186@xanadu.home>
References: <46DDC500.5000606@etek.chalmers.se>
 <1189004090.20311.12.camel@hinata.boston.redhat.com>
 <vpq642pkoln.fsf@bauges.imag.fr>
 <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
 <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
 <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
 <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com>
 <loom.20070907T055946-637@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Paul Wankadia <junyer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 06:30:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITVUJ-0007VM-UA
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 06:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbXIGEa3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 00:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbXIGEa3
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 00:30:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:10084 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbXIGEa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 00:30:28 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JNZ002P7DUR1DE0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 07 Sep 2007 00:30:28 -0400 (EDT)
In-reply-to: <loom.20070907T055946-637@post.gmane.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57972>

On Fri, 7 Sep 2007, Paul Wankadia wrote:

> Wincent Colaiuta <win <at> wincent.com> writes:
> 
> > > I just wanted to get a sense of how many people share this "Git should
> > > be in pure C" doctrine.
> > 
> > Count me as one of them. Git is all about speed, and C is the best  
> > choice for speed, especially in context of Git's workload.
> 
> I concur, but I also feel that D, Clean and OCaml are viable alternatives.

I happen to have zero experience with any of those, so if Git 
development was done with one of them, you'd have to count me out.

C is simply the lingua franca when it comes to programming, and it 
happens to be the fastest amongst portable languages too.


Nicolas
