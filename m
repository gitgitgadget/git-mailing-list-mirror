From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 15:57:20 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801171556170.5731@racer.site>
References: <478E1FED.5010801@web.de> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org>
 <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <4C21C1AF-40B0-48C7-8F0E-2DAF3C5FAB29@sb.org>
 <46a038f90801162051s5ce40abcm623599269943a24@mail.gmail.com> <ACDB98F4-178C-43C3-99C4-A1D03DD6A8F5@sb.org> <A915BECA-A486-477B-A07D-D1033E44DCBD@adacore.com> <AD012876-3B4A-41EE-8CCB-F60D5C812903@gmail.com> <17846BF5-1215-4C28-8BBC-2C745A053156@wincent.com>
 <15C01F6E-052B-401C-B189-833CBAB20787@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wincent Colaiuta <win@wincent.com>,
	Mitch Tishmack <mitcht.git@gmail.com>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 16:57:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFX7s-0008La-4N
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 16:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbYAQP50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 10:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbYAQP50
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 10:57:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:44064 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751551AbYAQP50 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 10:57:26 -0500
Received: (qmail invoked by alias); 17 Jan 2008 15:57:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 17 Jan 2008 16:57:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+LIq1hXr6LHlSIggXVDA0FPVeAk/RCwIRFg7iw0B
	Aaon4LjY8osMRl
X-X-Sender: gene099@racer.site
In-Reply-To: <15C01F6E-052B-401C-B189-833CBAB20787@sb.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70870>

Hi,

On Thu, 17 Jan 2008, Kevin Ballard wrote:

> On Jan 17, 2008, at 5:22 AM, Wincent Colaiuta wrote:
> 
> > While it's a nice workaround, it really is just that (a workaround) 
> > because performance will be suboptimal in a repository running on a 
> > disk image (and many of switched to Git because of its speed).
> 
> Not only is it suboptimal, it's also not acceptable, plain and simple.

If it's not acceptable, do something about it (and I don't mean writing 50 
emails). If you don't want to do something about it, I have to assume that 
you accept it as-is.

Ciao,
Dscho
