From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Add a Documentation/git-tools.txt
Date: Mon, 20 Feb 2006 07:21:42 +0100
Message-ID: <e5bfff550602192221v65a50896r639ce0e7234ada84@mail.gmail.com>
References: <e5bfff550602190200j1ef3858as6a1564064dc81fef@mail.gmail.com>
	 <20060220020147.GB8759@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Feb 20 07:21:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FB4Qd-00005Z-3h
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 07:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbWBTGVn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 01:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbWBTGVn
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 01:21:43 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:11291 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932664AbWBTGVn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 01:21:43 -0500
Received: by wproxy.gmail.com with SMTP id 70so820133wra
        for <git@vger.kernel.org>; Sun, 19 Feb 2006 22:21:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IQOKTq2vOB/VARCWBYuR5iSRbp83Vl+GaHKY6ntfR/StcIitJJ7WGfJOayz0Udn0ZiMmTeKko5GP6iAKsvucE6DVYepb78md15IE8i2Xc1aVjq5AT0X6ZYsDH+SbScjiKBzi1bw46+Og3lDdvff3djqMpOZxbkxSpX/hdXRYGDA=
Received: by 10.65.183.18 with SMTP id k18mr506736qbp;
        Sun, 19 Feb 2006 22:21:42 -0800 (PST)
Received: by 10.64.131.15 with HTTP; Sun, 19 Feb 2006 22:21:42 -0800 (PST)
To: "Jonas Fonseca" <fonseca@diku.dk>
In-Reply-To: <20060220020147.GB8759@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16467>

On 2/20/06, Jonas Fonseca <fonseca@diku.dk> wrote:
> Marco Costalba <mcostalba@gmail.com> wrote Sun, Feb 19, 2006:
> > +     - *gitview*  (contrib/)
> > +
> > +            gitview is a GTK based repository browser for git
> > +
> > +
> > +     - *gitweb* (ftp://ftp.kernel.org/pub/software/scm/gitweb/)
> > +
> > +            GITweb provides full-fledged web interface for GIT repositories.
>
> You can make it more asciidoc-friendly if you convert the list to use
> the format:
>
> *gitview* (contrib)::
>
>         gitview is a GTK based repository browser for git
>
> ftp://ftp.kernel.org/pub/software/scm/gitweb/[*gitweb*]::
>
>         GITweb provides full-fledged web interface for GIT repositories.
>
> --
> Jonas Fonseca
>

Thanks, I will change the format.

I am waiting to collect some more comments so to change git-tools.txt only once.

Marco
