From: Pedro Melo <melo@simplicidade.org>
Subject: Re: To page or not to page
Date: Fri, 2 May 2008 14:49:26 +0100
Message-ID: <3C2FECF0-8765-4988-98B7-4B050F999128@simplicidade.org>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org> <20080502054508.GA28506@sigill.intra.peff.net> <7vlk2txn8n.fsf@gitster.siamese.dyndns.org> <8C3474E2-3A4F-44E8-B301-C36939C7BA11@sb.org> <807E185B-BEE5-4AAF-8DF4-EE597681D61C@wincent.com> <20080502123656.GA2680@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>, Kevin Ballard <kevin@sb.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 02 15:51:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrvez-0001iL-M6
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 15:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbYEBNtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 09:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbYEBNtg
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 09:49:36 -0400
Received: from mail.sl.pt ([212.55.140.13]:39619 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964874AbYEBNte (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 09:49:34 -0400
Received: (qmail 13282 invoked from network); 2 May 2008 13:49:31 -0000
Received: from unknown (HELO [10.0.0.128]) (melo@[213.205.86.37])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <win@wincent.com>; 2 May 2008 13:49:31 -0000
Received-SPF: none (mail-sl: domain of melo@simplicidade.org does not designate permitted sender hosts)
In-Reply-To: <20080502123656.GA2680@sigill.intra.peff.net>
Jabber-Id: melo@simplicidade.org
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80997>

Hi,

On May 2, 2008, at 1:36 PM, Jeff King wrote:

> But I wonder why there seems to be such a split between people who
> clearly have short git-status output, and those who have long git- 
> status
> output.
>
> I keep my "untracked files" list tidy. IOW, I always get:
>
>   $ git status
>   # On branch master
>   nothing to commit (working directory clean)
>
> and if I don't, then I should be taking some action to commit things,
> clean them up, or add them to my .git/info/exclude file. Do other  
> people
> generally carry around a lot of cruft that "git status" reports?

I tend to accumulate "screen-and-a-half" git status outputs.

I usually hack on something until it works, and then I use git-gui  
and the hunk-based selection to order my work into a sane set of  
commits.

Commit'ing more often would make me wander of my task.

I guess its a matter of personal preference.

Best regards,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
