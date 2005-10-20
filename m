From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: rsync update appears broken now
Date: 20 Oct 2005 07:12:53 -0700
Message-ID: <86ek6g9t0a.fsf@blue.stonehenge.com>
References: <86vezs9wy9.fsf@blue.stonehenge.com>
	<81b0412b0510200608l61c00ed0yd4dbc00c313665fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 16:19:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESbAQ-0003SV-9M
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 16:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVJTONL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 10:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbVJTONK
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 10:13:10 -0400
Received: from [209.223.236.162] ([209.223.236.162]:7492 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932161AbVJTONJ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 10:13:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 05D8F8F40F;
	Thu, 20 Oct 2005 07:12:54 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 00596-02-25; Thu, 20 Oct 2005 07:12:53 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 9B76B8F41A; Thu, 20 Oct 2005 07:12:53 -0700 (PDT)
To: Alex Riesen <raa.lkml@gmail.com>
x-mayan-date: Long count = 12.19.12.13.1; tzolkin = 11 Imix; haab = 19 Yax
In-Reply-To: <81b0412b0510200608l61c00ed0yd4dbc00c313665fe@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10360>

>>>>> "Alex" == Alex Riesen <raa.lkml@gmail.com> writes:

Alex> Absolutely normal pull into a changed repository. Just fix the
Alex> conflict (in fetch-pack.c, look for >>>), git-update-index the file
Alex> and commit. Doesn't look like a problem at all.

What do you mean "changed repository"?  This is my git image, and I'm
not working on git.  I made no changes.

Thus, something broken?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
