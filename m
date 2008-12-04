From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Make branch use correct svn-remote
Date: Thu, 4 Dec 2008 11:26:45 -0800
Message-ID: <20081204192645.GD9650@hand.yhbt.net>
References: <1228185780-22938-1-git-send-email-deskinm@umich.edu> <20081202215157.GB9650@hand.yhbt.net> <7vbpvtj4kl.fsf@gitster.siamese.dyndns.org> <49365259.5090803@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Deskin Miller <deskinm@umich.edu>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 20:28:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8Jro-00051z-VR
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 20:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbYLDT0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 14:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752709AbYLDT0s
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 14:26:48 -0500
Received: from hand.yhbt.net ([66.150.188.102]:58594 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751663AbYLDT0r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 14:26:47 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id BF8D52DC01A;
	Thu,  4 Dec 2008 19:26:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49365259.5090803@drmicha.warpmail.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102358>

Michael J Gruber <git@drmicha.warpmail.net> wrote:
> Junio C Hamano venit, vidit, dixit 03.12.2008 04:55:
> > Eric Wong <normalperson@yhbt.net> writes:
> >> Deskin Miller <deskinm@umich.edu> wrote:
> 
> If I split the above copy into three lines then the test passes (svn
> 1.4.6, Deskin's patch applied onto 1.6.1-rc1 with the fix.

Thank you all for the testing and fixes.

-- 
Eric Wong
