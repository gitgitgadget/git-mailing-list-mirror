From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] just an (stupid) idea when creating a new branch
Date: Sun, 9 Jul 2006 21:09:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607092106530.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060708155547.73054.qmail@web25814.mail.ukl.yahoo.com>
 <e8p8pj$jk3$2@sea.gmane.org> <Pine.LNX.4.63.0607090011000.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <e8rcu5$je5$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 21:09:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzeer-0003xb-Qm
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 21:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161059AbWGITJb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 15:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161060AbWGITJb
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 15:09:31 -0400
Received: from mail.gmx.net ([213.165.64.21]:33219 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161059AbWGITJa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 15:09:30 -0400
Received: (qmail invoked by alias); 09 Jul 2006 19:09:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 09 Jul 2006 21:09:29 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e8rcu5$je5$2@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23561>

Hi,

On Sun, 9 Jul 2006, Jakub Narebski wrote:

> By the way, did this series of patches (adding support for branch and
> remotes configuretion to config file) made into 'next', 'master' or even
> 'pu', or after some discussion it stalled?

The latter. Some parts are there (the remote configuration made it in 
AFAIK) but things like the default remote(s) to fetch / push are not.

Ciao,
Dscho
