From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-scm.com (was Re: Git graph on GitHub)
Date: Wed, 15 Oct 2008 12:20:43 -0700 (PDT)
Message-ID: <m3prm1k6lz.fsf@localhost.localdomain>
References: <bab6a2ab0810150315l273d4ef3k95cda8f43a4745ca@mail.gmail.com>
	<bab6a2ab0810150318pb616a6dj867efa36623ac12e@mail.gmail.com>
	<20C9ABEC-52E5-405E-A755-C58A6359D7A9@wincent.com>
	<bab6a2ab0810151136n4f997890qd418277ea8c4aea4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Wincent Colaiuta" <win@wincent.com>, git@vger.kernel.org
To: "PJ Hyett" <pjhyett@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 21:22:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqBwX-0006Ac-U9
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 21:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbYJOTUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 15:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753608AbYJOTUs
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 15:20:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:3982 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565AbYJOTUr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 15:20:47 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1317967nfc.21
        for <git@vger.kernel.org>; Wed, 15 Oct 2008 12:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=tVCv0/61IQ085+Bru48LWQ7fKxJgBrNjwOqw6pqy1Js=;
        b=VYMdnzTxiVLfirrjaqQvYx6Xwk/RMd8M4pjvYYUfw21878D+WN6gogMRRS0LgNv96C
         wls0g10z6s08Edns3z49FDe0xxe1sXVX9IJdLnmxbb4NMp6kSiP5fVKjA8nXZGWSTCSc
         tDOWkJ3bEm+HTv/JgvPd3+W+uN/IIQ+nZvnF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=hxebNxDkaz00r/6wYfygn6dDCB540DxxZSq28xvwhYKjA5dT5qh8hmcdnd/TmwU+d9
         xcojxm12R4XBY5Vu+YJqZybX3vCR33s0plB8Hp1IZ1SOuDaqGs+yuPlS4slCqDOnmHCg
         WHgYB2kW1PnZ9v54X6iwhzpvoWBmH3exs4KqM=
Received: by 10.210.25.20 with SMTP id 20mr1621964eby.133.1224098445004;
        Wed, 15 Oct 2008 12:20:45 -0700 (PDT)
Received: from localhost.localdomain (abvr129.neoplus.adsl.tpnet.pl [83.8.215.129])
        by mx.google.com with ESMTPS id 7sm240242eyb.1.2008.10.15.12.20.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Oct 2008 12:20:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9FJKfgi021075;
	Wed, 15 Oct 2008 21:20:42 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9FJKe6n021072;
	Wed, 15 Oct 2008 21:20:40 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <bab6a2ab0810151136n4f997890qd418277ea8c4aea4@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98300>

"PJ Hyett" <pjhyett@gmail.com> writes:

[> Wincent Colaiuta wrote:]
The above attribution was missing, BTW...

> > Coming up in news at 6...
> >
> > GitHub announces new maintainer for Git
> >
> > GitHub is proud to announce the replacement of the old Git maintainer with
> > the "Git Core Team", comprising PJ Hyett, Scott Chacon, Tom Preston and some
> > select personalities from the Ruby on Rails world. You'll be able to track
> > all the latest updates to "Git Edge" over at GitHub. The former maintainer,
> > Junio C Hamano, is being retired from service because the Git community (see
> > git-scm.com) decided he wasn't as good-looking as David Heinemeier Hanson.
> > For more information, see the official Git book (book.git-scm.com).
> 
> In case there was any confusion, this is why we almost never bother
> posting to the list, because no matter what the topic, it always turns
> into why the git community hates GitHub.

Errr... for me it looks like somebodys irony detection is not working...
On the other hand it is why Scott E Fahlman invented emoticons :-)

-- 
Jakub Narebski
Poland
ShadeHawk on #git
