From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] git-gui: Include version check and test for
	tearoff menu entry
Date: Thu, 17 Feb 2011 21:06:33 +0100
Message-ID: <20110217200633.GB93859@book.hvoigt.net>
References: <20110212164344.GA19433@book.hvoigt.net> <AANLkTi=hY1XpBNfhNDfM8kwgnitQXN-97mM-dkhCpTac@mail.gmail.com> <20110213134753.GC31986@book.hvoigt.net> <20110213135714.GE31986@book.hvoigt.net> <878vxilndt.fsf_-_@fox.patthoyts.tk> <20110214213148.GB50815@book.hvoigt.net> <8762smdtp0.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@gmail.com>,
	Pat Thoyts <patthoyts@googlemail.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Feb 17 21:06:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqA7d-0000h4-5P
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 21:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757875Ab1BQUGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 15:06:36 -0500
Received: from darksea.de ([83.133.111.250]:38934 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753002Ab1BQUGf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 15:06:35 -0500
Received: (qmail 28392 invoked from network); 17 Feb 2011 21:06:33 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 17 Feb 2011 21:06:33 +0100
Content-Disposition: inline
In-Reply-To: <8762smdtp0.fsf@fox.patthoyts.tk>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167111>

On Tue, Feb 15, 2011 at 12:31:39AM +0000, Pat Thoyts wrote:
> The tearoff's appear by default on unix but are disabled on windows as
> they are not normal gui features on that platform. Search for
> *Menu.tearOff 0 in git-gui.sh. Unix users can disable these using the
> .Xresources file adding *Menu.tearOff: 0

Thanks for the enlightenment. They are visible on my linux box. I
probably did never see them because I did not know they were there.

Cheers Heiko
