From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: libgit2 status
Date: Sat, 25 Aug 2012 23:46:15 +0200
Message-ID: <20120825214614.GA8697@vidovic>
References: <87a9xkqtfg.fsf@waller.obbligato.org>
 <5038A148.4020003@op5.se>
 <CAFFjANSDyREbNH1qRgYRPw1C87+D=Ft+ZirLvNihkj3UxF-=Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, greened@obbligato.org,
	git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Vicent Marti <vicent@github.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 23:46:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5OBc-0006by-Rl
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 23:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589Ab2HYVqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 17:46:21 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:58279 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab2HYVqU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 17:46:20 -0400
Received: by weyx8 with SMTP id x8so1669823wey.19
        for <git@vger.kernel.org>; Sat, 25 Aug 2012 14:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DYqHxqxihowsr9h4SBeO4QfPIFIDYhfrx8MXAsL3M+U=;
        b=pw6ocI663TY8MU5ur3nwkapQ5t4V/Z7Bf1P6iOEne9mNVj3ZhO+i4HrElN/2abhY9W
         QNjlCjT7aLESZgfqhWS9FhQS0chv8RWZp4suKhHF+TjNOLVPrN0tpbdQg4/7TxuAaDP0
         QsXmus7Sfm8LRIMvuNQiCZiE8Hz1+4J/Ypln76RZcZD8xLmNKQA6VLZqmeMPBK72DKFm
         i8435P+EPkqqNn3n+s+Sq/HRuXhjBEKFIHi/oKqlQYxWA199CLRBc5gb9LniBvex+eDv
         atIZkzrFCRfZN21hm+M++P/6c02cRo0O/McFFH+2AIz+yleiaMZjpvZKdbrPDjmEu52V
         nmow==
Received: by 10.216.132.76 with SMTP id n54mr4518618wei.135.1345931178853;
        Sat, 25 Aug 2012 14:46:18 -0700 (PDT)
Received: from vidovic (146.132.84.79.rev.sfr.net. [79.84.132.146])
        by mx.google.com with ESMTPS id el6sm5645109wib.8.2012.08.25.14.46.16
        (version=SSLv3 cipher=OTHER);
        Sat, 25 Aug 2012 14:46:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFFjANSDyREbNH1qRgYRPw1C87+D=Ft+ZirLvNihkj3UxF-=Eg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204288>

The 25/08/12, Vicent Marti wrote:

> The development of libgit2 happens 100% in the open. I don't know what
> "commercial entity" are you talking about, but there are several
> companies and independent contributors working on the Library at the
> moment.

Right but as far as I'm aware of Junio had reserves about libgit2
integration into git due to issues making repositories broken. Though,
having libgit2 as git core would make libgit2 the the-facto standard
which would a *very* big plus.

Also, I guess that integration into git would mean more developers
contibuting for libgit2. Currently, issues seems to be a blocker for
integration. So, libgit2 might appear to be a marginal/risky alternative
for a long time which is sad.

[ I'm somewhat in the same situation of OP. ]

-- 
Nicolas Sebrecht
