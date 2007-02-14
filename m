From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Wed, 14 Feb 2007 16:53:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702141653160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org>
 <7v7iumx7hu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
 <7v8xf1uxme.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702132127330.3604@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702141208020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702140742280.3604@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 16:53:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHMRx-0004zO-Cq
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 16:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbXBNPxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 10:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbXBNPxi
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 10:53:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:47338 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932345AbXBNPxi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 10:53:38 -0500
Received: (qmail invoked by alias); 14 Feb 2007 15:53:36 -0000
X-Provags-ID: V01U2FsdGVkX19zny5rX3Jzy9uYg0ZXbOD+dI04kZ+30BWBo0eXoq
	RC8w==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702140742280.3604@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39660>

Hi,

On Wed, 14 Feb 2007, Linus Torvalds wrote:

> On Wed, 14 Feb 2007, Johannes Schindelin wrote:
> > 
> > Last time I checked, the text files never had lines longer than 200 
> > characters (I chose this intentionally large). So, it might be a good 
> > heuristic to check the maximal line length,
> 
> No, some broken editor programs and people use "flowing text" files, where 
> a newline is actually a _paragraph_ end.

Good point.

Ciao,
Dscho
