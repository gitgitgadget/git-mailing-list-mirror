From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] gc: call "prune --expire 2.weeks.ago" by default
Date: Thu, 13 Mar 2008 00:43:17 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803130042520.1656@racer.site>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <alpine.LSU.1.00.0803121833210.1656@racer.site> <47D8193B.901@nrlssc.navy.mil> <m3prtzyens.fsf@localhost.localdomain>
 <47D83532.70103@nrlssc.navy.mil> <alpine.LSU.1.00.0803122058430.1656@racer.site> <47D83C53.7000602@nrlssc.navy.mil> <7vejaf65q0.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803122153440.1656@racer.site> <7vwso74p33.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803122348210.1656@racer.site> <7vzlt335a5.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803130021520.1656@racer.site> <7vod9j342h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Jakub Narebski <jnareb@gmail.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 00:43:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZabv-0004gF-3m
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 00:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbYCLXnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 19:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbYCLXnN
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 19:43:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:42036 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751807AbYCLXnM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 19:43:12 -0400
Received: (qmail invoked by alias); 12 Mar 2008 23:43:10 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp049) with SMTP; 13 Mar 2008 00:43:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+dVAZ3RcadaC5DczzjMTQ8RDPPq+k1H1SfpO9v90
	5OndbSzOI4gaB3
X-X-Sender: gene099@racer.site
In-Reply-To: <7vod9j342h.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77028>

Hi,

On Wed, 12 Mar 2008, Junio C Hamano wrote:

> I have to wonder if approxidate_with_error() function that takes a 
> pointer to receive an error condition may be a better way to solve this 
> cleanly.

Right.  But that will have to wait for at least tomorrow, if it waits for 
me.

Ciao,
Dscho
