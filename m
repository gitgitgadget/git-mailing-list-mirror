From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: git sequencer prototype
Date: Wed, 30 Jul 2008 14:14:58 +0200
Message-ID: <20080730121458.GB8767@leksak.fem-net>
References: <1217049644-8874-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807261617010.26810@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 30 14:16:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOAbD-0007Vv-2D
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 14:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291AbYG3MPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 08:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755924AbYG3MPF
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 08:15:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:59591 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755291AbYG3MPB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 08:15:01 -0400
Received: (qmail invoked by alias); 30 Jul 2008 12:14:59 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp055) with SMTP; 30 Jul 2008 14:14:59 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/Qd3EhPuLQBxca+NND3l4eRjLtENQYRaVHU59iIW
	pE8wZe6FSOXGo1
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KOAa2-0002ZA-HA; Wed, 30 Jul 2008 14:14:58 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807261617010.26810@eeepc-johanness>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90771>

Hi,

Johannes Schindelin wrote:
> > In the last patchset I mentioned the issue, that the prototype is slow
> > as hell.  I know some bottlenecks, but I have not even tried to change
> > that, because this is no issue for the builtin.
> 
> Why is it no issue for the builtin?  Is it so much different from the 
> prototype?

As Sverre pointed out and as my "experiments" tried to show: the builtin
is just fast ;-)

> Personally, I think if the prototype is so much slower, there is no sense 
> applying it into git.git,

Right.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
