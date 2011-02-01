From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [1.8.0] 't/' is standard name for directory with tests
Date: Mon, 31 Jan 2011 19:33:16 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101311930280.8580@xanadu.home>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
 <m3d3ncag7r.fsf_-_@localhost.localdomain>
 <alpine.LFD.2.00.1101311728180.8580@xanadu.home>
 <AANLkTi=uOhgnKxRpA0Vm2uSe+uznPwjRB-=2e81VTf-f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_4R3TKqsEqIFJLiBWphFn2w)"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Budovski <abudovski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 01:33:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk4BO-0005hi-Vj
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 01:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591Ab1BAAdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 19:33:18 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60381 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920Ab1BAAdR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 19:33:17 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFW0042SXIT4390@vl-mo-mrz23.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 31 Jan 2011 19:32:53 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTi=uOhgnKxRpA0Vm2uSe+uznPwjRB-=2e81VTf-f@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165781>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_4R3TKqsEqIFJLiBWphFn2w)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Tue, 1 Feb 2011, Alex Budovski wrote:

> >> Nope.  't/' is the standard name for directory with "normal" tests, at
> >> least in Perl / CPAN land, where TAP comes from ('xt/' is for extra
> >> tests)
> >
> > So what?  It is not because Perl has set this horrible precedent that we
> > have to perpetuate it.  I personally never saw t used as a directory
> > name for tests before Git, and I'm not that young anymore unfortunately.
> 
> The MySQL project (and its clones) also uses the t/ convention.

OK, that makes for another one.

Now what about those hundred counter-example projects _not_ using "t" 
but something more descriptive?


Nicolas

--Boundary_(ID_4R3TKqsEqIFJLiBWphFn2w)--
