From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] some feedbacks from the Italian Free Translation Project.
Date: Mon, 23 Jul 2007 00:33:26 +0200
Message-ID: <4d8e3fd30707221533t76a92616lce924e47f031928d@mail.gmail.com>
References: <20070722201942.609543f1@paolo-desktop>
	 <Pine.LNX.4.64.0707222034500.14781@racer.site>
	 <4d8e3fd30707221506t43a9d3e1re2e8e19c13ee2a82@mail.gmail.com>
	 <Pine.LNX.4.64.0707222324170.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 00:33:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICjzY-0004jY-Vo
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 00:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759260AbXGVWd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 18:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758257AbXGVWd3
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 18:33:29 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:5170 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980AbXGVWd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 18:33:28 -0400
Received: by py-out-1112.google.com with SMTP id d32so2990569pye
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 15:33:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e+fP6XrbVwcN4X3b3D4SwNRnJQamciKVLAW1K9de+DdM9CurZdE7V0pbCcqhlAOVb7yKhS8JXnLJu3lUhOUrNLog9SHRQIYzvtr2W9686EFUisEztdoincqfPn6cOmolxICN4drZO7+w7+PP0VVcMW0eIgq6PZwufCvyq4HCXWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C0JJH5FAxOtC2KkjkrkkZ39jZU1JHFxhJtAiUmRyl06RMWXG5G0VhK2FjKujDwp01VuFuJX73BVu1fq5Hy/ExMC95lF5Qz3hAOL9rceO7u9+xWbrJPCTRL1DfeAksESpaE3GakPB9O1KjOBHYv5XdAKGZpXzMVJMOd+aLmgu4+U=
Received: by 10.143.1.2 with SMTP id d2mr178515wfi.1185143606567;
        Sun, 22 Jul 2007 15:33:26 -0700 (PDT)
Received: by 10.142.86.9 with HTTP; Sun, 22 Jul 2007 15:33:26 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707222324170.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53357>

On 7/23/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
[...]
> > > Thanks.  Both of your patches applied, although I had to fix non-UTF-8
> > > encoding.  This could well be a problem on my side.
> >
> > Odd.
> > Is there anything I should check in my box?
>
> I guess that your system is set to iso-8859-1, since even your mailer says
> "Content-Type: ... ISO-8859-1".  Also, your content is "quoted-printable".
>
> For the time being, I can convert your patches, but you might want to
> consider switching to UTF-8.

paolo@paolo-desktop:~$ locale
LANG=en_US.UTF-8
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL=

I guess the problem is in my mailer, which is Sylpheed-Claws.
No idea how to change that, Google will be my friend :-)

Thanks!

Ciao,
-- 
Paolo
