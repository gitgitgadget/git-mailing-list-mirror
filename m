From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/7] Make unpack_trees_options bit flags actual
 bitfields
Date: Sat, 22 Mar 2008 18:57:52 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803221857360.4353@racer.site>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221021220.3020@woody.linux-foundation.org> <alpine.LSU.1.00.0803221835240.4353@racer.site> <alpine.LFD.1.00.0803221045280.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Frank <streamlake@tiscali.it>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 18:58:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd7zI-0004iB-Ej
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 18:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330AbYCVR5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 13:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755340AbYCVR5w
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 13:57:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:39518 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755107AbYCVR5w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 13:57:52 -0400
Received: (qmail invoked by alias); 22 Mar 2008 17:57:50 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp011) with SMTP; 22 Mar 2008 18:57:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+aRkoPlYeaUhTgogl5k7rNv56ABOtBQZmLPh7vtY
	lXteLWdmESlqOT
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0803221045280.3020@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77837>

Hi,

On Sat, 22 Mar 2008, Linus Torvalds wrote:

> On Sat, 22 Mar 2008, Johannes Schindelin wrote:
> 
> > Any point in doing the "From:" and "Date:" inside the mail body?
> 
> I encourage people to do that for the kernel ("From:" in particular), 
> because while git-am will pick them up from the email headers, that is 
> only true if the emails don't get passed around and commented upon by 
> others.

Okay.

Thanks,
Dscho
