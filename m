From: carbonated beverage <ramune@net-ronin.org>
Subject: Re: cvs import error
Date: Sun, 11 Jun 2006 20:57:37 -0700
Message-ID: <20060612035737.GA16580@prophet.net-ronin.org>
References: <20060611234842.GA12713@prophet.net-ronin.org> <46a038f90606111731q34fe431fn36d751b387ab69a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 05:57:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpdYe-0006bq-SH
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 05:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWFLD5m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 23:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWFLD5m
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 23:57:42 -0400
Received: from S0106000ea6c7835e.no.shawcable.net ([70.67.106.153]:43916 "EHLO
	prophet.net-ronin.org") by vger.kernel.org with ESMTP
	id S1751267AbWFLD5l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jun 2006 23:57:41 -0400
Received: from ramune by prophet.net-ronin.org with local (Exim 3.35 #1 (Debian))
	id 1FpdYX-0004Jt-00; Sun, 11 Jun 2006 20:57:37 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90606111731q34fe431fn36d751b387ab69a9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21685>

On Mon, Jun 12, 2006 at 12:31:35PM +1200, Martin Langhoff wrote:
> After each attempt, the import leaves a .git file around. rm -fr .git
> before retrying... or just retry in a new directory every time ;-)
> 
> (... we should die with a more helpful message here...)

This error occurs on a fresh import attempt, unfortunately.

rm -rf'ing .git and doing an import again always fails at the exact same
spot with the above message.

-- DN
Daniel
