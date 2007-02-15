From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: User-wide ignore list
Date: Thu, 15 Feb 2007 12:59:44 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702151259270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <vpq4ppnvi1j.fsf@olympe.imag.fr> <200702151112.06729.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 15 12:59:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHfHB-0005NK-95
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 12:59:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965681AbXBOL7q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 06:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965702AbXBOL7q
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 06:59:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:50075 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965681AbXBOL7p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 06:59:45 -0500
Received: (qmail invoked by alias); 15 Feb 2007 11:59:44 -0000
X-Provags-ID: V01U2FsdGVkX1/EJ8YWz5DEo5KFfRycPu8AaLPs1OPDQ3aKmdTtuM
	pg3Q==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702151112.06729.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39823>

Hi,

On Thu, 15 Feb 2007, Andy Parkins wrote:

> On Thursday 2007 February 15 10:20, Matthieu Moy wrote:
> 
> > Is there a way to have a per-user ignore list in git?
> 
> Yep; in repository-layout.txt it says:
> 
> info/exclude::

Nope. This is per-repo, not per-user.

Hth,
Dscho
