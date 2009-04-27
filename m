From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Add Russian translation to gitk
Date: Mon, 27 Apr 2009 13:32:34 +0400
Message-ID: <20090427093234.GD15723@dpotapov.dyndns.org>
References: <20090426132452.GB30825@blimp.localdomain> <20090427083953.GB15723@dpotapov.dyndns.org> <81b0412b0904270220h598fa451vb3ff30f23dd5eab3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 13:39:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyNED-0007PI-2L
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 11:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbZD0JdJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Apr 2009 05:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbZD0JdG
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 05:33:06 -0400
Received: from mail-qy0-f112.google.com ([209.85.221.112]:58264 "EHLO
	mail-qy0-f112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbZD0JdD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 05:33:03 -0400
Received: by qyk10 with SMTP id 10so1357155qyk.33
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 02:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bTTZfAYoNIekPByWDNoEDaQXxx/WX+hlCkZrbAaJ+l8=;
        b=AW6kpbMonzBUkPex8ByEk9/ZTNrefUX7PgHVw4uHOHZvfVtPsdvf+9/LK0tmT3d1Kl
         xAQVeWVQZGugeDYu1bfUUmSLambVGnO4rm8N+sVNIRsZj3rYZnwUcp2qEss5o3zdzO9A
         H8qHB0lodpMcn6wohZnD2O4btOYy0qsA9/uE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=aQ0gjZrwVHK9q4driU3YcpnQ73qMs7KOQWabqPeV7s0G9MWpyz+fR+g7lihn5JYo3l
         1aoTQtVTXpZIbvFkHSgZGFlFuSvVjVcceypE7rZvcZpRFd0wBLThTkZCV4+6N3Rxy2ME
         IypxGm13Pw44g+lPZNDElJ5oifqnakYoIPPTQ=
Received: by 10.224.60.207 with SMTP id q15mr5500549qah.193.1240824782694;
        Mon, 27 Apr 2009 02:33:02 -0700 (PDT)
Received: from localhost ([91.78.48.223])
        by mx.google.com with ESMTPS id 7sm6356376qwf.5.2009.04.27.02.33.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Apr 2009 02:33:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <81b0412b0904270220h598fa451vb3ff30f23dd5eab3@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117663>

On Mon, Apr 27, 2009 at 11:20:37AM +0200, Alex Riesen wrote:
> 2009/4/27 Dmitry Potapov <dpotapov@gmail.com>:
> >
> > I think "Check out this branch" should be translated as "=F0=C5=D2=C5=
=CB=CC=C0=DE=C9=D4=D8
> > =D2=C1=C2=CF=DE=C9=CA =CB=C1=D4=C1=CC=CF=C7 =CE=C1 =DC=D4=D5 =D7=C5=
=D4=D7=D8" (which literally means: Switch worktree
> > to this branch).
>=20
> That looks too long (in a drop-down menu). How about
> "=F0=C5=D2=C5=CB=CC=C0=DE=C9=D4=D8=D3=D1 =CE=C1 =DC=D4=D5 =D7=C5=D4=D7=
=D8"? IOW, drop the "worktree".

It is fine.


Thanks,
Dmitry
