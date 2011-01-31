From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [1.8.0] 't/' is standard name for directory with tests
Date: Mon, 31 Jan 2011 17:32:53 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101311728180.8580@xanadu.home>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
 <m3d3ncag7r.fsf_-_@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 23:33:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk2Iy-0002f0-0v
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 23:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756605Ab1AaWcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 17:32:55 -0500
Received: from relais.videotron.ca ([24.201.245.36]:42231 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338Ab1AaWcy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 17:32:54 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz24.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFW00CMDRY59RD0@vl-mo-mrz24.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 31 Jan 2011 17:32:30 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <m3d3ncag7r.fsf_-_@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165766>

On Mon, 31 Jan 2011, Jakub Narebski wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > So I'd suggest doing the following:
> 
> > 5) Rename t/ to testsuite/ so this doesn't look like some garbage 
> >    leftover.
> 
> Nope.  't/' is the standard name for directory with "normal" tests, at
> least in Perl / CPAN land, where TAP comes from ('xt/' is for extra
> tests)

So what?  It is not because Perl has set this horrible precedent that we 
have to perpetuate it.  I personally never saw t used as a directory 
name for tests before Git, and I'm not that young anymore unfortunately.


Nicolas
