From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: adding file by absolute name -- problem
Date: Mon, 23 Apr 2007 16:23:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704231622160.8822@racer.site>
References: <f36b08ee0704230239i4892983q4feb4a1872a320ea@mail.gmail.com> 
 <Pine.LNX.4.64.0704231215370.8822@racer.site>
 <1b46aba20704230639k56fc1839qcad38f1e5ee0e238@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Yakov Lerner <iler.ml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 16:23:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfzSL-0000Z2-5J
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 16:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbXDWOXu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 10:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753164AbXDWOXu
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 10:23:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:56110 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751042AbXDWOXt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 10:23:49 -0400
Received: (qmail invoked by alias); 23 Apr 2007 14:23:48 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp027) with SMTP; 23 Apr 2007 16:23:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19e/H974x5emDTBizA5BGTkX4nD0A1OPWibE30eMe
	x6ZT4YlLtGocqb
X-X-Sender: gene099@racer.site
In-Reply-To: <1b46aba20704230639k56fc1839qcad38f1e5ee0e238@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45324>

Hi,

On Mon, 23 Apr 2007, Carlos Rica wrote:

> Since it is by design, a posible solution could be support an optional
> parameter to give the program the path of the directory (something as
> --dir /a/b).

:-)

You mean something like

	git --git-dir /path/to/repo add relative/path/to/file

Hmm?

Ciao,
Dscho
