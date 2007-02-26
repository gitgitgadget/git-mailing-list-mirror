From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit-1.5.5
Date: Mon, 26 Feb 2007 07:19:50 +0100
Message-ID: <e5bfff550702252219m352c03ady2d810e051bd62a37@mail.gmail.com>
References: <e5bfff550702250958n6cddc5b5lec4badf1f7fc8231@mail.gmail.com>
	 <46a038f90702251623h5944a085m514418cb5f530e7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 26 07:19:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLZDI-0000qM-2y
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 07:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933774AbXBZGTw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 01:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933776AbXBZGTw
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 01:19:52 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:17348 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933774AbXBZGTv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 01:19:51 -0500
Received: by wr-out-0506.google.com with SMTP id 58so1373826wri
        for <git@vger.kernel.org>; Sun, 25 Feb 2007 22:19:51 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qcjj/Gto2fb7Qn/vQnApc2c+OpKM9eW0RBTh6b1ka0+RZA8eU533vE/6P2sksZEZjQqc3UA88bYhKAwXTVkIgh+wmJxIO4CCZNci7I6UNANpBUoEzORpwVHZXby5gQlSYF9bb7uKVw95BMA3u2HTuxnaP0UBfgLhP12d8MdGJ0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eMttFyDezDZ4UpSUlaCmCUiIgS36f5EOQ5rlSCV0Se2KrVgWg70sYi+NrN6vNJt2C6/ot03+MDtnoucJ1CEJ8ta8aE1wt6PZyS/LXq4ygZX0lvzbfv91QL0gVuvppUhFvudzHeOjP6sFdYbmyOCccMu1oTW5yFzmjwFFUPs86rE=
Received: by 10.114.137.2 with SMTP id k2mr532653wad.1172470790426;
        Sun, 25 Feb 2007 22:19:50 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Sun, 25 Feb 2007 22:19:50 -0800 (PST)
In-Reply-To: <46a038f90702251623h5944a085m514418cb5f530e7f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40612>

On 2/26/07, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 2/26/07, Marco Costalba <mcostalba@gmail.com> wrote:
> > P.S: There is also a Qt4 version (works under Windows) downloadable
> > from git://repo.or.cz/qgit4.git  it is a little bit experimental
> > tough.
>
> Is the QT4 Windows port working against the MinGW port of GIT?
>

Yes, Qt4Windows does not need cygwin at all and is compiled itself with MinGW.


Marco
