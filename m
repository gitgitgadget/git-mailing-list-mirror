From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] valgrind: do not require valgrind 3.4.0 or newer
Date: Thu, 5 Feb 2009 21:20:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902052120130.7491@intel-tinevez-2-302>
References: <cover.1233858507u.git.johannes.schindelin@gmx.de> <b204f01577584835f1c0252c77ffbfab33442a79.1233858507u.git.johannes.schindelin@gmx.de> <20090205190059.GA16216@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 05 21:22:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVAjV-0005ux-Bb
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 21:21:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755579AbZBEUU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 15:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755011AbZBEUU3
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 15:20:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:36537 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755545AbZBEUU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 15:20:28 -0500
Received: (qmail invoked by alias); 05 Feb 2009 20:20:25 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp023) with SMTP; 05 Feb 2009 21:20:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19D4zBNPBxDl/wFAypDnjEOPuSIEdPb+pes25pw3B
	xWAgGogLZIsvXQ
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090205190059.GA16216@m62s10.vlinux.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108606>

Hi,

On Thu, 5 Feb 2009, Peter Baumann wrote:

> On Thu, Feb 05, 2009 at 07:34:27PM +0100, Johannes Schindelin wrote:
> > Valgrind 3.4.0 is pretty new, and even if --track-origins is a nice
> > feature, it is not the end of the world if that is not available.  So
> > play nice and use that option only when only an older version of
> > valgrind is available.
> 
> Reading the patch/the sentence above suggests that you actuallly ment: 
> 
> "So play nice and don't use that option when only an older version of
>  valgrind is available."

Yes.  How did you guess?

:-)

Ciao,
Dscho
