From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: [PATCH] Provide better feedback for the untracked only case in status output
Date: Thu, 11 Jan 2007 08:17:12 +0100
Message-ID: <17829.58488.697000.282686@lapjr.intranet.kiel.bmiag.de>
References: <1168452977.19643.57.camel@ibook.zvpunry.de>
	<11684679032630-git-send-email-j.ruehle@bmiag.de>
	<20070110222914.GA22838@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 08:17:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4uBz-0008PT-6v
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 08:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965316AbXAKHR3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 02:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965317AbXAKHR3
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 02:17:29 -0500
Received: from bilbo.bmiag.de ([62.154.210.131]:3197 "HELO bilbo.bmiag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965316AbXAKHR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 02:17:28 -0500
Received: (qmail 21024 invoked by uid 106); 11 Jan 2007 07:17:26 -0000
Received: from eorl.intranet.kiel.bmiag.de(10.131.2.1)
 via SMTP by bilbo.bmiag.de, id smtpdp2C7sA; Thu Jan 11 08:17:26 2007
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id B1EBB3ADC8;
	Thu, 11 Jan 2007 08:17:25 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eorl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 30245-10; Thu, 11 Jan 2007 08:17:21 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id D78D43ADC6;
	Thu, 11 Jan 2007 08:17:14 +0100 (CET)
To: Jeff King <peff@peff.net>
In-Reply-To: <20070110222914.GA22838@coredump.intra.peff.net>
X-Mailer: VM 7.19 under Emacs 22.0.92.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eorl.intranet.kiel.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36551>

Jeff King writes:
 > On Wed, Jan 10, 2007 at 11:25:03PM +0100, Juergen Ruehle wrote:
 > 
 > >    - Patches to other files that contain these messages verbatim
 > >      (AFAICS this affects only the git-reset man page, tutorial-2 and the VIM
 > >       syntax highlighting)
 > 
 > I have been tracking these changes for the vim highlighting, but have
 > been waiting for things to settle before sending a patch (which should
 > hopefully go into v1.5.0, but I will wait until this is finalized).

Thanks for tracking this. It would be nice if we could make the
syntax highlighting less dependent on the exact wording.
