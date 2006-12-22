From: Nicolas Pitre <nico@cam.org>
Subject: Re: confusion over the new branch and merge config
Date: Fri, 22 Dec 2006 10:10:13 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612221009310.18171@xanadu.home>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
 <200612220841.46016.andyparkins@gmail.com>
 <8c5c35580612220139x491dc3ecwf3fc60dda2fa379f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 16:10:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxm2q-0002J0-Qn
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 16:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423153AbWLVPKQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 10:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423168AbWLVPKQ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 10:10:16 -0500
Received: from relais.videotron.ca ([24.201.245.36]:46721 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423153AbWLVPKO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 10:10:14 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JAO00DC1KT1PW60@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 22 Dec 2006 10:10:14 -0500 (EST)
In-reply-to: <8c5c35580612220139x491dc3ecwf3fc60dda2fa379f@mail.gmail.com>
X-X-Sender: nico@xanadu.home
To: Lars Hjemli <hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35179>

On Fri, 22 Dec 2006, Lars Hjemli wrote:

> On 12/22/06, Andy Parkins <andyparkins@gmail.com> wrote:
> > On Thursday 2006 December 21 22:17, Nicolas Pitre wrote:
> > > $ git branch -r
> > > * master
> > >   origin/HEAD
> > >   origin/html
> > >   origin/maint
> > >   origin/man
> > >   origin/master
> > >   origin/next
> > >   origin/pu
> > >   origin/todo
> >
> > I'm trying to track down why "master" is being shown in this case";
> 
> This looks very much like "git branch -a".

Yes it was.  I just pasted the wrong line in my example.  Sorry.


Nicolas
