From: "A.J. Rossini" <blindglobe@gmail.com>
Subject: Re: Rebasing a branch that contains merges
Date: Mon, 19 Feb 2007 15:39:11 +0100
Message-ID: <1abe3fa90702190639g3e0d6da1xa8086999ca53228@mail.gmail.com>
References: <200702190912.24067.andyparkins@gmail.com>
	 <7vmz3a8p6g.fsf@assigned-by-dhcp.cox.net>
	 <200702191048.24091.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 19 15:39:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ9fj-0001V0-6I
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 15:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbXBSOjQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 09:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbXBSOjQ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 09:39:16 -0500
Received: from nz-out-0506.google.com ([64.233.162.224]:36134 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932294AbXBSOjP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 09:39:15 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1687880nze
        for <git@vger.kernel.org>; Mon, 19 Feb 2007 06:39:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VP51QYmtyiOzbzur//IqiP2mSrKpjv7PH2dC/5UwnBWm2ovKaDYkVP/CiP+ZzINBdg4nZTzsKzV4UCOeIck5hyegXF6OOcLoMlbUqCcd/85+huJehsalNS3UdUDi4ygAev0amdM2B6RSZgpKWISH2Ol/qjZkk5Ho+CoTDhq3LSE=
Received: by 10.114.210.2 with SMTP id i2mr2920619wag.1171895951345;
        Mon, 19 Feb 2007 06:39:11 -0800 (PST)
Received: by 10.115.47.9 with HTTP; Mon, 19 Feb 2007 06:39:11 -0800 (PST)
In-Reply-To: <200702191048.24091.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40128>

On 2/19/07, Andy Parkins <andyparkins@gmail.com> wrote:

> So - rebase would need some sort of language to tell it which branch to
> favour.

The more I use git, the more I start thinking that a domain-specific
language to describe merges would not be a bad thing.  It's so easy
(painless, thought-free) to create a complex set of branches that
you'd like to rearrange with each other.

Of course, perhaps the right solution is to be simpler and old
fashioned and cease hyper-multitasking (i.e. shooting myself in the
foot).

(I'm sharing Andy's assumption that my repo is just mine, not really
shared -- add in sharing, or public use, and it gets far more complex,
and the language idea might be a good idea, and not just an idea.
Darcs has it's theory of patches, though it's not a language).

best,
-tony

blindglobe@gmail.com
Muttenz, Switzerland.
"Commit early,commit often, and commit in a repository from which we can easily
roll-back your mistakes" (AJR, 4Jan05).
