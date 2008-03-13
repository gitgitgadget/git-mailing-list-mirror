From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: git-gui translators: gitgui-0.10.0 coming soon
Date: Thu, 13 Mar 2008 01:27:13 -0400
Message-ID: <20080313052713.GU8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 06:28:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZfzI-0005Ow-Cn
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 06:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbYCMF1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 01:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbYCMF1S
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 01:27:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43654 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbYCMF1R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 01:27:17 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JZfyE-00055W-Mt
	for git@vger.kernel.org; Thu, 13 Mar 2008 01:27:14 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 896DF20FBAE; Thu, 13 Mar 2008 01:27:13 -0400 (EDT)
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77034>

I'm nearing the point where I want to cut a 0.10.0 tag, as Junio
is looking to do 1.5.5-rc0/1 in the near future.

I've been busy on jgit/egit lately, and day-job, so I haven't
done any major feature development on git-gui in a few weeks.
Its basically in feature freeze at this point.

If you get a chance, please review your translations and send a
patch if there are any updates.

Current status of my master branch:

    MSGFMT    po/de.msg 386 translated.
    MSGFMT    po/fr.msg 371 translated.
    MSGFMT    po/hu.msg 371 translated.
    MSGFMT    po/it.msg 390 translated, 1 untranslated.
    MSGFMT    po/ja.msg 371 translated.
    MSGFMT    po/ru.msg 367 translated, 4 untranslated.
    MSGFMT    po/sv.msg 371 translated.
    MSGFMT po/zh_cn.msg 368 translated, 2 fuzzy, 1 untranslated.

Thanks.

-- 
Shawn.
