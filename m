From: Eric Raymond <esr@thyrsus.com>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Sat, 27 Mar 2010 05:19:38 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100327091938.GA4395@thyrsus.com>
References: <3d4937ff1003262240t6159d9c5sc9253f555c3aed1@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Michalske <smichalske@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 10:19:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvSBF-0000dm-1O
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 10:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413Ab0C0JTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 05:19:39 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:37155
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab0C0JTj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 05:19:39 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 2A69D475FEF; Sat, 27 Mar 2010 05:19:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <3d4937ff1003262240t6159d9c5sc9253f555c3aed1@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143323>

Steven Michalske <smichalske@gmail.com>:
> >    3.5 cmd_branch: Handle branching/ tagging
> 
> I'm torn on how the current system handles this,  I like all tags to
> be tags, and
> that if a tag had a branch like behavior (bad SVN users!), that a branch exists
> for it, with the tag pointing to its branches head.

Ah.  This sounds like s discussion, pre-dating my joining the list, of
my issue #2 about git-svn - not rendering unmodified tag directories as
git tags.  It's good that someone wants to rackle this seriously.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
