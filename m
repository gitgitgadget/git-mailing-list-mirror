From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Git User's Survey 2009 partial summary, part 2 - from first 10
Date: Tue, 18 Aug 2009 17:54:52 +0200
Message-ID: <20090818155452.GA12938@vidovic>
References: <200908171224.44686.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 17:55:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdR1l-0003Ec-Ub
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 17:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759283AbZHRPzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 11:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759237AbZHRPzA
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 11:55:00 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:46129 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755013AbZHRPy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 11:54:59 -0400
Received: by ewy3 with SMTP id 3so1709520ewy.18
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 08:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=Y7d4T9b9sMWMQn172+dcUrNfMrs+TBdkZ3tiRFhCPcw=;
        b=aWkdH2NapjiKhGIrUubBIMHZOFWtuL/SN3Ym5R3n4s2tyZ1xqzsesDFp3vOCPX9Avv
         uPUJ5bAlrxHlPU5HwhotYBvEPMkWorWDxWz34Vtsg1S/uCBUTbCPcxzlDUYbGItOrEy/
         JtgIww89lu0vn74wau2qqPqsfkL2iqb4J0yJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RfexhVR+tAya2lS8pK8zsYLI5zPx13/RS7hnCTzLU5CrsK238H7VrAoY9EK1BwqBc/
         DaJ7fJteV728llvSzf2YeZoZaaddEnW9UGR5XhShD6lhSjJvH5oDnQwNuo6h7whSXbE2
         0HYZ//6hH6QphlLllNEsVmlyV/zqtMKxcTe1Q=
Received: by 10.210.29.9 with SMTP id c9mr4378523ebc.87.1250610899374;
        Tue, 18 Aug 2009 08:54:59 -0700 (PDT)
Received: from @ (83-154-172-251.rev.libertysurf.net [83.154.172.251])
        by mx.google.com with ESMTPS id 24sm240653eyx.33.2009.08.18.08.54.55
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 18 Aug 2009 08:54:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200908171224.44686.jnareb@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126403>

The 17/08/09, Jakub Narebski wrote:

> Git User's Survey 2009 partial summary, part 2 - git difficulty,
> proficiency, uses, install, OS, editors.

Thanks for these partial summaries.

> 3) Have you found Git easy to learn?
> 4) Have you found Git easy to use?
>    (Choice - Single answer)
> 
> ================================================
> Answer            | to learn [%] |   to use [%]
> ------------------------------------------------
> Very easy         |          4%  |          9%
> Easy              |         20%  |         36%
> Reasonably easy   |         55%  |         45%
> Hard              |         19%  |          8%
> Very hard         |          2%  |          1%
> ------------------------------------------------
> Total respondents |        2942  |        2959
> ================================================

<...>

> What's interesting is comparing (percentage) results for questions
> 3. and 4.; how hard is git to learn versus how hard is to use.  It
> seems like Git is reasonably easy to learn, and reasonably easy to
> easy to use.  So it looks like Git just have somewhat steep learning
> curve, and the difficulty to learn pays in being more powerful to
> use.

I believe it would be interesting to know who (from the question 6.)
think what later. We may expect that people of the grade 4 and 5 ("can
offer advice" and "know it very well") underestimate the difficulty to
learn Git.

Also (and as you said), this "Git's users" survey won't have answers
from unsatisfied users who left Git. We can't rate the number of users
who left Git because they found it too much hard to learn.

> 6) Rate your own proficiency with Git:
>    (Choice - Single answer)
> 
> You can think of it as 1-5 numerical grade of your proficiency in Git.
> 
> ================================================
> Proficiency               | resp [%] | resp [n]
> ------------------------------------------------
> 1. novice                 |       4% |      114
> 2. casual, needs advice   |      17% |      520
> 3. everyday use           |      38% |     1138
> 4. can offer advice       |      34% |     1020
> 5. know it very well      |       6% |      192
> --------------------------+---------------------
> Total respondents         |                2984
> Skipped this question     |                 105
> ================================================

-- 
Nicolas Sebrecht
