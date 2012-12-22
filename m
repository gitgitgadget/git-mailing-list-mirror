From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Re: Change in cvsps maintainership, abd a --fast-export option
Date: Sat, 22 Dec 2012 09:04:53 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121222140453.GB375@thyrsus.com>
References: <20121220215638.E54BC44119@snark.thyrsus.com>
 <50D4199C.6000002@alum.mit.edu>
 <20121221104437.GA5244@thyrsus.com>
 <20121222034751.GA11635@book-mint>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Dec 22 15:05:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmPho-0001JT-Mq
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 15:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238Ab2LVOFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 09:05:18 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:52610
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab2LVOFR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 09:05:17 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 6D04E4411C; Sat, 22 Dec 2012 09:04:53 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20121222034751.GA11635@book-mint>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212048>

Heiko Voigt <hvoigt@hvoigt.net>:
> My commits can be found here:
> 
> 	http://repo.or.cz/w/cvsps-hv.git
> 
> I just quickly checked and it seems that it does not run cleanly on a
> modern Linux anymore. If it is of interest to you I can try to get it
> running again.

esr@snark:~/WWW/cvsps/fixrepos$ git clone http://repo.or.cz/w/cvsps-hv.git
Cloning into 'cvsps-hv'...
fatal: http://repo.or.cz/w/cvsps-hv.git/info/refs not valid: is this a git repository?

Doesn't seem to be a good day for cloning - I can't get Yann's repo either,
something about HEAD pointing to an invalid reference.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
