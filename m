From: "Robin Luckey" <robinluckey@gmail.com>
Subject: Re: Re: git-log output changed from 1.4.0 -> 1.4.1?
Date: Thu, 6 Jul 2006 15:09:40 -0700
Message-ID: <761519800607061509j32275d4cjf270213cd9814dd9@mail.gmail.com>
References: <761519800607061451n9473ad4oa9e2781517ca9389@mail.gmail.com>
	 <7vlkr65rbo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 07 00:09:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fyc2b-0006V7-Ka
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 00:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWGFWJm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 18:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWGFWJm
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 18:09:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:33562 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750814AbWGFWJm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jul 2006 18:09:42 -0400
Received: by ug-out-1314.google.com with SMTP id a2so2860773ugf
        for <git@vger.kernel.org>; Thu, 06 Jul 2006 15:09:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tk7N7T+9om3RPRV/5byR9hSzQ1TIoNnPfKVtHgrX1BwSF8/bgcvGn1ceLHJDaAEK1uEk4NwWqKSBKNuv9iNXva8S8EhfsFOHVayLFuHIBn6Tic6TR7YgAQMDh6r93o8rYS6SCRHGqer3ueHXC4M4JwGVUQbOKOMZcNS/jtRlAe0=
Received: by 10.66.221.19 with SMTP id t19mr1243218ugg;
        Thu, 06 Jul 2006 15:09:40 -0700 (PDT)
Received: by 10.66.220.13 with HTTP; Thu, 6 Jul 2006 15:09:40 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <7vlkr65rbo.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23407>

> In the meantime, "git log --raw -r ..." would give you want you
> want, I think.

This did the trick! Thanks for the quick responses.

Robin
