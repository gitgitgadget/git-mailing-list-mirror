From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Re: Change in cvsps maintainership, abd a --fast-export option
Date: Sat, 22 Dec 2012 09:17:10 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121222141710.GB2080@thyrsus.com>
References: <20121220215638.E54BC44119@snark.thyrsus.com>
 <50D4199C.6000002@alum.mit.edu>
 <20121221104437.GA5244@thyrsus.com>
 <20121222034751.GA11635@book-mint>
 <20121222140453.GB375@thyrsus.com>
 <CALWbr2zZFq_9qa+pTx3nYn+KFv61LrSMcNM4N1Xs5cmnr8teXg@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 15:17:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmPtf-0003oh-6I
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 15:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238Ab2LVORe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 09:17:34 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:52672
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab2LVORd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 09:17:33 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id A7DF04411C; Sat, 22 Dec 2012 09:17:10 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CALWbr2zZFq_9qa+pTx3nYn+KFv61LrSMcNM4N1Xs5cmnr8teXg@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212050>

Antoine Pelisse <apelisse@gmail.com>:
> > esr@snark:~/WWW/cvsps/fixrepos$ git clone http://repo.or.cz/w/cvsps-hv.git
> > Cloning into 'cvsps-hv'...
> > fatal: http://repo.or.cz/w/cvsps-hv.git/info/refs not valid: is this a git repository?
> 
> I guess 'w' means write, and you don't have write access. You should use
> 
>     http://repo.or.cz/r/cvsps-hv.git
> 
> instead. It works for me.

OK, that got it.  Looking at the tests now.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
