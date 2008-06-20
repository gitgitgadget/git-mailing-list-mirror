From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Fri, 20 Jun 2008 15:50:05 +0200
Message-ID: <20080620135004.GB8135@elte.hu>
References: <20080620082034.GA24913@elte.hu> <vpqiqw42vk6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 20 15:51:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9h1H-0005rN-8e
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 15:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173AbYFTNuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 09:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755222AbYFTNuS
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 09:50:18 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:39430 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754934AbYFTNuR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 09:50:17 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1K9h0C-0006i9-OR
	from <mingo@elte.hu>; Fri, 20 Jun 2008 15:50:16 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 731163E21DC; Fri, 20 Jun 2008 15:50:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <vpqiqw42vk6.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.5 required=5.9 tests=BAYES_40 autolearn=no SpamAssassin version=3.2.3
	0.5 BAYES_40               BODY: Bayesian spam probability is 20 to 40%
	[score: 0.2437]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85647>


* Matthieu Moy <Matthieu.Moy@imag.fr> wrote:

> (BTW, git-foo is being obsoleted in favor of "git foo")

hm, can Bash be taught to do command completion on 'git rer<tab>', like 
it is able to do on git-rer<tab> ?

	Ingo
