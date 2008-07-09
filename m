From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-rerere.txt: Mention rr-cache directory
Date: Wed, 9 Jul 2008 02:25:45 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807090225050.5277@eeepc-johanness>
References: <1215562653-5043-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jul 09 02:26:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGNVw-00075z-Lx
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 02:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbYGIAZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 20:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbYGIAZe
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 20:25:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:52130 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751482AbYGIAZe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 20:25:34 -0400
Received: (qmail invoked by alias); 09 Jul 2008 00:25:32 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp059) with SMTP; 09 Jul 2008 02:25:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+f2qxPixifwpRyocpnosNGQW1HUn2or3b7lrXPP5
	zQDjwP2lVFlwec
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1215562653-5043-1-git-send-email-s-beyer@gmx.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87818>

Hi,

On Wed, 9 Jul 2008, Stephan Beyer wrote:

> If a user reads the rerere documentation, he or she is not told to 
> create the $GIT_DIR/rr-cache directory to be able to use git-rerere. 

Is it?  The config setting is not enough?  Then that is a bug, and should 
not be blessed by a bug in the documentation.

Ciao,
Dscho
