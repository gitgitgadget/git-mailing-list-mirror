From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: gitpacker progress report and a question
Date: Thu, 15 Nov 2012 18:05:35 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121115230535.GB25000@thyrsus.com>
References: <20121115212818.GA21558@thyrsus.com>
 <877E14DE-313D-4863-980B-13D077230F7F@quendi.de>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Horn <postbox@quendi.de>
X-From: git-owner@vger.kernel.org Fri Nov 16 00:06:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ8Vs-0004RQ-Ex
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 00:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988Ab2KOXGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 18:06:10 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:59185
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab2KOXGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 18:06:09 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 53B2A4065B; Thu, 15 Nov 2012 18:05:35 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <877E14DE-313D-4863-980B-13D077230F7F@quendi.de>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209852>

Max Horn <postbox@quendi.de>:
> > I'm still looking for a better name for it and would welcome suggestions.
> 
> Isn't "gitar" the kind of natural choice? ;) At least for a stand-alone tool, not for a git subcommand.

I just renamed it git-weave.  I keep talking about tarballs because I keep
thinking about using it archeologically on projects that only exist as
tarball sequences, but the tool actually oacks and unpacks *file tree*
sequences.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
