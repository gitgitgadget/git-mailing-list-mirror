From: Andreas Ericsson <ae@op5.se>
Subject: Re: GIT Vs CVS
Date: Mon, 07 Nov 2005 15:52:34 +0100
Message-ID: <436F6A32.6040200@op5.se>
References: <3AEC1E10243A314391FE9C01CD65429B13B2DA@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 07 15:55:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZ8MT-0005WJ-Mx
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 15:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVKGOwg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 09:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVKGOwg
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 09:52:36 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:63188 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750798AbVKGOwf
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 09:52:35 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 9BC4B6BCBE
	for <git@vger.kernel.org>; Mon,  7 Nov 2005 15:52:34 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B13B2DA@mail.esn.co.in>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11265>

Mukund JB. wrote:
> Dear All,
> 
> I have been just aware of GIT. As an active Linux device driver developer, I would like to know more about it.
> I have read through the GIT documentation the git native site.http://git.or.cz/
> 
> I find lot a similarities between GIT And Cvs.

The similiarities are just because they're both SCM's. It pretty much 
ends there.

> Can any elaborate on this?


It was just done in the list. If you browse the archives you'll find a 
lengthy discussion. You might also want to read the 
Documentation/cvs-migration.txt found in the git distribution.


> Can I use GIT instead of Cvs?
> 

Certainly. Prepare to spend a week or so letting the command-structure 
and syntax sink in though. It's a steep learning curve at first, 
although the git tutorial (Documentation/tutorial.txt) nicely cuts it in 
half.

The documentation is also available for online browsing at 
http://www.kernel.org/pub/software/scm/git-core/docs/

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
