From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: restriction of pulls
Date: Fri, 9 Feb 2007 15:54:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702091554160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702091149.12462.duelli@melosgmbh.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Christoph Duelli <duelli@melosgmbh.de>
X-From: git-owner@vger.kernel.org Fri Feb 09 15:54:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFX9B-000638-DC
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 15:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946488AbXBIOym (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 09:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946497AbXBIOym
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 09:54:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:38629 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1946488AbXBIOyl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 09:54:41 -0500
Received: (qmail invoked by alias); 09 Feb 2007 14:54:40 -0000
X-Provags-ID: V01U2FsdGVkX19JcQMaz9BJLcG7JnmK4TRwLWbbJGLFM6dAA490dP
	KCQg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702091149.12462.duelli@melosgmbh.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39180>

Hi,

On Fri, 9 Feb 2007, Christoph Duelli wrote:

> Is it possible to restrict a chechout, clone or a later pull to some 
> subdirectory of a repository?

No. In git, a revision really is a revision, and not a group of file 
revisions.

Ciao,
Dscho
