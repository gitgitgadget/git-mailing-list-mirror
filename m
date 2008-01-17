From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 18:18:22 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801171817340.5731@racer.site>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
 <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de>
 <6E1A0E9A-34D7-4D85-BD4B-CF56CE3927CA@simplicidade.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 19:19:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFZKo-0002JJ-Lj
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 19:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756192AbYAQSS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 13:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756304AbYAQSS2
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 13:18:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:38466 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756138AbYAQSS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 13:18:27 -0500
Received: (qmail invoked by alias); 17 Jan 2008 18:18:25 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp014) with SMTP; 17 Jan 2008 19:18:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/UvhwRGW/Wn65kx3HKenogOHgdjLg8nsQEqthF8
	pFUXqTmvnfEPNW
X-X-Sender: gene099@racer.site
In-Reply-To: <6E1A0E9A-34D7-4D85-BD4B-CF56CE3927CA@simplicidade.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70891>

Hi,

On Thu, 17 Jan 2008, Pedro Melo wrote:

> On Jan 17, 2008, at 6:09 PM, Mark Junker wrote:
>
> > IMHO it would be the best solution when git stores all string meta 
> > data in UTF-8 and converts it to the target systems file system 
> > encoding. That would fix all those problems with different locales and 
> > file system encodings ...
> 
> +1.

-1.

It's just too arrogant to force your particular preferences down the 
throat of every git user.

Ciao,
Dscho
