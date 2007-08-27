From: Sam Vilain <sam@vilain.net>
Subject: Re: repo.or.cz wishes?
Date: Tue, 28 Aug 2007 11:30:18 +1200
Message-ID: <46D35E8A.8010409@vilain.net>
References: <20070826235944.GM1219@pasky.or.cz> <20070827001634.GB1976MdfPADPa@greensroom.kotnet.org> <20070827004153.GN1219@pasky.or.cz> <alpine.LFD.0.999.0708271114470.25853@woody.linux-foundation.org> <mj+md-20070827.195605.14967.albireo@ucw.cz> <alpine.LFD.0.999.0708271509230.25853@woody.linux-foundation.org> <46D356F9.1010506@vilain.net> <alpine.LFD.0.999.0708271616520.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Martin Mares <mj@ucw.cz>, Petr Baudis <pasky@suse.cz>,
	skimo@liacs.nl, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 29 16:14:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPo2s-00023S-Cl
	for gcvg-git@gmane.org; Tue, 28 Aug 2007 01:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245AbXH0Xaz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 19:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752917AbXH0Xaz
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 19:30:55 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:40790 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086AbXH0Xay (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 19:30:54 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 0B0FB21CFA8; Tue, 28 Aug 2007 11:30:53 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 4202721CFA1;
	Tue, 28 Aug 2007 11:30:48 +1200 (NZST)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <alpine.LFD.0.999.0708271616520.25853@woody.linux-foundation.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56901>

Linus Torvalds wrote:
> 
> On Tue, 28 Aug 2007, Sam Vilain wrote:
>> This is fine for URIs passed into git, but bad if you want to link to it
>> from elsewhere.
> 
> ..and by that logic, you should add "git+" to *everything*, not just ssh.
> Which simply isn't practical or sane - only damn annoying.

Why annoying and impractical, if you don't ever have to specify it
unless you want to write a URI which is portable between applications?

Sam.
