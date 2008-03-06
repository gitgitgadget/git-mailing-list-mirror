From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: wierd error, cant push my changes back
Date: Thu, 6 Mar 2008 12:32:38 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803061232090.15786@racer.site>
References: <e26d18e40803060009r6f8dd313qcc7b3472a5d771ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Anatoly Yakovenko <aeyakovenko@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 12:33:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXELc-0007HE-LJ
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 12:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbYCFLci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 06:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbYCFLci
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 06:32:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:39751 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751507AbYCFLch (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 06:32:37 -0500
Received: (qmail invoked by alias); 06 Mar 2008 11:32:36 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp028) with SMTP; 06 Mar 2008 12:32:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19gxUB8Q2FgtXn0wZOVTrOjZ5dOQ9i8/eDvO9IH4r
	r1a8OxrXwQAkK+
X-X-Sender: gene099@racer.site
In-Reply-To: <e26d18e40803060009r6f8dd313qcc7b3472a5d771ad@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76375>

Hi,

On Thu, 6 Mar 2008, Anatoly Yakovenko wrote:

> error: unable to write sha1 filename
> ./objects/81/19095e4e1996e5fde8212f27caf0a8a6d42167: Permission denied

You might want to find out why the permission was denied to write into 
that file.

Hth,
Dscho
