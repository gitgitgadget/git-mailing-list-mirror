From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add "next" link to commitdiff view
Date: Mon, 23 Oct 2006 00:43:11 +0200
Message-ID: <200610230043.11524.jnareb@gmail.com>
References: <200610230037.57183.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Oct 23 00:43:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbm1z-0006Lg-K3
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 00:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWJVWm4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 18:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWJVWm4
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 18:42:56 -0400
Received: from hu-out-0506.google.com ([72.14.214.235]:4237 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750766AbWJVWm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 18:42:56 -0400
Received: by hu-out-0506.google.com with SMTP id 28so905821hub
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 15:42:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PsouEquhJCeDEhnBO1Ftnza2bKNcO8eenK23dqSkD2uGTKowrQI+5Q08I8Tx2W+4FOGL1cj1Q8E8uSFfTvo8hwtJ/vGpPfFgEP9Aovs5Q7VMavppynhhpRrKn4SDgKHmx7WwRVE+rxjkbJKPo3AxtenHVSnJkpSf3Vj9dyPtZXg=
Received: by 10.66.221.6 with SMTP id t6mr6239201ugg;
        Sun, 22 Oct 2006 15:42:54 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id x37sm178157ugc.2006.10.22.15.42.53;
        Sun, 22 Oct 2006 15:42:53 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200610230037.57183.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29800>

BTW there are some errors in displaying commitdiff of initial commit, 
take for example a=commitdiff;h=161332a521fe10c41979bcd493d95e2ac562b7f
for git.git repository in gitweb.

Needs fixing.
-- 
Jakub Narebski
Poland
