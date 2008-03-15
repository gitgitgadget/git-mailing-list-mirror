From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: RFC: Use TranslationProject.org for git, gitk, git-gui
Date: Sat, 15 Mar 2008 00:59:13 -0400
Message-ID: <20080315045913.GD8410@spearce.org>
References: <Pine.LNX.4.64.0803140846270.25570@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Sat Mar 15 06:00:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaOUu-0000My-Pr
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 05:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbYCOE7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 00:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbYCOE7R
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 00:59:17 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57768 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbYCOE7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 00:59:16 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JaOUF-0007rT-2o; Sat, 15 Mar 2008 00:59:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C4A8F20FBAE; Sat, 15 Mar 2008 00:59:13 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0803140846270.25570@ds9.cixit.se>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77308>

[nb. updated subject to be more clear]

Peter Karlsson <peter@softwolves.pp.se> wrote:
> After submitting git-gui translations to a "mob" branch of a special
> repository, and not figuring out where to find and submit translation
> for gitk and main git itself, I would like to suggest adding these to
> Translation Project (<URL:http://translationproject.org/>) since there
> is alreay infrastructure for handling PO translations to multiple
> languages there.

This looks like an interesting project.  There certainly appears to
be a wider range of languages and backgrounds than we have active
on the git list doing translation work.

As a maintainer it looks easy for me to use.  Email in a POT file,
rsync back the PO files a week or two later.  But they ask to be
the sole source for PO files for a package, for all languages,
and the translaters may or may not make git a priority.

I'm open to using it for git-gui.  What do the other translators
active on the list think?

-- 
Shawn.
