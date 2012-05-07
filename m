From: Kelly Dean <kellydeanch@yahoo.com>
Subject: Re: Does content provenance matter?
Date: Mon, 7 May 2012 16:13:37 -0700 (PDT)
Message-ID: <1336432417.36394.YahooMailClassic@web121504.mail.ne1.yahoo.com>
References: <CAJsNXT=26u-PPNe9_LFoC1tAKpWJRWfBNNKzQB5Ya3X0n4K_eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: PJ Weisberg <pj@irregularexpressions.net>
X-From: git-owner@vger.kernel.org Tue May 08 01:20:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRXDx-0003Xu-0I
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 01:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757922Ab2EGXUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 19:20:04 -0400
Received: from nm9-vm1.bullet.mail.ne1.yahoo.com ([98.138.90.47]:24185 "HELO
	nm9-vm1.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757871Ab2EGXUB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 19:20:01 -0400
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 May 2012 19:20:01 EDT
Received: from [98.138.90.57] by nm9.bullet.mail.ne1.yahoo.com with NNFMP; 07 May 2012 23:13:37 -0000
Received: from [98.138.89.195] by tm10.bullet.mail.ne1.yahoo.com with NNFMP; 07 May 2012 23:13:37 -0000
Received: from [127.0.0.1] by omp1053.mail.ne1.yahoo.com with NNFMP; 07 May 2012 23:13:37 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 512069.42306.bm@omp1053.mail.ne1.yahoo.com
Received: (qmail 56692 invoked by uid 60001); 7 May 2012 23:13:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1336432417; bh=SuRyqVXIQ866LXd+hrP5SfxbZnjwr8EMWxCdwGKfOhU=; h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type; b=m8GI4A8u0OMQCltxhFtn+Zdu9tJ1VVJm1p7xoBjOjeDLS2QpQrtfxAhWuUyDepJmbuIgISGBfrHPnA85w79o33LE3SJIK5C4+q+CEt0YSYgzwBdAsPai7aXoZ+i+aq58Wt/seUK5CjQ7OvPzU6gnqlgcvnNg8o8d2WqdzjqmMhw=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=DiztR3vqOnXC+wviUwqFkNGRyjuNYfhWe6sOY29pLY8apb0xgmdznom2Q6FN+2nV2FZMRxc+hmaDK7n+7LLFy8yM0EBPOqvDY0iryVW5mGMMqyEZc6t0cbnM7wDx1XpDbIB3bDpc3Jbv780PkcAo9bi/D+wubFAl3ETknUrzXMs=;
X-YMail-OSG: xkJncRMVM1kQNwYZ87xu.aMyJI9X1NCXygK2nXxzMTYLkRP
 Qu1yhzR3ntyokAv5HGXTrdogYpUnHKVOgx56ax2lPr6iJ6Lwi9_sqxGVXrf6
 q258qu0zsVCDgUbne8B5ItiZQyM5dQs59lKi.VUlhJFPj5nClwNLMW5ZCL2Q
 UNCjEk1WFG6YpZnU7DR6BaFT8xi2Rz0dJTV75fDCKFZF6FJvXxq8Fy38mfx2
 8vZkg9z_kHXq4guOzG_uLhksiTuKu1SeiQzxNd8QouB67TlYigpUaPVO_Zdv
 L.D2qiZRSly5mzTOhyg7NkdKxOooTS9lakvHmUqjdStvdrYlRL1drOyOfgor
 lKCLJpyAQ0OiIN4_D6EzqCxuUng5QviLD4K7fOlYCoGYH4htJk9aP1lEdM5B
 .idsUMxO3aNsSUqU3tGBT6Vlyv8KD
Received: from [217.115.137.222] by web121504.mail.ne1.yahoo.com via HTTP; Mon, 07 May 2012 16:13:37 PDT
X-Mailer: YahooMailClassic/15.0.6 YahooMailWebService/0.8.117.340979
In-Reply-To: <CAJsNXT=26u-PPNe9_LFoC1tAKpWJRWfBNNKzQB5Ya3X0n4K_eg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197326>

--- On Mon, 5/7/12, PJ Weisberg <pj@irregularexpressions.net> wrote:
> But there could be any number of unrelated commits newer than "Bar"
> but older than "Revert Bar" on other branches.  Even if you could
> trust the timestamps to be accurate (you can't), you still can't
> determine a commit's parent unambiguously.
Therefore, provenance does matter, and it must be explicitly recorded because it can't necessarily be correctly and fully deduced from content alone. And git does record inter-commit provenance.
However, git doesn't record intra-commit provenance, as I mentioned in my original message. My question is: why this discrepancy? Either provenance matters, or it doesn't; why record it in one case but not the other?
