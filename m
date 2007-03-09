From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: git's is_inside_git_dir too strict?
Date: Fri, 9 Mar 2007 13:00:01 +0100
Message-ID: <20070309120001.GA32300@moooo.ath.cx>
References: <fcaeb9bf0703060741l7cbfd0f3ue443730176606db6@mail.gmail.com> <Pine.LNX.4.63.0703062232570.22628@wbgn013.biozentrum.uni-wuerzburg.de> <fcaeb9bf0703070417n5d3fb168jc7efd4642ad38c92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 13:00:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPdlh-0005hl-0a
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 13:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766994AbXCIMAM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 07:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767000AbXCIMAL
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 07:00:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:44168 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1766994AbXCIMAK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 07:00:10 -0500
Received: (qmail invoked by alias); 09 Mar 2007 12:00:07 -0000
Received: from pD9EBB8D2.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.184.210]
  by mail.gmx.net (mp044) with SMTP; 09 Mar 2007 13:00:07 +0100
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19OlVouEjpODUvXALSUwaGkKtmafFMg6tvrxpjfr+
	IN8AO6zNXawEZD
Mail-Followup-To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0703070417n5d3fb168jc7efd4642ad38c92@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41794>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> By the way, is it plausible to add --git-workdir option to specify
> working directory? With that option, I won't need to chdir to the
> working directory, run git commands and chdir back.

http://article.gmane.org/gmane.comp.version-control.git/38382
Since I did not need this feature that much and no one replied that
there is any interest I did not look any further into it.
