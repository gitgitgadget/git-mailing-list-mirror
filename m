From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Continue git clone after interruption
Date: Mon, 17 Aug 2009 14:31:51 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171430010.4991@intel-tinevez-2-302>
References: <1250509342.2885.13.camel@cf-48>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tomasz Kontusz <roverorna@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 14:32:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md1OP-0002Yp-NK
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 14:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718AbZHQMbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 08:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752375AbZHQMbw
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 08:31:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:47990 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753693AbZHQMbv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 08:31:51 -0400
Received: (qmail invoked by alias); 17 Aug 2009 12:31:52 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp048) with SMTP; 17 Aug 2009 14:31:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18DdkVn9zoDIgtKi3/zdCuPbt7SMXxqyjo+xXBr3f
	NxM9my8Q5ERMvg
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1250509342.2885.13.camel@cf-48>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126168>

Hi,

On Mon, 17 Aug 2009, Tomasz Kontusz wrote:

> is anybody working on making it possible to continue git clone after 
> interruption? It would be quite useful for people with bad internet 
> connection (I was downloading a big repo lately, and it was a bit 
> frustrating to start it over every time git stopped at ~90%).

Unfortunately, we did not have enough GSoC slots for the project to allow 
restartable clones.

There were discussions about how to implement this on the list, though.

Ciao,
Dscho
