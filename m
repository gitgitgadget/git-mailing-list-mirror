From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/2] repo-config: learn the flag "--no-local"
Date: Thu, 8 Jun 2006 16:06:17 +0200
Message-ID: <81b0412b0606080706r3d475daeoa82b9f882b53b647@mail.gmail.com>
References: <Pine.LNX.4.63.0606081331140.11910@wbgn013.biozentrum.uni-wuerzburg.de>
	 <44880BE8.40804@etek.chalmers.se>
	 <Pine.LNX.4.63.0606081340230.25911@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "=?UTF-8?Q?Lukas_Sandstr=C3=B6m?=" <lukass@etek.chalmers.se>,
	"Git Mailing List" <git@vger.kernel.org>, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Jun 08 16:06:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoL9S-0004gH-Ga
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 16:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWFHOGT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 10:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWFHOGT
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 10:06:19 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:39809 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964837AbWFHOGS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 10:06:18 -0400
Received: by py-out-1112.google.com with SMTP id x31so651407pye
        for <git@vger.kernel.org>; Thu, 08 Jun 2006 07:06:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c3YLS8xmu3TCdiMvrWg+lp7Vq7+0XLUqRwYThso9fpSIoc8A3x6NxCIZ+x1yi+74qRDaiQ0uHWpnWOrjqbQmhHubwnFy5a0sQJhseY3MQDI+FKV8oXncINlUdQGPjx3WTIyHzjNsMjYcSBI1OhzPKNNiPXI/NWUJULzds+Hv0u4=
Received: by 10.35.48.15 with SMTP id a15mr1073251pyk;
        Thu, 08 Jun 2006 07:06:18 -0700 (PDT)
Received: by 10.35.74.15 with HTTP; Thu, 8 Jun 2006 07:06:17 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606081340230.25911@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21490>

> >
> > Wouldn't it make more sense to call the flag --global ?
>
> Sure, why not? Other opinions? (I will not add a test case until this is
> resolved! ;-)
>

"--no-gitconfig" (as "--norc" in bash).
