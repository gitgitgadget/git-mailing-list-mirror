From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: should git push . from:to work?
Date: Thu, 1 Feb 2007 16:00:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702011559100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070201145659.GA30716@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Thu Feb 01 16:01:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCdRF-0004HZ-0m
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 16:01:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422917AbXBAPAy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 10:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422915AbXBAPAy
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 10:00:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:55052 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422912AbXBAPAx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 10:00:53 -0500
Received: (qmail invoked by alias); 01 Feb 2007 15:00:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 01 Feb 2007 16:00:51 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070201145659.GA30716@mellanox.co.il>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38359>

Hi,

On Thu, 1 Feb 2007, Michael S. Tsirkin wrote:

> Should I not be able to use . as a URL?
> git push seems to think . is a remote, not a URL:

You seem to be infected by the less-than-intuitive
"git pull ."-makes-perfect-sense camp.

Why not just do "git branch to from"?

Ciao,
Dscho
