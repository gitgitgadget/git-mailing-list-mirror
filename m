From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Fri, 20 Jun 2008 17:38:59 +0200
Message-ID: <20080620153859.GA5700@elte.hu>
References: <20080620082034.GA24913@elte.hu> <vpqiqw42vk6.fsf@bauges.imag.fr> <20080620135004.GB8135@elte.hu> <m34p7ombie.fsf@localhost.localdomain> <20080620153819.GF17373@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 17:40:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9iim-0000bx-I7
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 17:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760896AbYFTPjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 11:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760890AbYFTPjS
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 11:39:18 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:38095 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760882AbYFTPjR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 11:39:17 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1K9iha-0000wb-DT
	from <mingo@elte.hu>; Fri, 20 Jun 2008 17:39:15 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 207ED3E222D; Fri, 20 Jun 2008 17:38:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080620153819.GF17373@elte.hu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.5 required=5.9 tests=BAYES_40 autolearn=no SpamAssassin version=3.2.3
	0.5 BAYES_40               BODY: Bayesian spam probability is 20 to 40%
	[score: 0.2366]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85654>


* Jakub Narebski <jnareb@gmail.com> wrote:

> > hm, can Bash be taught to do command completion on 'git rer<tab>',
> > like it is able to do on git-rer<tab> ?
>
> contrib/completion/git-completion.bash in git repository.

works perfectly - thanks for the suggestion!

	Ingo
