From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Mon, 17 Dec 2007 23:09:57 -0500 (EST)
Message-ID: <alpine.LFD.0.999999.0712172308360.8467@xanadu.home>
References: <7vsl2jh3rb.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999999.0712141744460.8467@xanadu.home>
 <20071215004230.GF7300@mail.oracle.com>
 <alpine.LFD.0.999999.0712142114400.8467@xanadu.home>
 <20071217200920.GB19816@mail.oracle.com>
 <alpine.LFD.0.999999.0712171517320.8467@xanadu.home>
 <7v3au16myj.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999999.0712171641460.8467@xanadu.home>
 <7vbq8o4yxc.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999999.0712172212110.8467@xanadu.home>
 <46a038f90712171952i4f53876fv55b0e6993d5f4b0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Joel Becker <Joel.Becker@oracle.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 05:10:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Tml-0001wO-0p
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 05:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbXLREKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 23:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbXLREKA
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 23:10:00 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60144 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbXLREJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 23:09:58 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JT800LR18WJTM50@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 17 Dec 2007 23:09:56 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <46a038f90712171952i4f53876fv55b0e6993d5f4b0a@mail.gmail.com>
User-Agent: Alpine 0.999999 (LFD 847 2007-12-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68696>

On Tue, 18 Dec 2007, Martin Langhoff wrote:

> On Dec 18, 2007 4:23 PM, Nicolas Pitre <nico@cam.org> wrote:
> > Sure, but at some point that's something users mixing versions should be
> > ready to cope with.  We try to make it as painless as possible of
> > course.
> 
> I have to say I agree with the "apparently minor updates should not
> break cross-version compat". And I think it's a communication issue
> around the version numbering. The fact that this will be introduced
> with a v1.5.5 is, IMHO, a good part of the problem.
> 
> If cvs 1.11 doesn't talk with 1.12 I'll say there are nuts - minor
> revisions should interoperate with end users not even thinking about
> it. But 1.5.5 has in its changelog lots of deprecations and interop
> changes.
> 
> It's not good communication to label it 1.5.5.

I agree.  Might be time for 1.6.0?


Nicolas
