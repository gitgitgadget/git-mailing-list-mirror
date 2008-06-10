From: "Denis Bueno" <dbueno@gmail.com>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 15:42:38 -0400
Message-ID: <6dbd4d000806101242s23e79a4fyfeb7ae0a40b1078f@mail.gmail.com>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>
	 <alpine.LFD.1.10.0806101537440.23110@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 21:43:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K69kp-0008AQ-5X
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 21:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258AbYFJTmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 15:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754248AbYFJTmq
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 15:42:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:8771 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346AbYFJTmp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 15:42:45 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1893460fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 12:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Q9IHspajv3+e/cEe7e799ZL1doKx+A8umXYHNTQnblU=;
        b=TdZHC/lqp1DMjsKS+uMjDhwTVZAxL4gkwh79Idq/HeNxkrk7+BHAJ2RJNXc/Op0GeZ
         fRc41he6/6Ac0pZwhgJKVcY5uT+Y+3bJnEHtYlROgfq1YbEOMieHvvHaLTz5WRJxQZLB
         3woWrWQVzKKsGzbr8oHbqkOfYkLSeWXIoQo/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=km3BRVvyQXmurCSOvsGzBuw63txF4VpOY1xtFwKIIfCy7rARX3I9UjzZEOeQ4T6kpw
         M0gT+osOn9266TdeT409HTzzE03yBx5QcwcS7b2+fdc6eI83HFqqOwU7TqRBJJBtmgSh
         o7WXSmy5ITLFwqwNsak4LpyF4j8B5vrHlfcYY=
Received: by 10.86.87.13 with SMTP id k13mr6173605fgb.38.1213126958814;
        Tue, 10 Jun 2008 12:42:38 -0700 (PDT)
Received: by 10.86.59.7 with HTTP; Tue, 10 Jun 2008 12:42:38 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0806101537440.23110@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84539>

On Tue, Jun 10, 2008 at 15:40, Nicolas Pitre <nico@cam.org> wrote:
>> (Ironically, at the moment I ran into the corruption I was trying to
>> push my repo to a backup location.)
>
> Would you happen, by chance, to have another instance of that repository
> somewhere else with the concerned objects in it?

Nope.  I was *just* about to back it up.

-- 
                              Denis
