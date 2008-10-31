From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: commit type
Date: Sat, 1 Nov 2008 00:27:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811010025570.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <loom.20081031T174821-603@post.gmane.org> <ee77f5c20810311104m6044bf70r1d9d405fa04454e0@mail.gmail.com> <loom.20081031T191102-81@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: 7rans <transfire@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 00:21:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw3J6-00070B-Ei
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 00:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328AbYJaXUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 19:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbYJaXUB
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 19:20:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:57592 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750978AbYJaXUA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 19:20:00 -0400
Received: (qmail invoked by alias); 31 Oct 2008 23:19:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp045) with SMTP; 01 Nov 2008 00:19:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18EK99MldkEYyfflleuEL9Fc+HIPVoxnRLrWNbkkH
	W3HdPIiGgdvPlQ
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <loom.20081031T191102-81@post.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99672>

Hi,

On Fri, 31 Oct 2008, 7rans wrote:

> David Symonds <dsymonds <at> gmail.com> writes:
> 
> > On Fri, Oct 31, 2008 at 10:58 AM, 7rans <transfire <at> gmail.com> 
> > wrote:
> > 
> > > Currently I achieve this by adding "[type]" to the end of my commit 
> > > messages. But of course that's less than optimal.
> > 
> > Why is that less than optimal? It seems a lot less intrusive than what 
> > you suggest.
> 
> Because it becomes formalized. Which means people can write tools other 
> people can use to work with them.

So you want to force this onto all Git users?

If yes: that murmur you hear in the background, it might well be the 
collective "thanks, but no thanks" of people who do not want that type of 
distinction between different commits.

If no: what would be the real difference from that suffix in the oneline?

Ciao,
Dscho
