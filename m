From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git to libgit2 code relicensing
Date: Fri, 14 Nov 2008 15:46:58 -0800
Message-ID: <20081114234658.GA2932@spearce.org>
References: <491DE6CC.6060201@op5.se> <alpine.LFD.2.00.0811141512480.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Nov 15 00:48:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L18Oi-0002Qn-Ey
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 00:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbYKNXrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 18:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbYKNXrA
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 18:47:00 -0500
Received: from george.spearce.org ([209.20.77.23]:55975 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbYKNXq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 18:46:59 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0DC49381FF; Fri, 14 Nov 2008 23:46:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811141512480.3468@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101035>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Fri, 14 Nov 2008, Andreas Ericsson wrote:
> > 
> > The license decided for libgit2 is "GPL with gcc exception".
> 
> What's the exact language? 
> 
> I'm likely ok with GPLv2 + libgcc-like exception, but I'd like to see the 
> exact one. I haven't followed the discussions much..

The language we are using in libgit2 is taken from libgcc, and is
as follows:

--8<--

 Note that the only valid version of the GPL as far as this project
 is concerned is _this_ particular version of the license (ie v2, not
 v2.2 or v3.x or whatever), unless explicitly otherwise stated.

 In addition to the permissions in the GNU General Public License,
 the authors give you unlimited permission to link the compiled
 version of this file into combinations with other programs,
 and to distribute those combinations without any restriction
 coming from the use of this file.  (The General Public License
 restrictions do apply in other respects; for example, they cover
 modification of the file, and distribution when not linked into
 a combined executable.)

----------------------------------------------------------------------

		    GNU GENERAL PUBLIC LICENSE
		       Version 2, June 1991

(... the rest of GPL v2 as it appears in git.git ...)

-- 
Shawn.
