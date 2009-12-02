From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCHv9 01/11] fast-import: Proper notes tree manipulation
Date: Wed, 02 Dec 2009 23:41:55 +0100
Message-ID: <200912022341.55474.johan@herland.net>
References: <1259719783-4674-1-git-send-email-johan@herland.net>
 <1259719783-4674-2-git-send-email-johan@herland.net>
 <20091202203953.GE31648@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 02 23:42:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFxtc-0005AZ-To
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 23:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755920AbZLBWlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 17:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755909AbZLBWly
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 17:41:54 -0500
Received: from smtp.getmail.no ([84.208.15.66]:61847 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755904AbZLBWlw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2009 17:41:52 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KU1000S4R1XOD00@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 02 Dec 2009 23:41:57 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KU100JDLR1WVZ20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 02 Dec 2009 23:41:57 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.12.2.223031
User-Agent: KMail/1.12.3 (Linux/2.6.31-ARCH; KDE/4.3.3; x86_64; ; )
In-reply-to: <20091202203953.GE31648@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134413>

On Wednesday 02 December 2009, Shawn O. Pearce wrote:
> Johan Herland <johan@herland.net> wrote:
> > diff --git a/fast-import.c b/fast-import.c
> > index b41d29f..b51ffbc 100644
> > --- a/fast-import.c
> > +++ b/fast-import.c
> 
> This new version is much cleaner, thank you.

Thank you for the suggestions that made it so :)

The rest of your comments all make perfect sense. I'll whip up a replacement 
patch shortly.


Thanks for the review!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
