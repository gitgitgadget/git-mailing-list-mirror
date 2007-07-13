From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-update-server-info may be required,cannot clone and pull from a remote repository
Date: Fri, 13 Jul 2007 02:17:37 +0200
Message-ID: <200707130217.37817.jnareb@gmail.com>
References: <a901b49a0707110708o7c883bb0s707d9791f344f1f6@mail.gmail.com> <f74tk8$k21$1@sea.gmane.org> <a901b49a0707120550i9361e30wc5811bd5d3305f59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
To: "pradeep singh" <pradeep.rautela@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 02:17:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I98qs-00060X-PC
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 02:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758904AbXGMARj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 20:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758736AbXGMARj
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 20:17:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:19630 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756817AbXGMARi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 20:17:38 -0400
Received: by ug-out-1314.google.com with SMTP id j3so460366ugf
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 17:17:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mrrki/pODcqe7MU+qD30AXN+UVKaIka+ZcNkexcg013WrN2wD8PlaSAGD2KjqVM8L4J/9D6uV/tggMiRtcVtfXby0UYbMvhPtBsENEYFQZldYONCJtCX1K7eLDQqY5qmXl3Wh/v2kY6x9O21wK21JqG5XnJcNXaViMD8nYIWV+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kjMUDjBXK5i3UoH2nj0hqGAGb7XvOkXowiuf6572gzELRHYcrkDbpp3QvAr4LbbMP50lIH6WVrcDDuaRJ8QgeSMG+OrFuC1FcbUZWTbH1pFXHPHliDttIxmh5FD/Mln6KqkUIYfgYUYsopfiKIO6QeA2ngQgbY0pBWql+ajuyKE=
Received: by 10.86.23.17 with SMTP id 17mr871483fgw.1184285857071;
        Thu, 12 Jul 2007 17:17:37 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTP id y18sm1623896fkd.2007.07.12.17.17.35
        (version=SSLv3 cipher=OTHER);
        Thu, 12 Jul 2007 17:17:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <a901b49a0707120550i9361e30wc5811bd5d3305f59@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52348>

Pradeep Singh wrote:
> On 7/12/07, Jakub Narebski <jnareb@gmail.com> wrote:
>> [Cc: git@vger.kernel.org, Pradeep Singh <pradeep.rautela@gmail.com>,
>>  Eric Wong <normalperson@yhbt.net> (instaweb creator)]
>>
>> pradeep singh wrote:
>>
>>> Anyway i could not get gitweb running after running git-instaweb.
>>>
>>> Any thoughts on how to setup a gitweb interface ?
>>
>> What information does gitweb/INSTALL lack?
> 
> May be I am running some old version on my Ubuntu Edgy machine
> perhaps? I cannot find such a file anywhere?

You can always look up this file at git.git gitweb (either kernel.org 
one, or repo.or.cz one), e.g.

  http://repo.or.cz/w/alt-git.git/:gitweb/INSTALL
 
> Looks like it is available in newer versions.
> Does it works for git-1.4.4?

The installation instructions may have changed a bit since then. It is 
much easier to use 1.5.x series, nevertheless.

-- 
Jakub Narebski
Poland
