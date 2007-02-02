From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] fix some doc typos and grammar
Date: Fri, 2 Feb 2007 09:49:08 +0000
Message-ID: <200702020949.09655.andyparkins@gmail.com>
References: <3c6c07c20702012225v19b7aa66vc98a028f700914db@mail.gmail.com> <7vmz3xjbxv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, "Mike Coleman" <tutufan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 02 10:49:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCv2r-0004Nh-Fz
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 10:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbXBBJtQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 04:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbXBBJtQ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 04:49:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:45231 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbXBBJtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 04:49:16 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1200797nfa
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 01:49:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ecCewZ8nJKB9EIilblXZZikJZu8i5L/KFpCUfuNtVlKToSWiMqq82pCERmMG8VuO35vwuqp11pm3Znke12XJwwDaRFtTjFjDOPlzkrk/fcFg8p22J+WOflgMRvR3IGPHEOYr3vDqC+5s3Lq9YUm0joBcws6KPGMAOcucAPbVluM=
Received: by 10.49.20.1 with SMTP id x1mr6105653nfi.1170409754469;
        Fri, 02 Feb 2007 01:49:14 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id u1sm4977638uge.2007.02.02.01.49.11;
        Fri, 02 Feb 2007 01:49:11 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vmz3xjbxv.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38482>

On Friday 2007 February 02 06:44, Junio C Hamano wrote:

> Ah, "which or that", very funny.  At work today I was working
> with somebody you know (AB) on a document, and he was fixing my
> that to which.  Now you are fixing my which to that.

In case anyone is interested; a handy rule of thumb (i.e. it isn't always 
true, but will hold you in good stead) is that "which" should be preceded by 
a comma and "that" should not.  If you write a sentence that requires the 
comma, then it's "which"; if it requires not having a comma, then 
it's "that".

e.g. 

"git is a version control system, which is a piece of software used for 
tracking changes to files over time"

"git is a version control system that has a fanatical following of users who 
will kill anyone who asks for rename support"

In the first case the "which" describes what a version control system is.  In 
the second, the "that" describes what git is.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
