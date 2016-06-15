From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add --remote option to git-clone.
Date: Fri, 2 Feb 2007 00:29:37 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702020028540.18776@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070201220122.GF17617@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Fri Feb 02 00:29:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HClNF-0000rT-0n
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 00:29:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422892AbXBAX3p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 18:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422893AbXBAX3p
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 18:29:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:45582 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422892AbXBAX3o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 18:29:44 -0500
Received: (qmail invoked by alias); 01 Feb 2007 23:29:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 02 Feb 2007 00:29:43 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070201220122.GF17617@mellanox.co.il>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38429>

Hi,

would this option not be better named "--branch"? Of course, you'd have to 
support this, too:

	$ git clone --branch topic1 --branch topic2 git://...

Ciao,
Dscho
