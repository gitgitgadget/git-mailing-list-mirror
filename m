From: Stephen Bash <bash@genarts.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Mon, 09 Apr 2012 14:59:41 -0400 (EDT)
Message-ID: <c1cc5fc7-ba1b-447a-9676-53956c5e9dae@mail>
References: <1421035.yALBSXSHGd@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 09 20:59:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHJoh-00026B-Lr
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 20:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757739Ab2DIS7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 14:59:51 -0400
Received: from hq.genarts.com ([173.9.65.1]:48621 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757685Ab2DIS7u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 14:59:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 1F026BE9E98;
	Mon,  9 Apr 2012 14:59:47 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fzP4zofINVjs; Mon,  9 Apr 2012 14:59:41 -0400 (EDT)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 18616BE9E9A;
	Mon,  9 Apr 2012 14:59:41 -0400 (EDT)
In-Reply-To: <1421035.yALBSXSHGd@flomedio>
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC18 (Mac)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195030>

----- Original Message -----
> From: "Florian Achleitner" <florian.achleitner2.6.31@gmail.com>
> Sent: Thursday, April 5, 2012 9:36:40 AM
> Subject: Re: GSOC Proposal draft: git-remote-svn
> 
> Thanks for your inputs. I've now submitted a slightly updated version
> of my proposal to google. Additionally it's on github [1].
> 
> Summary of diffs:
> I'll concentrate on the fetching from svn, writing a remote helper
> without branch detection (like svn-fe) first, and then creating the
> branch mapper.
> 
> [1] https://github.com/flyingflo/git/wiki/

Florian - I just skimmed the github page since I've been away for a week.  Not to toot my own horn to much, there's a lot of good discussion about svn-isms in my thread from 2010 (starts at [1], but most of the good stuff is the discussion that follows).  I didn't see it in the references, and it probably doesn't need to be there, but if you haven't seen it yet, take a look at it (and cringe at my horrible abuse of git in my early days... ugh!).

[1] http://article.gmane.org/gmane.comp.version-control.git/159054

Thanks,
Stephen
