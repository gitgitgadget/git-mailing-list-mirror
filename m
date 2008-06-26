From: Nicolas Pitre <nico@cam.org>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Thu, 26 Jun 2008 09:50:44 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806260949010.2979@xanadu.home>
References: <20080620082034.GA24913@elte.hu>
 <m34p7ombie.fsf@localhost.localdomain> <20080626093726.GA24577@elte.hu>
 <200806261302.03952.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ingo Molnar <mingo@elte.hu>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 15:51:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBrtA-0000CZ-No
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 15:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762727AbYFZNur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 09:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762676AbYFZNur
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 09:50:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24460 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762630AbYFZNuq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 09:50:46 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K3200G1KP4KTH10@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 26 Jun 2008 09:50:45 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <200806261302.03952.jnareb@gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86454>

On Thu, 26 Jun 2008, Jakub Narebski wrote:

> On Thu, 26. Jun 2008, Ingo Molnar wrote:
> > so please do not remove the git-* commands, they are really useful.
> 
> Well, they are not removed, just moved aside (to address complaints
> of cluttering $PATH with 130+ programs), and I think that you can
> always install everything into /usr/bin/, as usual.  Although it would
> be nice to be able to move aside only internal (*--*) commands, or
> perhaps even internal and plumbing.

Or simply add $gitexecdir to your search path.


Nicolas
