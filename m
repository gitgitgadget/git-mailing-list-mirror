From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 12:44:25 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121125174425.GC32394@thyrsus.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <50B1F684.5020805@alum.mit.edu>
 <20121125105707.GA25212@thyrsus.com>
 <alpine.DEB.2.02.1211250344360.32333@nftneq.ynat.uz>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Sun Nov 25 18:45:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcgH5-0006bI-5r
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 18:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269Ab2KYRpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 12:45:19 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:43263
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235Ab2KYRpS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 12:45:18 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 0166B4065F; Sun, 25 Nov 2012 12:44:25 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1211250344360.32333@nftneq.ynat.uz>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210378>

David Lang <david@lang.hm>:
> You may think that C and Bash are poor choices, but that is what the
> community is familar with.

I don't think C is a "poor" choice.  bash, on the other hand...so
many dependencies on tool quirks!

> You are far from the first person to say that git should be
> re-written (or at least large portions of it) in the
> language-of-the-day, and you won't be the last (even, or especially
> if it does get re-written in Python ;-)

I think you're overinterpreting.  Trying for One Big Rewrite in language
X is almost never a good idea and I don't advocate it.  Encouraging people
to migrate pieces as they feel motivated and resdy is a different matter.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
