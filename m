From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Submodule on Debian breaks
Date: Thu, 15 May 2008 13:55:00 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805151354380.30431@racer>
References: <06D015DD-6F3B-4D2E-8305-BDD062F149E6@peterbengtson.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Peter Bengtson <peter@peterbengtson.com>
X-From: git-owner@vger.kernel.org Thu May 15 14:57:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwczy-00078e-2z
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 14:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbYEOMzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 08:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbYEOMzA
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 08:55:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:55929 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750868AbYEOMzA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 08:55:00 -0400
Received: (qmail invoked by alias); 15 May 2008 12:54:57 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp014) with SMTP; 15 May 2008 14:54:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18PTEE8tC8PXGCJwtBI/X0NFCe5tAnPPeNtwRu41Z
	TsqnVevQvcc4WV
X-X-Sender: gene099@racer
In-Reply-To: <06D015DD-6F3B-4D2E-8305-BDD062F149E6@peterbengtson.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82204>

Hi,

On Thu, 15 May 2008, Peter Bengtson wrote:

> We have problems cloning git repositories containing submodules on 
> Debian. Cloning them locally, on Debian, or on Mac OS X, works without a 
> hitch. Cloning them remotely from a Mac OS X repo server to a Mac OS X 
> client computer also works as expected, as does cloning repos without 
> submodules.
> 
> But as soon as a clone of a git repo containing a submodule on the 
> Debian machine is attempted from another computer, this happens:
> 
> >error: git-upload-pack: git-pack-objects died with error.

This is the remote git.  It is probably out of date.

Ciao,
Dscho
