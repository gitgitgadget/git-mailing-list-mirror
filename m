From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git Gui: initial french translation: fr.po
Date: Wed, 16 Jan 2008 00:59:20 -0500
Message-ID: <20080116055920.GK24004@spearce.org>
References: <20080115062426.8fd03852.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 06:59:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF1Ja-0003Xt-EH
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 06:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbYAPF70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 00:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752169AbYAPF70
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 00:59:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53323 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbYAPF7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 00:59:25 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JF1J4-0001Ta-21; Wed, 16 Jan 2008 00:59:22 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7AB4120FBAE; Wed, 16 Jan 2008 00:59:20 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080115062426.8fd03852.chriscool@tuxfamily.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70635>

Christian Couder <chriscool@tuxfamily.org> wrote:
> Here are some of the choices made to translate Git Gui to french:

Thanks, this will be in git-gui 0.9.2.  GNU msgfmt caught a minor
bug in the translation.  The translation on line 466 needed to have
an LF, as the original text ended with an LF.  I inserted it when
I applied the patch.

> I just attached the file instead of sending the patch because I fear
> some encoding breakages.

Next time could you please use a proper Git patch (git-format-patch)
but attach the .patch file to your email.  Its far easier for me
to apply.

I don't mind applying translation patches sent as attachments
(as it does help avoid mangling) but I know many folks on the list
would still rather see them inline whenever possible.

-- 
Shawn.
