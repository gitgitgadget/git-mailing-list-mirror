From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Update German translation.
Date: Sun, 17 Feb 2008 02:27:26 -0500
Message-ID: <20080217072726.GN24004@spearce.org>
References: <200802162156.23436.stimming@tuhh.de> <200802162158.22924.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Sun Feb 17 08:28:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQdwh-0002sS-I3
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 08:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbYBQH1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 02:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbYBQH1d
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 02:27:33 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46407 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbYBQH1c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 02:27:32 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JQdvr-00068w-CR; Sun, 17 Feb 2008 02:27:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EF26D20FBAE; Sun, 17 Feb 2008 02:27:26 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200802162158.22924.stimming@tuhh.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74096>

Christian Stimming <stimming@tuhh.de> wrote:
> Signed-off-by: Christian Stimming <stimming@tuhh.de>
> ---
> Attached this and previous patch as tarball because of 
> whitespace yadda yadda :-)

I really don't mind getting i18n patches to the po/*.po files as
compressed attachments, because the whitespace and or character
encodings often do get messed up and the patch doesn't apply.
Better to just work with the attachment that I know is good.

But please don't tar it.  I spent waaaay too much time tonight
because I kept missing the fact that git-am won't accept a .tgz.
Maybe I'm just really tired.  :)

Usually just attached .patch works, or gzip the .patch.  But please
don't tar it if you are going to the trouble of sending one patch
per email anyway.  Thanks.
 
>  po/de.po          |   70 +++++++++++++++++++++++++++++++++++-----------------
>  po/glossary/de.po |    4 +-
>  2 files changed, 49 insertions(+), 25 deletions(-)

-- 
Shawn.
