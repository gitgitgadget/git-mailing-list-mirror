From: "Andrew Kilroy" <lemonkandy@gmail.com>
Subject: Re: attempting to clone the git repo
Date: Fri, 9 Mar 2007 09:51:14 +0000
Message-ID: <2fb03ecb0703090151j10842263off743be1f86bf9c3@mail.gmail.com>
References: <2fb03ecb0703080849m41ac8158y4895f2bc811934f5@mail.gmail.com>
	 <Pine.LNX.4.63.0703081828500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7v649ba89l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 09 10:51:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPbkv-0007OE-Iw
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 10:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993091AbXCIJvR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 04:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993097AbXCIJvR
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 04:51:17 -0500
Received: from wr-out-0506.google.com ([64.233.184.228]:33054 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993091AbXCIJvP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 04:51:15 -0500
Received: by wr-out-0506.google.com with SMTP id 71so1239497wri
        for <git@vger.kernel.org>; Fri, 09 Mar 2007 01:51:15 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g0M+Y5eFeaCGAG4tScunCiSxUHp+BR42wzELFuXxhpqlkIUeyc1EKNqGrQKU0R2XKNGyhjlW83WVfz+YdJLERK6j7XyR2B9hUrmNROeRi94ct8cNCNMsICA0kQ6pwgqMxuAqhvavlG9HpZ4Aw7rrUxmzhiE4EYmTr2QUdvCEp6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X1c2EXNZqn6L9cALgc7GztwHX27T3xd38KWUEMbsTlgSTOwa1Qw3g4PaJCXlYSS22YHVqSJPdeP0VyVTeV6FXb7NZaT3gsXMZ5mSYcmqHA98Tv1gySCrSs+3uAuG3j/UM6hEfOOrWhvqCdf0tcUmwmeNNBW04uSUCK33uFk1Bo0=
Received: by 10.114.137.2 with SMTP id k2mr468324wad.1173433874936;
        Fri, 09 Mar 2007 01:51:14 -0800 (PST)
Received: by 10.114.166.4 with HTTP; Fri, 9 Mar 2007 01:51:14 -0800 (PST)
In-Reply-To: <7v649ba89l.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41791>

On 08/03/07, Junio C Hamano <junkio@cox.net> wrote:
> I've always thought that for http transfer the hostname was not
> git.kernel.org but www.kernel.org, as in:
>
>         git clone http://www.kernel.org/pub/scm/git/git.git/
>

That worked, thanks.

I thought there were more branches though (pu, todo...).  I can only
see master via 'git branch'.  I'm not that familiar with git yet, so I
might be missing something obvious here.

Andy
