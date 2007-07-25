From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Windows support
Date: Wed, 25 Jul 2007 10:15:03 -0400
Message-ID: <fcaeb9bf0707250715p7c183a81vc78f641eef493777@mail.gmail.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	 <fcaeb9bf0707250513v587d7a92lb688b52da3c28bb7@mail.gmail.com>
	 <Pine.LNX.4.64.0707251510130.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 25 16:15:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDhdx-0006b5-D7
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 16:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbXGYOPJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 10:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753871AbXGYOPI
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 10:15:08 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:41435 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481AbXGYOPH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 10:15:07 -0400
Received: by wr-out-0506.google.com with SMTP id i30so132805wra
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 07:15:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BHZ68z9RbTVTgCaDyCZuPs/dG+aiyqSE8xsA3YzxKbeiCprFTR7wDycP6t8won9dRPVIpXl7YAiySRH2enAqEw4qtoyJrXArLqMmflLXX7eEJWe27OpXxAp/Mo084Ir9+gDwVSSHw4VphEJMf+SqQKY9j0/kXMQhrLg45vT/vKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VReq2/eHAtrJZzxZ2l1f1JgtCz9IX3oE3qPg6TTmC7IY8UcFwt2xdy4cCaCjarMBAFFORE2He+ahDtFYPGByFzil8fxCccK9AswurKzAQMvzB9AQJ2vY/0UDDYtZ4mGhMUdzEBu23v8u+JKRKez2i/HqnhhYMc2R+mpZ3mUhERA=
Received: by 10.100.174.16 with SMTP id w16mr375977ane.1185372903919;
        Wed, 25 Jul 2007 07:15:03 -0700 (PDT)
Received: by 10.100.127.17 with HTTP; Wed, 25 Jul 2007 07:15:03 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707251510130.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53694>

On 7/25/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 25 Jul 2007, Nguyen Thai Ngoc Duy wrote:
>
> > FYI, I'm working on getting rid of msys requirement from mingw port. I
> > can't tell you how long it would take though. Could be one month or two.
>
> Is there a repo out there?

http://repo.or.cz/w/git/pclouds.git?a=shortlog;h=gitbox

There are some patches on mob I have not merged to gitbox branch yet.

-- 
Duy
