From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] adding support for md5
Date: Fri, 18 Aug 2006 12:56:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608181255060.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com>
 <44E59BF6.2070909@sinister.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Rientjes <rientjes@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 12:56:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE21R-0007bX-AP
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 12:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWHRK4O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 06:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWHRK4O
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 06:56:14 -0400
Received: from mail.gmx.de ([213.165.64.20]:59550 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751366AbWHRK4N (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 06:56:13 -0400
Received: (qmail invoked by alias); 18 Aug 2006 10:56:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 18 Aug 2006 12:56:12 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Trekie <trekie@sinister.cz>
In-Reply-To: <44E59BF6.2070909@sinister.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25649>

Hi,

On Fri, 18 Aug 2006, Trekie wrote:

> I'd like to point out that while finding collision for SHA1 according to
> the Wikipedia needs 2^63 operations and AFAIK no collision has been
> found yet, finding collision for MD5 can be achieved in a minute and
> less (see http://cryptography.hyperlink.cz/2006/tunnels.pdf for details).

SHA1 has been broken (collisions have been found):

http://www.schneier.com/blog/archives/2005/02/sha1_broken.html

Ciao,
Dscho
