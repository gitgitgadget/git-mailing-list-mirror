From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui translators: gitgui-0.10.0 coming soon
Date: Fri, 14 Mar 2008 02:38:18 -0400
Message-ID: <20080314063817.GW8410@spearce.org>
References: <20080313052713.GU8410@spearce.org> <alpine.DEB.1.00.0803140723450.30157@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Mar 14 08:01:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja3vB-0001MV-Vy
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 08:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbYCNHA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 03:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754893AbYCNHA3
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 03:00:29 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33638 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754862AbYCNHAR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 03:00:17 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ja3tk-0003AP-M0; Fri, 14 Mar 2008 03:00:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 20C3620FBAE; Fri, 14 Mar 2008 02:38:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0803140723450.30157@perkele.intern.softwolves.pp.se>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77185>

Peter Karlsson <peter@softwolves.pp.se> wrote:
> >If you get a chance, please review your translations and send a patch if 
> >there are any updates.
> 
> I've committed changes to the mob branch. They come in several steps, but 
> feel free to squash them if you want to. I also re-generated the 
> translation template ("make -B po/git-gui.pot") and merged the other 
> translation files.

Squashed.

Now that the template is updated we have slightly different
stats from msgfmt:

    MSGFMT    po/de.msg 383 translated, 5 fuzzy, 3 untranslated.
    MSGFMT    po/fr.msg 370 translated, 5 fuzzy, 16 untranslated.
    MSGFMT    po/hu.msg 383 translated, 5 fuzzy, 3 untranslated.
    MSGFMT    po/it.msg 388 translated, 2 fuzzy, 1 untranslated.
    MSGFMT    po/ja.msg 370 translated, 5 fuzzy, 16 untranslated.
    MSGFMT    po/ru.msg 365 translated, 6 fuzzy, 20 untranslated.
    MSGFMT    po/sv.msg 391 translated.
    MSGFMT po/zh_cn.msg 367 translated, 7 fuzzy, 17 untranslated.

;-)

-- 
Shawn.
