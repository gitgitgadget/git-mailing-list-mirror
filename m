From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 1/3] Human friendly git: accept imperative mood.
Date: Sun, 1 Apr 2007 09:06:23 +0100
Message-ID: <200704010906.24429.andyparkins@gmail.com>
References: <7vmz1t557v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Sloof Lirpa <sitemaster@cox.net>, Junio C Hamamo <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 01 10:09:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXv7r-00042a-0i
	for gcvg-git@gmane.org; Sun, 01 Apr 2007 10:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbXDAIJT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Apr 2007 04:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbXDAIJS
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Apr 2007 04:09:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:32023 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098AbXDAIJR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2007 04:09:17 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1239858uga
        for <git@vger.kernel.org>; Sun, 01 Apr 2007 01:09:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qV874xnTv8eT0XXrv3uM7mN74eD4g8AqiB9JgcFWbFDtj8XhJswkv6kc1WdSnXvD3pMsa3nyGQF3+nh/jyE3LRL2WvHD2nUddPOPrYhGMxu/ntQjK1rfCCgR0msz9I+OD99K1CEtYSdNcc9mrqnLZNS70P/4xX5kOukMF/16laM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZQxCc4a6Rg9RVR9MSEY9SRQJZxnmSs3cuCPk/kz0jT9zFCJiIvUrWTCerJ30XCYolWerzGMQYm2AWsS1a+VUoTgKaLJKosKN7yzs8tInDmLfOeLofvct48jSiPLA5qM3f5JYbEn/jlLva+UdK7U3mS9YLmlCvjvpq8Z7c+o3HaQ=
Received: by 10.66.232.10 with SMTP id e10mr3331496ugh.1175414955939;
        Sun, 01 Apr 2007 01:09:15 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id k30sm5494013ugc.2007.04.01.01.09.13;
        Sun, 01 Apr 2007 01:09:14 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7vmz1t557v.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43585>

On Sunday 2007, April 01, Sloof Lirpa wrote:

> With this patch, you can now say:
>
> 	$ git, fetch $URL

I assume your next patch will be:

 $ git north
 git: you are in the cellar
 $ git look
 git: you have a series of windy source code, all alike.  Commit?


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
