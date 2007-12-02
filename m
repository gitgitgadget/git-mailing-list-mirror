From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Sun, 2 Dec 2007 16:39:28 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712021637250.27959@racer.site>
References: <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org>
 <7veje8twt2.fsf@gitster.siamese.dyndns.org> <20071130003512.GB11683@coredump.intra.peff.net>
 <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org> <20071130005852.GA12224@coredump.intra.peff.net>
 <alpine.LFD.0.99999.0711292004340.9605@xanadu.home>
 <20071130011748.GC11683@coredump.intra.peff.net> <474FB938.3040209@op5.se>
 <20071130150948.GA22095@coredump.intra.peff.net> <7vve7jqz92.fsf@gitster.siamese.dyndns.org>
 <20071130212500.GB25946@coredump.intra.peff.net> <Pine.LNX.4.64.0711302306580.27959@racer.site>
 <FFEBE8BB-E764-4DD0-A7DC-8CC01659D9BC@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>, Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 17:40:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iyrs1-0008M9-Sq
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 17:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbXLBQkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 11:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbXLBQkE
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 11:40:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:58346 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754827AbXLBQkB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 11:40:01 -0500
Received: (qmail invoked by alias); 02 Dec 2007 16:39:58 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp057) with SMTP; 02 Dec 2007 17:39:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pBDgj1XdpQJbSi4wsV/IrVk+xGiXbAenbg946Tn
	H1L79CENY9Fi2K
X-X-Sender: gene099@racer.site
In-Reply-To: <FFEBE8BB-E764-4DD0-A7DC-8CC01659D9BC@wincent.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66792>

Hi,

On Sun, 2 Dec 2007, Wincent Colaiuta wrote:

> El 1/12/2007, a las 0:10, Johannes Schindelin escribi?:
> 
> > To me, it is mighty annoying anybody brings up that "144 commands" 
> > argument Linus was referring to, and if there is _any_ way to shut up 
> > those bikeshedders, I am all for it.
> 
> This is not a bikeshed argument and it is not an "idiotic complaint" (to 
> use Linus' phrase). It is a legitimate concern and a *real* UI problem.
> 
> You and Linus don't care that there are 140+ Git commands and I imagine 
> that you know exactly what each of them does.

Okay, how many executables are there in your /usr/bin/?  Here there are 
2973.

Guess what.  I am not intimidated by that number.

Ciao,
Dscho
