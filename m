From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: Sequencer migration patches
Date: Thu, 17 Jul 2008 15:05:47 +0200
Message-ID: <20080717130547.GA8421@leksak.fem-net>
References: <fd9b4f2b04c9b997c6bdba90352eb1ef973114ae.1216233915.git.s-beyer@gmx.net> <cover.1216233918.git.s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 15:07:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJTC6-0005xr-Tn
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 15:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242AbYGQNFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 09:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753655AbYGQNFw
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 09:05:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:57476 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753543AbYGQNFv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 09:05:51 -0400
Received: (qmail invoked by alias); 17 Jul 2008 13:05:49 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp064) with SMTP; 17 Jul 2008 15:05:49 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18r+sAZMA0r6stmvipjzBqb6jkaf9/UwHb3jdN0+g
	O/qwUM32BOnB1R
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KJTB5-0004ED-Mf; Thu, 17 Jul 2008 15:05:47 +0200
Content-Disposition: inline
In-Reply-To: <cover.1216233918.git.s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88847>

Hi,

Stephan Beyer wrote:
> Rebasing 100 commits takes 10.1 seconds instead of only 4.8 seconds
> on my test machine.

Btw, the builtin-sequencer needs 1.7 seconds to pick that 100 commits
on my test machine.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
