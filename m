From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Re: Re: Change in cvsps maintainership, abd a --fast-export
 option
Date: Sun, 23 Dec 2012 20:57:24 +0100
Message-ID: <20121223195724.GA29354@book-mint>
References: <20121220215638.E54BC44119@snark.thyrsus.com>
 <50D4199C.6000002@alum.mit.edu>
 <20121221104437.GA5244@thyrsus.com>
 <20121222034751.GA11635@book-mint>
 <20121222062118.GA31331@thyrsus.com>
 <20121222130452.GB13549@book-mint>
 <20121222141519.GA2080@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sun Dec 23 20:57:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmrgC-0008Mp-Ix
	for gcvg-git-2@plane.gmane.org; Sun, 23 Dec 2012 20:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211Ab2LWT5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2012 14:57:30 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.32]:53806 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab2LWT53 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2012 14:57:29 -0500
Received: from [85.16.214.228] (helo=localhost)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Tmrfp-0003wN-3P; Sun, 23 Dec 2012 20:57:25 +0100
Content-Disposition: inline
In-Reply-To: <20121222141519.GA2080@thyrsus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212089>

On Sat, Dec 22, 2012 at 09:15:19AM -0500, Eric S. Raymond wrote:
> sr@snark:~/WWW/cvsps/fixrepos$ git clone http://repo.or.cz/w/cvsps-hv.git
> Cloning into 'cvsps-hv'...
> fatal: http://repo.or.cz/w/cvsps-hv.git/info/refs not valid: is this a git repository?

That link refers to the webpage of the repository. The clone url is found on
that page. Use this address for cloning:

	git://repo.or.cz/cvsps-hv.git

Cheers Heiko
