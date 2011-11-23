From: Andreas Ericsson <ae@op5.se>
Subject: Re: [ANN] SubGit Early Access Program Build #789
Date: Wed, 23 Nov 2011 10:03:02 +0100
Message-ID: <4ECCB6C6.8040200@op5.se>
References: <4ECBF4EF.7070705@tmatesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: jgit-dev <jgit-dev@eclipse.org>,
	EGit developer discussion <egit-dev@eclipse.org>,
	Git Mailing List <git@vger.kernel.org>
To: Semen Vadishev <semen.vadishev@tmatesoft.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 10:03:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RT8je-0008CP-WC
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 10:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897Ab1KWJDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 04:03:09 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51328 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273Ab1KWJDF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 04:03:05 -0500
Received: by ghrr1 with SMTP id r1so1135201ghr.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 01:03:05 -0800 (PST)
Received: by 10.152.134.101 with SMTP id pj5mr14177175lab.1.1322038984491;
        Wed, 23 Nov 2011 01:03:04 -0800 (PST)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id pc8sm15190992lab.8.2011.11.23.01.03.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Nov 2011 01:03:03 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.23) Gecko/20110928 Fedora/3.1.15-1.fc14 Thunderbird/3.1.15 ThunderGit/0.1a
In-Reply-To: <4ECBF4EF.7070705@tmatesoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185831>

On 11/22/2011 08:15 PM, Semen Vadishev wrote:
> Hello All,
> 
> Let me introduce our new project: SubGit (http://subgit.com/).
> 
> SubGit is a tool for smooth migration from Subversion to Git. As well as
> from Git to Subversion. Without git-svn insanity.
> 
> It works like this:
> 
> - Install SubGit into your repository on the server side
> 
> - Let initial translation complete (time depends on the size of repository)
> 
> - SubGit installs hooks into repository, so it translates every svn
> revision and git commit
> 
> - Committers may now use either Git or Subversion (or both) with the
> tools of their choice
> 

How does it handle merges?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
