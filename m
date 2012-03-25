From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [GIT GUI PATCH 0/2] teach git gui to open the configured editor
Date: Sun, 25 Mar 2012 19:02:01 +0200
Message-ID: <20120325170200.GC38866@book.hvoigt.net>
References: <cover.1332523097.git.hvoigt@hvoigt.net> <CAKPyHN1SWLMKtWOPJ7NwcwuE2Kpwb84yz443P7R=vE4jSPFEOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 19:02:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBqpZ-0000We-K4
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 19:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756602Ab2CYRCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 13:02:04 -0400
Received: from darksea.de ([83.133.111.250]:50338 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754482Ab2CYRCD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 13:02:03 -0400
Received: (qmail 20279 invoked from network); 25 Mar 2012 19:02:01 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 25 Mar 2012 19:02:01 +0200
Content-Disposition: inline
In-Reply-To: <CAKPyHN1SWLMKtWOPJ7NwcwuE2Kpwb84yz443P7R=vE4jSPFEOw@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193873>

Hi,

On Fri, Mar 23, 2012 at 07:43:32PM +0100, Bert Wesarg wrote:
> On Fri, Mar 23, 2012 at 18:30, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > This patch series adds a new right click menuitem which allows the user
> > to open the configured editor with the currently viewed file. For some
> > popular editors it is also able to move the cursor close to the watched
> > line.
> 
> I once mentioned this in a patch I send ages ago:
> 
> <1289770869-11665-1-git-send-email-bert.wesarg@googlemail.com>
> 
> Look for the '[1]' reference.
> 
> I have done, what was discussed in this thread, but never send
> something to the list (maybe a private mail to Pat?), but you can have
> a look at my git-gui repo at [1]. The patch which implements this is
> bw/master~5 (a648f3a06 'git-gui: open file with GIT_EDITOR').

Interesting, I will give it a try once I find some time. So do you think
it is now ready for inclusion? I saw that you actually did a lot more
than me.

Cheers Heiko

> 
> Regards,
> Bert
> 
> [1] http://repo.or.cz/w/git-gui/bertw.git
