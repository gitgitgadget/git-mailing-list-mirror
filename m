From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Fri, 06 Jun 2008 18:46:40 +0200
Message-ID: <484969F0.1030704@gnu.org>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com> <alpine.DEB.1.00.0806051946100.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Cedric Vivier <cedricv@neonux.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 18:47:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4f6X-0005BU-Bi
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 18:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759047AbYFFQqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 12:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758992AbYFFQqq
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 12:46:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:16272 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758676AbYFFQqp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 12:46:45 -0400
Received: by fg-out-1718.google.com with SMTP id 19so722457fgg.17
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 09:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=ZM1a0hpXWICyN3/M/pAIyolP4JD7teCNIoYEYXwBZgA=;
        b=q208JWr9XVgO3dEXyFzDrDJLe5saFqeH1tH4bu6sdF8RNUtwx1FW5RqQeVfUrX+BEm
         kvxZ7LFAs7QUHq6THIne6ovFfRM4WDi7dgxxvNLypgZCJbYp13kHOdIfxWmHA8lqK8f9
         HzusQK0gTR8k11g4yoMwsK3wYdCU9VuNz3ic4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=kKpU/cJpIVNzGOeRtt41vsHciXU+oB8DpOM3z9MvbSOkU/VAda4GZn4GatNTBuokTQ
         ZP/i2p39iMNsBUdllQY80Ki4kABG636bo5E4cNKE92zI8JtCanIY6ovzZ9cAUdcPr1Am
         aT07v9gK/xH9mV6ct314iXZv1goOVmeu5aohg=
Received: by 10.86.4.2 with SMTP id 2mr664089fgd.16.1212770803795;
        Fri, 06 Jun 2008 09:46:43 -0700 (PDT)
Received: from scientist-2.local ( [213.55.131.23])
        by mx.google.com with ESMTPS id 3sm6213684fge.3.2008.06.06.09.46.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Jun 2008 09:46:43 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <alpine.DEB.1.00.0806051946100.21190@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84089>


> What about people preferring the status quo?  I think a command line 
> option would be in order.'

config option seems more useful.

Paolo
