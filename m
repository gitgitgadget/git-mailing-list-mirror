From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Fri, 8 Feb 2008 22:34:55 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802082234170.11591@racer.site>
References: <200802081828.43849.kendy@suse.cz> <alpine.LSU.1.00.0802081905580.11591@racer.site> <foihu9$110$1@ger.gmane.org> <alpine.LSU.1.00.0802082151570.11591@racer.site> <20080208220356.GA22064@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 23:36:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNbpE-0005NS-BQ
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 23:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763863AbYBHWey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 17:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763847AbYBHWex
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 17:34:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:57444 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763823AbYBHWew (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 17:34:52 -0500
Received: (qmail invoked by alias); 08 Feb 2008 22:34:49 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp019) with SMTP; 08 Feb 2008 23:34:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18BCfhKPDcBvYXW6zAyRFB/g/6ztCa1ntON192ve7
	Xwo42rvhd10fwa
X-X-Sender: gene099@racer.site
In-Reply-To: <20080208220356.GA22064@glandium.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73166>

Hi,

On Fri, 8 Feb 2008, Mike Hommey wrote:

> Also note that the http transport uses info/http-alternates for http:// 
> urls. By the way, it doesn't make much sense that only http-fetch uses 
> it.

I think it does make sense: nobody else needs http-alternates.

Ciao,
Dscho
