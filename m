From: Alberto Patino <pato.lukaz@gmail.com>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Fri, 30 Sep 2005 10:10:57 -0500
Message-ID: <4489a22a0509300810y723e5ef5tb9109a29508a1e38@mail.gmail.com>
References: <433BC9E9.6050907@pobox.com>
	 <7virwjegb5.fsf@assigned-by-dhcp.cox.net> <433D1E5D.20303@pobox.com>
	 <200509301402.46740.oliver@neukum.org> <433D447E.9030103@pobox.com>
Reply-To: Alberto Patino <pato.lukaz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Oliver Neukum <oliver@neukum.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 17:12:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELMXO-0000pu-6Z
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 17:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbVI3PK6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 11:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbVI3PK6
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 11:10:58 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:29930 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030309AbVI3PK5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 11:10:57 -0400
Received: by zproxy.gmail.com with SMTP id 13so1009517nzn
        for <git@vger.kernel.org>; Fri, 30 Sep 2005 08:10:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YHaSUMoDOS8wtdMAC1are2IJsJAK9yqDK6QaKp05TZBDZ5Pf4HC7rksWLlQgiXVSFqE3SDVFcNXt0h5kdPSRv1gwII3ObPelgs4he8NHipxMujeSu0buerGkhiuFzCU5m9BYIFGjxXBX362kvm2bzBLc53ix93KJkPnxtE9/qEI=
Received: by 10.36.12.9 with SMTP id 9mr5687568nzl;
        Fri, 30 Sep 2005 08:10:57 -0700 (PDT)
Received: by 10.36.65.20 with HTTP; Fri, 30 Sep 2005 08:10:57 -0700 (PDT)
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <433D447E.9030103@pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9564>

On 9/30/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> Oliver Neukum wrote:
> >
> > The error is still there.
> >
> > oliver@oenone:~/linux-2.6> git checkout -f master
> > usage: read-tree (<sha> | -m <sha1> [<sha2> <sha3>])
>
> Something's wrong with your installation, not the instructions.  Works
> fine here.
>

Right , you must have a corrupted copy of the git repo. Do the initial
cloning of the linux repository again, and then retry the git
checkout.
