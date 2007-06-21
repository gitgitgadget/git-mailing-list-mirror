From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Strange diff behavior?
Date: Thu, 21 Jun 2007 02:13:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706210212060.4059@racer.site>
References: <31e9dd080706201802h9dcbffawd82575d09e082155@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jason Sewall <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 03:13:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1BEd-00088I-Rs
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 03:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245AbXFUBNP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 21:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752690AbXFUBNP
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 21:13:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:58162 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752678AbXFUBNO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 21:13:14 -0400
Received: (qmail invoked by alias); 21 Jun 2007 01:13:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 21 Jun 2007 03:13:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19onhYWpw5o0nW3F+eZYcnhK61CvPvRl3V0RBLtog
	eMDzNqfnvfwcwf
X-X-Sender: gene099@racer.site
In-Reply-To: <31e9dd080706201802h9dcbffawd82575d09e082155@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50579>

Hi,

On Wed, 20 Jun 2007, Jason Sewall wrote:

> It seems like every change listed after the first one is meaningless.

Just a guess: core.autocrlf=true?

Ciao,
Dscho
