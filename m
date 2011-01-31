From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Mon, 31 Jan 2011 16:33:22 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101311630010.8580@xanadu.home>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
 <7vvd144wrl.fsf@alter.siamese.dyndns.org> <vpqwrlkg4r8.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jan 31 22:33:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk1NO-0003la-Mh
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 22:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756170Ab1AaVd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 16:33:29 -0500
Received: from relais.videotron.ca ([24.201.245.36]:39527 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514Ab1AaVd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 16:33:29 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFW009EFP78NQB0@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 31 Jan 2011 16:33:09 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <vpqwrlkg4r8.fsf@bauges.imag.fr>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165756>

On Mon, 31 Jan 2011, Matthieu Moy wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > other than adding merge burden on me and rebase burden on others, that
> > is.
> 
> That can be seen as a test of how good Git is at bulk rename
> management ;-).
> 
> All that said, I cannot really say whether the benefit is higher than
> the cost.

There is a huge value in inflicting on ourselves such a test case for 
the tool we produce.  That helps avoiding the ivory tower syndrome.


Nicolas
