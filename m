From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: excerpts from tomorrow's "What's cooking" draft
Date: Wed, 11 Nov 2009 17:04:54 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911111702130.16711@xanadu.home>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
 <20091111184215.GG27518@vidovic>
 <alpine.LFD.2.00.0911111408380.16711@xanadu.home>
 <20091111210727.GN12890@machine.or.cz>
 <alpine.LFD.2.00.0911111617440.16711@xanadu.home>
 <20091111214216.GO12890@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Nov 11 23:05:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8LJK-00083q-Hp
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 23:05:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759305AbZKKWEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 17:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759290AbZKKWEz
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 17:04:55 -0500
Received: from relais.videotron.ca ([24.201.245.36]:49665 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758868AbZKKWEy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 17:04:54 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KSY002VMTC6QFF0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 11 Nov 2009 17:04:54 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20091111214216.GO12890@machine.or.cz>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132712>

On Wed, 11 Nov 2009, Petr Baudis wrote:

> On Wed, Nov 11, 2009 at 04:19:44PM -0500, Nicolas Pitre wrote:
> > On Wed, 11 Nov 2009, Petr Baudis wrote:
> > 
> > > Yes, but nothing should have changed in git-daemon, that's the only part
> > > of the infrastructure that uses system-wide git (which it perhaps
> > > shouldn't). I cannot reproduce this problem, though. I have changed
> > > git-daemon to use my local git version (about one week old master), does
> > > this still happen for you?
> > 
> > No, it doesn't happen anymore.
> > 
> > What was the git-daemon version before?
> 
> 1.5.6.5, the default version in debian lenny

Go figure.  I don't see anything that would explain the difference in 
behavior with latest git from a quick look.


Nicolas
