From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: Git Books
Date: Sat, 6 Dec 2008 13:27:52 +0100
Message-ID: <46d6db660812060427h3c97efd9ie4aa604133aa3583@mail.gmail.com>
References: <d411cc4a0812060358ub640ea3kd04072c5640eef68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 13:29:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8wHe-0005ad-K7
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 13:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590AbYLFM1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 07:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755575AbYLFM1z
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 07:27:55 -0500
Received: from mu-out-0910.google.com ([209.85.134.185]:49539 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755558AbYLFM1y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 07:27:54 -0500
Received: by mu-out-0910.google.com with SMTP id g7so370298muf.1
        for <git@vger.kernel.org>; Sat, 06 Dec 2008 04:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=K6cZWYekPKNwiMVyZ+OL3NRnavB2S6hjm55JA5nOnqg=;
        b=r6cIfW+1UGTbBvoc1u45LNttW8H3ayazDlMWIEBQQEPCcYKMTrdVdKw7dBE3l5Nmrf
         45Zl1p15bdHMAp0IS/hu1+3Nmi3kLF952NbogsDkQLo9VGqVr140fN+Oz7iPdd2zx/uQ
         /DFbbnmhUyjDhA6CI1pzRAjzBV3iNy3/X+bhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XmX7CSKTVy8OXGyGgeNtaib9Masle2vklSr7rmh0Yy3tgUk+6XbHwBerh1EPLyjR1q
         5AAzH2zMmj+FkipSubzCTWvBa6klTRnA3/tuMAURp3qQUr7dLW9uzq6S6c5Ki9VS0RVw
         5a9qFMzm5ns8bUrJcaUyJnlBztjiWwy+K1YcY=
Received: by 10.103.189.15 with SMTP id r15mr445558mup.126.1228566472266;
        Sat, 06 Dec 2008 04:27:52 -0800 (PST)
Received: by 10.103.189.18 with HTTP; Sat, 6 Dec 2008 04:27:52 -0800 (PST)
In-Reply-To: <d411cc4a0812060358ub640ea3kd04072c5640eef68@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102448>

On Sat, Dec 6, 2008 at 12:58 PM, Scott Chacon <schacon@gmail.com> wrote:
> Hey all,
>
> I have been talked into helping write a real, paper-based book on Git
> for a publisher big enough that you may even see it in your local
> Borders or whatnot.  (And, it appears that Junio has been as well:
> http://gitster.livejournal.com/21616.html)
>
> So, since I'm near the beginning of this process, I was wondering if
> the group had any feedback as to what might be super helpful to
> include.  I mean, I have a pretty good layout and all, but if you
> wanted to point me to some threads that tend to crop up in the mailing
> list and IRC channel from relative newcomers that I might be able to
> nip in the bud, I would like to.  I'm addressing the stuff that _I_
> hear a lot, and I'm scanning the IRC logs and list for topics, but I
> figured many of you must answer the same questions all the time, too.
>
> Thanks,
> Scott
> --

workflows, workflows, workflows...

gitconfig/aliases best practices

tips and tricks in branches (ex: parentless...) and in setting up git servers

my 3 cents :)

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
