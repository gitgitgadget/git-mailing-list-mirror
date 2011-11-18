From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Git Gems
Date: Thu, 17 Nov 2011 18:49:59 -0600
Message-ID: <4EC5ABB7.5010907@gmail.com>
References: <CAE1pOi1gyshz_502NQvLNAByfwiYXW2fzA+EnGKz8tuFrCpkxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 01:50:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRCeg-0005I4-G1
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 01:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755038Ab1KRAuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 19:50:04 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60758 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266Ab1KRAuD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 19:50:03 -0500
Received: by ywt32 with SMTP id 32so1843573ywt.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 16:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=D9w2EYEcGQziHLx5nKICFpHCUp+WTwWKM6+XBHnQtfA=;
        b=OwtDlMEuvk0DHk+gDQqgXBF1JilKYia8pzZZK85jxV06MPh7vdCBRrtd95aKMsXpBA
         awb3JqttCZubpaCGAv8iVhCaFchx2Qjql2SFe9Y1ifMkbmgq8amh+YRiNP52eB6/5oH5
         hHAJX/rETMzmfDItPgYqceenm+2Pk1LcGSGME=
Received: by 10.236.154.42 with SMTP id g30mr1505952yhk.3.1321577402223;
        Thu, 17 Nov 2011 16:50:02 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id b9sm101013861anb.7.2011.11.17.16.50.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 16:50:01 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.24) Gecko/20111103 Thunderbird/3.1.16
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CAE1pOi1gyshz_502NQvLNAByfwiYXW2fzA+EnGKz8tuFrCpkxg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185614>

On 11/16/2011 5:18 PM, Hilco Wijbenga wrote:
> Hi all,
>
> Just today, I found out about 'git add -p'. I had never even thought
> of this but, now that I know, I can't imagine life without it. :-)
> Actually, it's a bit scary to note that the Git devs apparently aren't
> just telepathic but they can read my thoughts even before I think
> them. ;-)
>
> All kidding aside, I'm starting to wonder which other Git Gems I don't
> know about. For me, the list of Git Gems would include Git's Bash
> command line prompt, 'git add -p', 'git rebase', 'git commit --amend',
> and 'git-new-workdir'. I realize there are plenty of books and such
> out there but I'm really just looking for a list of Git commands
> and/or options that are worth looking into. Finding out more about a
> particular command/script/option is easy, realizing that a particular
> one is the one you need is not. Especially, if you don't even know you
> have a problem.
>
> As an example, 'git rebase' didn't really seem useful until I
> understood (well, more or less) what it did. Until then, I just
> naively assumed that merge commits and non-linear history were
> something you simply had to live with. I'm guessing that, like me, a
> lot of people come to Git with quite a few assumptions and
> preconceived notions due to their exposure to other SCM tools. :-(
>
This book:  http://progit.org/ will show you many gems if you take the 
time to peruse it.

v/r,
neal
