From: "Stefan Pfetzing" <stefan.pfetzing@gmail.com>
Subject: Re: [osol-bugs] access() behaves strange when used as root
Date: Tue, 23 May 2006 22:43:56 +0200
Message-ID: <f3d7535d0605231343h51bfb2c9w1d15536b92874a88@mail.gmail.com>
References: <f3d7535d0605230818l6ecb9b87gd38afc75941c5fdd@mail.gmail.com>
	 <20060523153415.GB3638@greyarea>
	 <20060523154213.GB21587@totally.trollied.org>
	 <f3d7535d0605231035p6e2d8ef8qefefe43a8b11e739@mail.gmail.com>
	 <44735D61.nail4RQ116Y06@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue May 23 22:44:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FidjU-0006JW-98
	for gcvg-git@gmane.org; Tue, 23 May 2006 22:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWEWUn5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 16:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWEWUn5
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 16:43:57 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:61462 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932163AbWEWUn5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 16:43:57 -0400
Received: by wr-out-0506.google.com with SMTP id i34so1440380wra
        for <git@vger.kernel.org>; Tue, 23 May 2006 13:43:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UFLUz9eV35OO667GsXxwBnOe46RjRLtCxDyhlAxMI9IECtLO99cf2Irxg43d1bKiXBNwzzdXLCU8gRUL54hUnlE2OUA9NC0zN8vubYje2XRtGx/oHK2uMPl50MBcUqYGZniGvPMAR6fjZ6KpmkTVFMWdOj4U/+2RaUi1HWtKS/Y=
Received: by 10.65.205.12 with SMTP id h12mr2380983qbq;
        Tue, 23 May 2006 13:43:56 -0700 (PDT)
Received: by 10.64.253.10 with HTTP; Tue, 23 May 2006 13:43:56 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
In-Reply-To: <44735D61.nail4RQ116Y06@burner>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20635>

Hi Joerg,

2006/5/23, Joerg Schilling <schilling@fokus.fraunhofer.de>:
> Before claiming that Soplaris is not behaving correctly, you should have a look
> into the standard.......

I didn't say Solaris does not behave "correctly" - I just said it does
not behave as every
other POSIX/SUS Unix I know.

> The behavior of Solaris access() is OK.

I know that its completely ok with SUS - and I did say that before.

Primarily I was just wondering about this behaviour and IMHO the git
developers were too.

bye

Stefan

-- 
       http://www.dreamind.de/
Oroborus and Debian GNU/Linux Developer.
