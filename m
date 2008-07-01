From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 13/14] git-commit-tree: make it usable from other
 builtins
Date: Tue, 1 Jul 2008 06:07:28 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807010606470.9925@racer>
References: <666ec9b342a0c3254ae8f917d5bd2dea36314f08.1214878711.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Olivier Marin <dkr@freesurf.fr>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jul 01 07:10:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDY8B-0000DT-GJ
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 07:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbYGAFJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 01:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbYGAFJW
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 01:09:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:33050 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750826AbYGAFJV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 01:09:21 -0400
Received: (qmail invoked by alias); 01 Jul 2008 05:09:19 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp066) with SMTP; 01 Jul 2008 07:09:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Yv24oKldYywRvJLxExG1tiv8VS3scZHfcWsIETY
	3t4qQmO9FxICnI
X-X-Sender: gene099@racer
In-Reply-To: <666ec9b342a0c3254ae8f917d5bd2dea36314f08.1214878711.git.vmiklos@frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87002>

Hi,

On Tue, 1 Jul 2008, Miklos Vajna wrote:

> I did it this way to avoid an unnecessary conflict with Dscho's recent 
> patch to commit-tree (ef98c5c).

Oh, sorry!

Funnily enough, I committed and tested this change in my clone of 
builtin-merge before I realized that I am in the wrong directory ;-)

Ciao,
Dscho
