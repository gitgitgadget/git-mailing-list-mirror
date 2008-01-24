From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] some systems don't have (and need) sys/select.h
Date: Thu, 24 Jan 2008 21:15:12 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801242114590.5731@racer.site>
References: <20080124183446.GJ30676@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 22:16:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI9Qr-00019m-JU
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 22:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757125AbYAXVP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 16:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757605AbYAXVP1
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 16:15:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:58391 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759060AbYAXVPY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 16:15:24 -0500
Received: (qmail invoked by alias); 24 Jan 2008 21:15:22 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp001) with SMTP; 24 Jan 2008 22:15:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ij6YxUfBil/AwGm2jbjXv4ZFKJ43480TdxU7Hhq
	UYTAbLaDDDKD+X
X-X-Sender: gene099@racer.site
In-Reply-To: <20080124183446.GJ30676@schiele.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71663>

Hi,

On Thu, 24 Jan 2008, Robert Schiele wrote:

> The select stuff is already in sys/time.h on on some systems like HP-UX 
> thus we should not include sys/select.h in that case.

Thank you very much,
Dscho
