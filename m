From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's in git.git (stable frozen)
Date: Thu, 17 Jan 2008 22:01:46 -0500
Message-ID: <20080118030146.GV24004@spearce.org>
References: <7vk5m9kvf7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 04:02:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFhUp-0007Mu-W5
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 04:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498AbYARDBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 22:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbYARDBv
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 22:01:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39584 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597AbYARDBu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 22:01:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JFhU9-0005Zf-8g; Thu, 17 Jan 2008 22:01:37 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 682B220FBAE; Thu, 17 Jan 2008 22:01:46 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vk5m9kvf7.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70955>

Junio C Hamano <gitster@pobox.com> wrote:
> I see French translation for git-gui in Shawn's repository, but
> I do not know if it, along with other changes to git-gui, are
> meant for 1.5.4 or not.  If they are, I'd like to include them
> all before tagging rc4.

I have a few changes queued for 0.9.2, which I'd like to get done
and included before 1.5.4, plus I'd like to get Mark Levedahl's
DESTDIR issue resolved before then too.


.... changes since 0.9.1 ....

Christian Couder (2):
      git-gui: Initial french translation
      git-gui: add french glossary: glossary/fr.po

Christian Stimming (4):
      git-gui: Update glossary: add term "hunk"
      git-gui: Update German translation
      git-gui: Fix broken revert confirmation.
      git-gui: Improve German translation.

Peter Karlsson (1):
      git-gui: Updated Swedish translation after mailing list review.

Shawn O. Pearce (2):
      git-gui: Allow 'Create New Repository' on existing directories
      git-gui: Refresh file status description after hunk application

-- 
Shawn.
