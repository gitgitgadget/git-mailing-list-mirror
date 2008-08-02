From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: git-gui translators - please update translations if necessary
Date: Sat, 2 Aug 2008 14:17:14 -0700
Message-ID: <20080802211714.GG24723@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 23:18:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPOUU-0003t0-Na
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 23:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbYHBVRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 17:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbYHBVRP
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 17:17:15 -0400
Received: from george.spearce.org ([209.20.77.23]:54554 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbYHBVRP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 17:17:15 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 05C2F38420; Sat,  2 Aug 2008 21:17:15 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91184>

We're getting ready for the git 1.6 release in the not-too-distant
future, and that will ship with gitgui-0.11.

The current tip of my master branch builds as follows.  There have
not been many changes in the interface so I don't think there is
much (if any) translation work for this release.

    MSGFMT    po/de.msg 402 translated.
    MSGFMT    po/fr.msg 391 translated.
    MSGFMT    po/hu.msg 391 translated.
    MSGFMT    po/it.msg 390 translated, 1 untranslated.
    MSGFMT    po/ja.msg 391 translated.
    MSGFMT    po/ru.msg 387 translated, 4 untranslated.
    MSGFMT    po/sv.msg 391 translated.
    MSGFMT po/zh_cn.msg 367 translated, 7 fuzzy, 17 untranslated.

Thanks.

-- 
Shawn.
