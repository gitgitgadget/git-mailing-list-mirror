From: Olivier Galibert <galibert@pobox.com>
Subject: Re: [PATCH] Avoid C++ comments, use C comments instead
Date: Mon, 10 Jul 2006 22:24:12 +0200
Message-ID: <20060710202412.GA8189@dspnet.fr.eu.org>
References: <20060710065751.22902.43316.stgit@dv.roinet.com> <7vzmfhdhrf.fsf@assigned-by-dhcp.cox.net> <20060710094653.GA52962@dspnet.fr.eu.org> <Pine.LNX.4.63.0607101306030.29667@wbgn013.biozentrum.uni-wuerzburg.de> <20060710114117.GA62514@dspnet.fr.eu.org> <44B2A709.8020500@serice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 22:24:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G02Ir-0002Vl-Jj
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 22:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422804AbWGJUYO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 16:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422802AbWGJUYN
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 16:24:13 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:24334 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1422709AbWGJUYN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 16:24:13 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id 63DBEA3755; Mon, 10 Jul 2006 22:24:12 +0200 (CEST)
To: Paul Serice <paul@serice.net>
Content-Disposition: inline
In-Reply-To: <44B2A709.8020500@serice.net>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23647>

On Mon, Jul 10, 2006 at 02:14:17PM -0500, Paul Serice wrote:
> If you want to write portable code, you have to take into account
> different operating systems _and_ different compilers.  Writing your
> code for just a single compiler is almost as bad as writing your code
> for just a single operating system.

Hmmm, that was not so much about gcc-specific code than which kind of
C you want to code to, the one from 1973, the one from 1989 or the one
from 1999?  I personally don't have much sympathy for the OS vendors
giving you an older standard C compiler and selling you the up-to-date
one.

  OG.
