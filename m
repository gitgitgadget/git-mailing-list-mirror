From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: abbreviated commands
Date: Sun, 25 Feb 2007 18:47:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702251846550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45E1CAAB.3030203@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff Rose <rosejn@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 25 18:47:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLNTD-0002VK-6l
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 18:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbXBYRrd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 12:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbXBYRrd
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 12:47:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:55699 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965044AbXBYRrc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 12:47:32 -0500
Received: (qmail invoked by alias); 25 Feb 2007 17:47:31 -0000
X-Provags-ID: V01U2FsdGVkX1+nI21KbqGn1227elvHAH9ZHNT8KJ2s0K104VFHce
	Rs9w==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45E1CAAB.3030203@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40562>

Hi,

On Sun, 25 Feb 2007, Jeff Rose wrote:

> Has there been discussion of adding abbreviated command names to git? It
> would be nice to be able to type the standard abbreviations used by many vcs,
> for example:
> 
> ci -> commit
> co -> checkout

$ git config --global alias.ci commit
$ git config --global alias.co checkout

Fixed!

Hth,
Dscho
