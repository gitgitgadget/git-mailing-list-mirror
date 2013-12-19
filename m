From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: I have end-of-lifed cvsps
Date: Wed, 18 Dec 2013 23:06:04 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20131219040604.GA7654@thyrsus.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com>
 <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com>
 <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <52B02DFF.5010408@gmail.com>
 <CALKQrgf3kuXRpbWmSp_nk8+zDFYNzkgV+dSBHaBbmUkxqjaDUA@mail.gmail.com>
 <20131217145809.GC15010@thyrsus.com>
 <CALKQrgeegcsO7YVqEmQxD4=HfR4eitodAov0tEh7MRvBxtRKUA@mail.gmail.com>
 <20131217184724.GA17709@thyrsus.com>
 <52B2335D.2030607@alum.mit.edu>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 19 05:06:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtUsF-0003w5-S9
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 05:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719Ab3LSEGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 23:06:07 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:49775
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab3LSEGF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 23:06:05 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id D1FF2380488; Wed, 18 Dec 2013 23:06:04 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <52B2335D.2030607@alum.mit.edu>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239514>

Michael Haggerty <mhagger@alum.mit.edu>:
> If you haven't tried cvs2git yet, please start it up somewhere in the
> background.  It might take a while but it should have no trouble with
> your repos, and then you can compare the tools based on experience
> rather than speculation.

That would be a good thing.

Michael, in case you're wondering why I've continued to work on
cvs-fast-export when cvs2git exists, there are exactly two reasons:
(a) it's a whole lot faster on repos that aren't large enough to
demand multipass, and (b) the single-whole-dumpfile output makes it a
better reposurgeon front end.

> But the traffic on the cvs2svn/cvs2git mailing list has trailed off
> essentially to zero, so either the software is perfect already (haha) or
> most everybody has already converted.  Therefore I don't invest any
> significant time in that project these days.

Reasonable.  I'm doing this as a temporary break from working on GPSD.
I don't expect to be investing a lot of time in it after I get it
to a 1.0 state.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
