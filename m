From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to commit removed file?
Date: Sun, 31 Dec 2006 16:06:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612311605410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061231102444.GD26552@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 16:06:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H12Ga-0007R4-ET
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 16:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933190AbWLaPGM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 10:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933188AbWLaPGL
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 10:06:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:37896 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933184AbWLaPGK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 10:06:10 -0500
Received: (qmail invoked by alias); 31 Dec 2006 15:06:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 31 Dec 2006 16:06:09 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20061231102444.GD26552@mellanox.co.il>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35699>

Hi,

just a guess: putting "--" before the name of the removed file should 
work, no?

Ciao,
Dscho
