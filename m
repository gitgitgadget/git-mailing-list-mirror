From: Andreas Ericsson <ae@op5.se>
Subject: Re: Who uses Signed-off-by and DCO?
Date: Fri, 12 Jun 2009 13:05:14 +0200
Message-ID: <4A32366A.6090608@op5.se>
References: <20090612084207.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 13:05:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF4Ze-0006sl-LJ
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 13:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757383AbZFLLFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 07:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758922AbZFLLFR
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 07:05:17 -0400
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:41830 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755513AbZFLLFP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jun 2009 07:05:15 -0400
Received: from source ([72.14.220.157]) by na3sys009aob109.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSjI2bdLIyA702M3QPLIRenEHw5k28AiI@postini.com; Fri, 12 Jun 2009 04:05:18 PDT
Received: by fg-out-1718.google.com with SMTP id 13so725355fge.5
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 04:05:16 -0700 (PDT)
Received: by 10.86.53.8 with SMTP id b8mr3594875fga.32.1244804716422;
        Fri, 12 Jun 2009 04:05:16 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.163.94])
        by mx.google.com with ESMTPS id e20sm2041954fga.25.2009.06.12.04.05.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Jun 2009 04:05:15 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090612084207.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121407>

Nanako Shiraishi wrote:
> git provides options and configuration variables to easily handle the
> Signed-off-by tag line. It is used to certify that the sender
> certifies the patch with the Developer's Certificate of Origin.
> 
> I have read SubmittingPatches document and understand this convention
> is used by the Linux Kernel Project.
> 
> I was giving a git introduction to students in my lab, and this
> question came up from one of them. How widely is this convention
> used? Are there projects other than the Linux Kernel and git itself?
> 

We use it for our own opensource projects, though I must admit we
stole the idea from git.git.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
