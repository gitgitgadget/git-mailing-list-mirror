From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: GSoC 2008 - Mentors Wanted!
Date: Wed, 5 Mar 2008 00:36:12 -0500
Message-ID: <20080305053612.GA8410@spearce.org>
References: <20080304051149.GS8410@spearce.org> <1b46aba20803041247h5cc64186q2abf7973372fd3ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 06:36:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWmJC-0001ju-Ph
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 06:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbYCEFgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 00:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbYCEFgR
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 00:36:17 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57043 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbYCEFgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 00:36:16 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWmIX-000078-FO; Wed, 05 Mar 2008 00:36:13 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 697A720FBAE; Wed,  5 Mar 2008 00:36:12 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1b46aba20803041247h5cc64186q2abf7973372fd3ef@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76172>

Carlos Rica <jasampler@gmail.com> wrote:
> On Tue, Mar 4, 2008 at 6:11 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> >  OK, enough, onto the project list!
> >
> >   http://git.or.cz/gitwiki/SoC2008Ideas
> 
> Gitster talked today about libification as a project for the GSoC
> (I mangled some comments, I accept complaints):

Thanks for pasting this chunk of the log Carlos.  I otherwise would
have certainly missed it.  Much appreciated.
 
> gitster> For the record, i've never said I am not interested in libification.
> 
> gitster> However.

[... lots of good gitster remarks removed for space ...]

After some reflection I agree with Junio.  As such I have moved the
libification project down the page to a new category, "Projects So
Large Your Head Will Spin".

> gitster> "rewrite git-submodule, put the repository for submodules in
> the superproject $GIT_DIR/modules, and use .git-file (currently in
> 'pu') to point at it", would be a good sized one.
...
> gitster> "teach 3-way fallback logic git-am has to git-apply".

These have gone onto the list as smaller, more average sized
projects.  Both are interesting and useful.  Thanks Junio.

-- 
Shawn.
