From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [REGRESSION ?] git-remote "--mirror" option is not integrated
 in 1.5.3.7
Date: Mon, 3 Dec 2007 16:23:23 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712031622470.27959@racer.site>
References: <31e679430712030532p12e1f0f5x7e10bd0a1fdf9ef9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 17:24:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzE5X-0001wT-Cl
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 17:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbXLCQXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 11:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbXLCQXq
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 11:23:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:55732 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750962AbXLCQXq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 11:23:46 -0500
Received: (qmail invoked by alias); 03 Dec 2007 16:23:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 03 Dec 2007 17:23:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/QIT0F+mHQpSFT4zsRcmaANjbPnD1iMW2xsXVK1p
	dkWZPzz8eRAb+e
X-X-Sender: gene099@racer.site
In-Reply-To: <31e679430712030532p12e1f0f5x7e10bd0a1fdf9ef9@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66923>

Hi,

On Mon, 3 Dec 2007, Felipe Balbi wrote:

> I've using git-remote --mirror mode for while right now but I saw it's 
> not integrated in v.1.5.3.7, is this on purpose? I can still get it if I 
> compile recent git's head "36863af16e91aebc87696209f4f4780cf4c4059f".

AFAICT there are problems with --prune.  That might be a reason that it is 
not in 1.5.3.7 (haven't checked if that's even the case, though).

Ciao,
Dscho
