From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui translators: gitgui-0.10.0 coming soon
Date: Thu, 13 Mar 2008 01:42:15 -0400
Message-ID: <20080313054215.GV8410@spearce.org>
References: <20080313052713.GU8410@spearce.org> <7v4pbb18ze.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 06:43:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZgDT-00008e-06
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 06:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbYCMFmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 01:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbYCMFmU
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 01:42:20 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47274 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbYCMFmT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 01:42:19 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JZgCm-0006OQ-64; Thu, 13 Mar 2008 01:42:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 311F020FBAE; Thu, 13 Mar 2008 01:42:15 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v4pbb18ze.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77036>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> >
> > Current status of my master branch:
> >
> >     MSGFMT    po/de.msg 386 translated.
> >     MSGFMT    po/fr.msg 371 translated.
> >     MSGFMT    po/hu.msg 371 translated.
> >     MSGFMT    po/it.msg 390 translated, 1 untranslated.
> >     MSGFMT    po/ja.msg 371 translated.
> >     MSGFMT    po/ru.msg 367 translated, 4 untranslated.
> >     MSGFMT    po/sv.msg 371 translated.
> >     MSGFMT po/zh_cn.msg 368 translated, 2 fuzzy, 1 untranslated.
> 
> Just curious.  Why do these languages have different totall number of
> messages?

I think its because they are on different versions of the pot file,
and it may also be the case that the pot file is out of date relative
to git-gui's source code.  :-|

I think my i18n "coordinater" has been busy making git-gc have a 2
week delay and automatic pruning or something like that.  ;-)

-- 
Shawn.
