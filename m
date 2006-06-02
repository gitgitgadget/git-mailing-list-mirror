From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Importing Mozilla CVS into git
Date: Fri, 2 Jun 2006 16:14:28 +1200
Message-ID: <46a038f90606012114m5d6d0d66r9ecd3dea0581d7a4@mail.gmail.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 06:14:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fm13Q-0002qx-Ag
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 06:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWFBEO3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 00:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWFBEO3
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 00:14:29 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:31927 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751307AbWFBEO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 00:14:29 -0400
Received: by wr-out-0506.google.com with SMTP id 36so503509wra
        for <git@vger.kernel.org>; Thu, 01 Jun 2006 21:14:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jzVC2aNIPf9sO49sfg7GHbtt4CjEhaADCxgwGyIAW8pCntcq2lewTH/HcbygTZr4vw+J6xUMERLlNvtJnQoqP7EoE511jZu8ra8TpzzFRcHqR3CdJ2d4WRVOyAu6X+uJIIHMnHKwQELcLuzO+9HxqpSvnSk1CQuJ1CJmfXTXrf8=
Received: by 10.54.76.12 with SMTP id y12mr1387653wra;
        Thu, 01 Jun 2006 21:14:28 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Thu, 1 Jun 2006 21:14:28 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21143>

Jon,

> Is anyone interested in helping out with this? My knowledge of git and
> CVS is limited. Mozilla CVS is about 3GB and it is available via
> rsync. I can post the parsecvs changes if wanted.

Fetchin it now, I'll definitely have a play. Have you tried with a
recent git-cvsimport? In the last 2 weeks it's seen a lot of
performance & scalability improvements as we were importing the
gentoo-x86 tree.

Grab the latest 'master' branch from Junio and give the import a go.

cheers,



martin
