From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: git sequencer prototype
Date: Tue, 1 Jul 2008 16:53:44 +0200
Message-ID: <20080701145344.GB5301@leksak.fem-net>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <7vabh2oulb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 16:55:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDhFk-0003ue-LZ
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 16:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291AbYGAOxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 10:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754712AbYGAOxr
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 10:53:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:54525 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754678AbYGAOxq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 10:53:46 -0400
Received: (qmail invoked by alias); 01 Jul 2008 14:53:44 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp003) with SMTP; 01 Jul 2008 16:53:44 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/lfTdhNwvlkZehikGnZVd0Y0Yvh+7N47G4SmRwJJ
	S/qGyU+WavCbd9
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KDhEm-0003Mr-93; Tue, 01 Jul 2008 16:53:44 +0200
Content-Disposition: inline
In-Reply-To: <7vabh2oulb.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87040>

Hi,

> > The migration patches are a little hard to code-review in the diff-form,
> > but feel free to apply, test, and then look at the code ;)
> 
> Heh, these three typically come in different order.  Look at the log
> message and docs to see if the design is sound, then look at the code, and
> if things overall look Ok, then finally apply and test.

Hmm, I usually prefer testing first (on such large patches), because I think
I value things different after I've tested them.

> I unfortunately ran out of time tonight and will look at them probably
> Thursday evening.

Don't hurry.

> It seems that another GSoC topic is finally nearing
> completion and I can shift my attention to other topics now.

Yes, the builtin merge should perhaps get some more priority first.

> By the way Christian is not CC'ed?

Shame on me, I forgot to Cc my mentors ;-)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
