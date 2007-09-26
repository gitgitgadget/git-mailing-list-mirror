From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Create .dotest-merge after validating options.
Date: Wed, 26 Sep 2007 02:38:02 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709260237350.28395@racer.site>
References: <1190770213-8651-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Wed Sep 26 03:39:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaLrx-0003v7-Mm
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 03:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbXIZBjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 21:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752690AbXIZBjJ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 21:39:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:58538 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752092AbXIZBjI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 21:39:08 -0400
Received: (qmail invoked by alias); 26 Sep 2007 01:39:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 26 Sep 2007 03:39:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wPRdV4QAwLUU4EmgSyqLlF4AfuW47skU6DiRL50
	G3tuTvCNQtKuKH
X-X-Sender: gene099@racer.site
In-Reply-To: <1190770213-8651-1-git-send-email-kraai@ftbfs.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59205>

Hi,

On Tue, 25 Sep 2007, Matt Kraai wrote:

> Creating .dotest-merge before validating the options prevents both 
> --continue and --interactive from working if the options are invalid, so 
> only create it after validating the options.

Looks very reasonable to me.

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Ciao,
Dscho
