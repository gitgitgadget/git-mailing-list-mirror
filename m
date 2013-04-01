From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] tests: --valgrind=tool
Date: Mon, 1 Apr 2013 16:27:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1304011626180.1863@s15462909.onlinehome-server.info>
References: <cover.1364716452.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Thomas Rast <trast@inf.ethz.ch>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 01 16:27:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMfi9-0005FL-7U
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 16:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758240Ab3DAO1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 10:27:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:64132 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995Ab3DAO1U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 10:27:20 -0400
Received: from mailout-de.gmx.net ([10.1.76.19]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MOmOu-1UJuYC2pks-00648X for
 <git@vger.kernel.org>; Mon, 01 Apr 2013 16:27:18 +0200
Received: (qmail invoked by alias); 01 Apr 2013 14:27:18 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp019) with SMTP; 01 Apr 2013 16:27:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ac9gfXe4az5ugIkL2TM7znjjfxC4SX7s8Wmw5km
	rDex6AA55fjILr
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1364716452.git.trast@inf.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219686>

Hi Thomas,

On Sun, 31 Mar 2013, Thomas Rast wrote:

> From: Thomas Rast <trast@inf.ethz.ch>
> 
> I had a quick-and-dirty edit to t/valgrind/valgrind.sh in my trees
> while we did the index-pack investigation.  This small series is the
> "proper" way of achieving the same.
> 
> Thomas Rast (3):
>   t/README: --valgrind already implies -v
>   tests: parameterize --valgrind option
>   tests --valgrind: provide a mode without --track-origins

ACK, including PATCH 3/4 which wanted to be 4/3 :-)

Ciao,
Dscho
