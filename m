From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git sequencer prototype
Date: Wed, 30 Jul 2008 16:07:49 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807301607070.3486@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1217049644-8874-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807261617010.26810@eeepc-johanness> <20080730121458.GB8767@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jul 30 16:10:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOCMH-0002AB-MB
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 16:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759103AbYG3OHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 10:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758597AbYG3OHw
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 10:07:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:33417 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757853AbYG3OHv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 10:07:51 -0400
Received: (qmail invoked by alias); 30 Jul 2008 14:07:50 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp017) with SMTP; 30 Jul 2008 16:07:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX193XTwijQl3hQI90LjgEfiUeJO5hUPdXCIs5w9P61
	zfYCr3naYUav4g
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20080730121458.GB8767@leksak.fem-net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90794>

Hi,

On Wed, 30 Jul 2008, Stephan Beyer wrote:

> Johannes Schindelin wrote:
> >
> > > In the last patchset I mentioned the issue, that the prototype is 
> > > slow as hell.  I know some bottlenecks, but I have not even tried to 
> > > change that, because this is no issue for the builtin.
> > 
> > Why is it no issue for the builtin?  Is it so much different from the 
> > prototype?
> 
> As Sverre pointed out and as my "experiments" tried to show: the builtin
> is just fast ;-)

So why is it just so fast?  Does it do things completely different than 
the shell prototype you presented?

Still puzzled,
Dscho
