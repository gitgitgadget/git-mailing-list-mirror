From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Urgent: Issue with GIT ...
Date: Mon, 25 Jun 2012 16:07:34 +0400
Message-ID: <20120625160734.d8227e5d.kostix@domain007.com>
References: <1340624980925-7562097.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: guruprasad <guruprasadkinI@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 14:07:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj85F-0006HB-Bm
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 14:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756453Ab2FYMHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 08:07:41 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:35563 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756258Ab2FYMHi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 08:07:38 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id q5PC7YRM031310;
	Mon, 25 Jun 2012 16:07:35 +0400
In-Reply-To: <1340624980925-7562097.post@n2.nabble.com>
X-Mailer: Sylpheed 3.1.1 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200574>

On Mon, 25 Jun 2012 04:49:40 -0700 (PDT)
guruprasad <guruprasadkinI@gmail.com> wrote:

First,
http://www.catb.org/~esr/faqs/smart-questions.html#urgent

[...]
> 1) I have 2 Linux box (A and B). GIT installed in both of them.
> 2) I have one project in A and added to GIT repository.
> 3) Cloned A repository into B. Complete repository got cloned into B
> from A along with all source code.
> 4) If I do some changes to files in A and commit, I am able to pull
> the changes done and merge into B. (here i am not doing any push,
> just pull is getting all updates)
> 5) If i do some changes to files in B, commit and push to remote
> branch, I am unable to pull the changes done and merge into A.

What's missing, is the detailed description of how exactly you are
"unable to pull the changes ...".  That is, Git commands you run, the
output they produce.

[...]

P.S.
If you do cross post (you seem to have also posted the same question to
the git-users ML), care to mention this in your mails.
