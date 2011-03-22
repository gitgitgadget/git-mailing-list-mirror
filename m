From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Summer of Code project ideas
Date: Tue, 22 Mar 2011 21:31:57 +0100
Message-ID: <20110322203157.GA21163@book.hvoigt.net>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com> <20110303185918.GA18503@sigill.intra.peff.net> <AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com> <20110303203323.GA21102@sigill.intra.peff.net> <20110309174956.GA22683@sigill.intra.peff.net> <AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com> <20110309215841.GC4400@sigill.intra.peff.net> <m37hbx5ncw.fsf_-_@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	"J.H." <warthog9@eaglescrag.net>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 21:32:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q28FS-0002Ql-6T
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 21:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158Ab1CVUcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 16:32:03 -0400
Received: from darksea.de ([83.133.111.250]:51348 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755150Ab1CVUb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 16:31:59 -0400
Received: (qmail 12725 invoked from network); 22 Mar 2011 21:31:57 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 22 Mar 2011 21:31:57 +0100
Content-Disposition: inline
In-Reply-To: <m37hbx5ncw.fsf_-_@localhost.localdomain>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169773>

Hi,

On Thu, Mar 17, 2011 at 04:40:44PM -0700, Jakub Narebski wrote:
> * embedding graphical diff and graphical merge tool in git-gui, e.g. as
>   "git gui diff".  I think that we can use xxdiff; the license is 
>   compatibile.
> 
>   Pat and Shawn, is it something worth doing?  Does it look like a good
>   project for GSoC2011, or is it too small of a project for this?  Would
>   we be able to find mentor for this idea?
> 
> * splitting gitk, common library (Tcl/Tk bindings) for gitk and git-gui
> 
>   Pat and Paul, do you think it is right scope, or is it too large project
>   to put as an GSoC idea?

I would be interested in mentoring those projects. I do not know whether
we can reach consensus how to split up things. The last time we
discussed a possible approach[1] to share code between gitk and git gui
we did not reach one.

Cheers Heiko

[1] http://thread.gmane.org/gmane.comp.version-control.git/166663/focus=166695
