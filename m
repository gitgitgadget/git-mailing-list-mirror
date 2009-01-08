From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Funny: git -p submodule summary
Date: Thu, 8 Jan 2009 16:30:43 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901081629280.30769@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 16:31:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKwr5-0008PZ-2p
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 16:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757096AbZAHPaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 10:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbZAHPaF
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 10:30:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:47795 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756637AbZAHPaF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 10:30:05 -0500
Received: (qmail invoked by alias); 08 Jan 2009 15:30:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 08 Jan 2009 16:30:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/TFc8loYfTMcPyGbj0qUPLrl0hBD15QPU/RCFhgR
	f7tftuAmlZmXzv
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104925>

Hi,

On Thu, 8 Jan 2009, Johannes Schindelin wrote:

> Just try this with a submodule that has more changes than fit on a 
> screen:
> 
> 	$ git -p submodule summary
> 
> In my tests, it consistently fscks up my console.

Update: even if the changes do fit on a screen, the console is fscked up 
(I have to stty echo to get it back to normal).

Ciao,
Dscho
