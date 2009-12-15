From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Mon, 14 Dec 2009 19:29:49 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912141927120.23173@xanadu.home>
References: <1260822484.9379.53.camel@localhost>
 <20091214211142.GC9364@coredump.intra.peff.net>
 <1260825629.9379.56.camel@localhost>
 <20091214212343.GA11131@coredump.intra.peff.net>
 <1260827790.9379.59.camel@localhost>
 <fabb9a1e0912141403hb728974sc50b9e8dbb08925d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Eric Paris <eparis@redhat.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 01:29:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKLIb-0008EO-Dr
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 01:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758907AbZLOA3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 19:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757759AbZLOA3w
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 19:29:52 -0500
Received: from relais.videotron.ca ([24.201.245.36]:9023 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514AbZLOA3u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 19:29:50 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KUO00BZS41P7AF0@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Dec 2009 19:29:49 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <fabb9a1e0912141403hb728974sc50b9e8dbb08925d@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135257>

On Mon, 14 Dec 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Mon, Dec 14, 2009 at 22:56, Eric Paris <eparis@redhat.com> wrote:
> > Just started pushing the 1.3G file.
> >
> > Maybe having a .git directory that large is the problem?
> 
> What did you say this repository contained again? Your home video's?
> Ah, well that explains ;).

That would explain the size, but not the reflog CPU time.


Nicolas
