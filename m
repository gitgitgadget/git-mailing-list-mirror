From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-bisect feature suggestion: "git-bisect diff"
Date: Fri, 7 Dec 2007 20:46:30 +0100
Message-ID: <20071207194630.GA11069@elte.hu>
References: <20071207093439.GA21896@elte.hu> <7v63za4yic.fsf@gitster.siamese.dyndns.org> <7vwsrq3iox.fsf@gitster.siamese.dyndns.org> <20071207112159.GA11035@elte.hu> <7vmysm1eyz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 20:47:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0jAA-0002ET-Am
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 20:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbXLGTqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 14:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbXLGTqn
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 14:46:43 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:50879 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930AbXLGTqn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 14:46:43 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1J0j9d-0005u7-7q
	from <mingo@elte.hu>; Fri, 07 Dec 2007 20:46:41 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id C921E3E2166; Fri,  7 Dec 2007 20:46:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vmysm1eyz.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67449>


* Junio C Hamano <gitster@pobox.com> wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> 
> > ... One small detail though: i frequently ssh to testboxes that have 
> > DISPLAY set but i want text output. So git-bisect view --text should be 
> > a special-case perhaps?
> 
> Yeah, but at that point, wouldn't "git bisect view log" be shorter to 
> type?

it's also more intuitive. ok :-)

	Ingo
