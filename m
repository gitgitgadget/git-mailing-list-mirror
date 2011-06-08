From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Q: how can i find the upstream merge point of a commit?
Date: Wed, 8 Jun 2011 16:27:57 +0200
Message-ID: <20110608142757.GG30752@elte.hu>
References: <20110608093648.GA19038@elte.hu>
 <20110608203433.61e02ad8.sfr@canb.auug.org.au>
 <20110608125242.GA32745@elte.hu>
 <BANLkTiku_qvn73cUDBT=OxY-3jR3raoOhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, git@vger.kernel.org,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 16:28:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUJk5-00033q-Bt
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 16:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab1FHO2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 10:28:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:39074 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755977Ab1FHO2N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 10:28:13 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1QUJjj-0003zu-Fd
	from <mingo@elte.hu>; Wed, 08 Jun 2011 16:28:07 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 4323A3E2517; Wed,  8 Jun 2011 16:27:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTiku_qvn73cUDBT=OxY-3jR3raoOhg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx2.mail.elte.hu: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.3.1
	-2.0 BAYES_00               BODY: Bayes spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175374>


* Sverre Rabbelier <srabbelier@gmail.com> wrote:

> Heya,
> 
> [+Peff, Duy, who seemed interested in this]
> 
> On Wed, Jun 8, 2011 at 14:52, Ingo Molnar <mingo@elte.hu> wrote:
> > So it would be nice to have more separation for remotes - right now
> > they do not sit still in their sandboxes! :-)
> 
> Sounds like the "tags should go in their own namespaces in git 1.8.0"
> [0] discussion? :)
> 
> [0] http://thread.gmane.org/gmane.comp.version-control.git/165799/focus=165837

Cool, i like banging on open doors! :-)

Thanks,

	Ingo
