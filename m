From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] object name: introduce ':::<oneline prefix>' notation
Date: Fri, 23 Feb 2007 23:48:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702232347310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702231930290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Feb 23 23:48:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKjDX-0005xz-KI
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 23:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbXBWWsl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 17:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752211AbXBWWsk
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 17:48:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:40495 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752202AbXBWWsk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 17:48:40 -0500
Received: (qmail invoked by alias); 23 Feb 2007 22:48:39 -0000
X-Provags-ID: V01U2FsdGVkX19gfUk/Evlg+WLSF64DuyDna240OKafFZ+jXNrAZy
	ZGHA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0702231930290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40472>

Hi,

On Fri, 23 Feb 2007, Johannes Schindelin wrote:

> To name a commit, you can now say
> 
> 	git rev-parse ':::Initial revision of "git"'

Alex Riesen and Shawn Pearce suggested ":/" instead of ":::", to reflect 
the searching nature ("/" is the key to search in "less" output).

Comments?

Ciao,
Dscho
