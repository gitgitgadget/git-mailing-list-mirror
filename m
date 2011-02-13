From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH 1/2] git-gui: fix deleting item from all_remotes
	variable
Date: Sun, 13 Feb 2011 14:47:53 +0100
Message-ID: <20110213134753.GC31986@book.hvoigt.net>
References: <20110212164344.GA19433@book.hvoigt.net> <AANLkTi=hY1XpBNfhNDfM8kwgnitQXN-97mM-dkhCpTac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@googlemail.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Pat Thoyts <patthoyts@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 14:48:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PocIz-0001ZF-G9
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 14:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555Ab1BMNr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 08:47:57 -0500
Received: from darksea.de ([83.133.111.250]:34769 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754350Ab1BMNrz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 08:47:55 -0500
Received: (qmail 13964 invoked from network); 13 Feb 2011 14:47:53 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 13 Feb 2011 14:47:53 +0100
Content-Disposition: inline
In-Reply-To: <AANLkTi=hY1XpBNfhNDfM8kwgnitQXN-97mM-dkhCpTac@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166666>

Hi Pat,

On Sun, Feb 13, 2011 at 01:20:14PM +0000, Pat Thoyts wrote:
> This fix is good and clearly resolves a bug in the tcl code --
> however, what does it actually fix in the application? It looks like
> removing a remote works anyway even though this variable is not being
> updated.

I do not know the other implications but I needed this fix for a patch I
wrote. I did not send it because it is quite long and I wanted to wait
until my other patches are ok so you do not have to review too much.
But since you asked I will reply with the two patches to this email.

Cheers Heiko
