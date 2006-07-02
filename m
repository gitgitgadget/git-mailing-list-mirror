From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [POSSIBLE REGRESSION] Spurious revs after patch "revision.c: --full-history fix"
Date: Sun, 2 Jul 2006 23:23:39 +0200
Message-ID: <e5bfff550607021423n34f1c407qec67b9f86a0d6381@mail.gmail.com>
References: <e5bfff550607020519k6007f41bne34d10c0e919f3c8@mail.gmail.com>
	 <Pine.LNX.4.64.0607021012180.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 23:24:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx9Px-0008L6-JW
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 23:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWGBVXk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 17:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWGBVXk
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 17:23:40 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:1454 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750856AbWGBVXj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 17:23:39 -0400
Received: by py-out-1112.google.com with SMTP id n25so1167815pyg
        for <git@vger.kernel.org>; Sun, 02 Jul 2006 14:23:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l+Nsv3QPQeyYkWqe/XrXmhP/Gdw3x/WU86wUOtvW9XTvZpMIzXfWf91EwmIoLW7wi8KLtV62UKJH6Vz8OzviV6y/FXvjt7e3BWDD5ip5/GhoFPU57w0YZHF+hXgGNhlzEKUtvN6BRgHALW4IWG96Ibn0qur5v4wNgXOrGJSSy3A=
Received: by 10.35.127.15 with SMTP id e15mr2248652pyn;
        Sun, 02 Jul 2006 14:23:39 -0700 (PDT)
Received: by 10.35.52.17 with HTTP; Sun, 2 Jul 2006 14:23:39 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607021012180.12404@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23121>

>
> Gaah. Does this trivial patch fix it for you?
>

Yes. It works.

Thanks
Marco
