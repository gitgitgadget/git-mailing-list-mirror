From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-cvsserver commit trouble (unexpected end of file in client)
Date: Wed, 3 Oct 2007 17:11:51 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710031711070.28395@racer.site>
References: <200710031348.50800.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jan Wielemaker <wielemak@science.uva.nl>
X-From: git-owner@vger.kernel.org Wed Oct 03 18:13:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id6qd-0004SR-Mv
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 18:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbXJCQNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 12:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbXJCQNL
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 12:13:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:48073 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753367AbXJCQNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 12:13:09 -0400
Received: (qmail invoked by alias); 03 Oct 2007 16:13:06 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp029) with SMTP; 03 Oct 2007 18:13:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jHzBeGdKjJ7bkg3RNIu6A5Rn8ezgj+IBDLQkkkw
	GeV1Wtnxjy5dIw
X-X-Sender: gene099@racer.site
In-Reply-To: <200710031348.50800.wielemak@science.uva.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59852>

Hi,

On Wed, 3 Oct 2007, Jan Wielemaker wrote:

> 2007-10-03 12:25:16 : WARN - error 1 pserver cannot find the current 
> HEAD of module

AFAIR we do not allow committing via pserver protocol.  Might that be your 
problem?

Ciao,
Dscho
