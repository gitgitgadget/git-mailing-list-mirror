From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Fix incorrect wording in git-merge.txt.
Date: Mon, 03 Mar 2008 17:10:59 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0803031706320.2899@xanadu.home>
References: <1204564483-5260-1-git-send-email-Matthieu.Moy@imag.fr>
 <alpine.LFD.1.00.0803031320180.2899@xanadu.home>
 <vpqlk4zoacw.fsf@bauges.imag.fr>
 <alpine.LFD.1.00.0803031519360.2899@xanadu.home>
 <vpqwsojlcu5.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Mar 03 23:12:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWIsn-0005cB-Pe
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 23:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932AbYCCWLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 17:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753390AbYCCWLA
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 17:11:00 -0500
Received: from relais.videotron.ca ([24.201.245.36]:49366 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbYCCWLA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 17:11:00 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JX600LKRDMBJW60@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 03 Mar 2008 17:10:59 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <vpqwsojlcu5.fsf@bauges.imag.fr>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75986>

On Mon, 3 Mar 2008, Matthieu Moy wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> >> Now, I don't understand the distinction you seem to be making between
> >> "commit" and "commit object".
> >
> > Objects are what the low level storage is made of.  Conceptually, The 
> > merge operation doesn't work at the object level, but rather at the 
> > history graph level.
> 
> I still don't get the distinction. What is the "graph" if not a set of
> objects pointing to each other?
> 
> If you don't want to talk about commit object, then you should fix
> also user-manual.txt (for example, it states that a merge "create a
> commit object in the history").
> 
> Well, that said, the same sentence as the one I propose without
> "object" is fine to me, but I just don't understand the difference.

Sorry.  I don't have enough free time to pursue this point, nor do I 
consider it important enough.  So if no one else feels like the 
distinction deserves to be made then I won't care anymore either.


Nicolas
