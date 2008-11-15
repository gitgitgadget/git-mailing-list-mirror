From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git to libgit2 code relicensing
Date: Fri, 14 Nov 2008 21:00:39 -0800
Message-ID: <20081115050039.GC2932@spearce.org>
References: <491DE6CC.6060201@op5.se> <alpine.LFD.2.00.0811141512480.3468@nehalem.linux-foundation.org> <20081114234658.GA2932@spearce.org> <20081115043051.GA21608@linode.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Sat Nov 15 06:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1DLH-0002Ci-9r
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 06:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbYKOFAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 00:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbYKOFAl
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 00:00:41 -0500
Received: from george.spearce.org ([209.20.77.23]:39365 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbYKOFAk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 00:00:40 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id C514F381FF; Sat, 15 Nov 2008 05:00:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081115043051.GA21608@linode.davidb.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101045>

David Brown <git@davidb.org> wrote:
> On Fri, Nov 14, 2008 at 03:46:58PM -0800, Shawn O. Pearce wrote:
>
>> In addition to the permissions in the GNU General Public License,
>> the authors give you unlimited permission to link the compiled
>> version of this file into combinations with other programs,
>> and to distribute those combinations without any restriction
>> coming from the use of this file.  (The General Public License
>> restrictions do apply in other respects; for example, they cover
>> modification of the file, and distribution when not linked into
>> a combined executable.)
>
> Is this license intended to allow static linking but forbid dynamic
> linking into a non-GPL program?  It depends on how you interpret
> "linked into a combined executable", but that sounds like it
> intentionally excludes the dynamic case.

I don't know.  When I read it myself I assumed dynamic linking
would also be OK.  This is why I prefer programs; I don't read
legalese so I can't quite figure out what the statement means.
At least with C its a little less vague.  ;-)

-- 
Shawn.
