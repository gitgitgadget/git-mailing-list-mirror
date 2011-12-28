From: chirin <takonatto@gmail.com>
Subject: Re: Git beginner - Need help understanding
Date: Tue, 27 Dec 2011 17:38:33 -0800 (PST)
Message-ID: <1325036313909-7131536.post@n2.nabble.com>
References: <1324955537875-7129186.post@n2.nabble.com> <CA++fsGHPKhzfd7-KohOZ4WpYatx_-EW0bjq46zwswbu8TomHCg@mail.gmail.com> <1324969372444-7129429.post@n2.nabble.com> <7vr4zp7q15.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 02:38:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfiTi-000329-0n
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 02:38:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855Ab1L1Bif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 20:38:35 -0500
Received: from sam.nabble.com ([216.139.236.26]:48273 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723Ab1L1Bie (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 20:38:34 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <takonatto@gmail.com>)
	id 1RfiTR-0002kW-Tj
	for git@vger.kernel.org; Tue, 27 Dec 2011 17:38:33 -0800
In-Reply-To: <7vr4zp7q15.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187741>

The problem was solved by using another Gerrit ID for remote.origin.url in
the config. I remain confused with Git. 


Junio C Hamano wrote
> 
> Compared to that, your version above does not say anything about what the
> state of A, B and the repository A and B interact with were in before the
> problem started, so even if Dob wanted to help you by trying to reproduce
> your situation, there is not enough information to do so.
> 

My apologies on being vague.. I'm here for learning purpose instead of
get-someone-to-help-me-solve purpose. :P I'm really keen on learning what to
look for, where to start looking to understand Git.

I'm having difficulties providing information that I do not yet know how to,
as I'm still at the stage where I'm studying simple terminologies like
origin, master, etc. and I tend to confuse myself more by comparing it to
SVN.

What should I know about the 'states of A, B and the repository A and B
interact with'? 

--
View this message in context: http://git.661346.n2.nabble.com/Git-beginner-Need-help-understanding-tp7129186p7131536.html
Sent from the git mailing list archive at Nabble.com.
