From: Howard Miller <howardsmiller@googlemail.com>
Subject: Re: How to ignore changes on remote
Date: Tue, 23 Mar 2010 14:13:29 +0000
Message-ID: <26ae428a1003230713y12f0c74dh3b22c0d97565159b@mail.gmail.com>
References: <26ae428a1003230654m50c35caci4a02e2df321f289c@mail.gmail.com>
	 <1269353235.14299.0.camel@kheops>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: sylvain@abstraction.fr
X-From: git-owner@vger.kernel.org Tue Mar 23 15:13:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu4rR-0005bT-Fb
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 15:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751Ab0CWONc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 10:13:32 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:47297 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365Ab0CWONb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 10:13:31 -0400
Received: by ewy8 with SMTP id 8so454137ewy.28
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 07:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=7Mg1tN9i3h1JzYxZLMi956q+9Bv3RnCR7jsnKpwRMJ0=;
        b=uNyQtK5Q+mfaUvb1uYKbPm6PDEvIWm62A4U6SiZoqnyBk1W8BuWp4CPWcuy2EVDnXW
         /ZXxygnVrCsz2hjuQF/5/p/mPR0/+odsYSJdHHF5N96ZgN4c4I2UFDS8KDyyRLB7FtpX
         YzUwCbSWIdJghHCZrCntoC45FD/OvFsOpkQfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hGLwq/AsMMqjUpNVGV3/HmA6xOX/S1torMEIG5ZX4N95QEsX6t5R5Yw6NmXpurWK+m
         uhxC9OJGWUwWTOmOBWMC2CpAtec+Qk84UollsUCrwxbFITIAp+DewUqu3l/8krHss5jU
         /NjE9lged9K2O66L3gMNL/jATPPY85cs9IiZI=
Received: by 10.239.137.12 with SMTP id j12mr138972hbj.115.1269353609606; Tue, 
	23 Mar 2010 07:13:29 -0700 (PDT)
In-Reply-To: <1269353235.14299.0.camel@kheops>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143017>

>
> git push origin +local_branch:remote_branch
>

Thanks!

Tell me more about that '+'. I've never heard of it before. Can't see
anything in the docs (although I'm probably not looking in the right
place)
