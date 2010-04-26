From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/3] pretty: make %H/%h dependent on
 --abbrev[-commit]
Date: Mon, 26 Apr 2010 05:19:11 -0500
Message-ID: <20100426101911.GA8841@progeny.tock>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-3-git-send-email-wmpalmer@gmail.com>
 <20100426031012.GA29953@progeny.tock>
 <u2i5b9751661004260047n168ad87bx6083fc201bfb21d9@mail.gmail.com>
 <20100426095206.GA31483@progeny.tock>
 <p2w5b9751661004260313kd1b809earb8d9fd8c4d09adef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Thomas Rast <trast@student.ethz.ch>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 12:18:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6LOW-0000IU-7m
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 12:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119Ab0DZKSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 06:18:22 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49006 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013Ab0DZKSV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 06:18:21 -0400
Received: by pwj9 with SMTP id 9so8161039pwj.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 03:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=nROasxID7QEYY4KbJfltxR2xNaVrnptcAyg2GfTXgEY=;
        b=t6AqTtrEwUD+oUq+nUQnLBBPeRxyXLDmUFcX3IiiVZPVTXlXoh6c5mqUIY5X1nLhNP
         +P8ykz9jHhLosbzJ4Kstutb5wduW4bMc+Md9dWtJWbsbP8atziJcRGB33Z9Me0shfRQm
         Z/fbijSxw5DdvRJJKcqLlhN9he4OupRwBFUvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BA/7pkFRFWeCE8xq1c78gsWYIBrDvXDmbXmRhzyHMEuObtCzH9hESUQ9cB4Ei06ZYP
         o03QsJ3qTduB4Ao9cPsgP6UQLT6zYE2F9v+uT2V1BfAPkpgOqlY3/26UrJTFq55YFJh9
         S+09l7iJ7+YbRm4rvkAdRl3HqNOte1quYLqgs=
Received: by 10.141.2.9 with SMTP id e9mr3262396rvi.51.1272277101547;
        Mon, 26 Apr 2010 03:18:21 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm3030717iwn.13.2010.04.26.03.18.19
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 03:18:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <p2w5b9751661004260313kd1b809earb8d9fd8c4d09adef@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145808>

Will Palmer wrote:

> I wasn't sure if you intended this to be submitted as a separate
> series or added on top of my series,
> as my mail client grouped them together (I really need to stop using
> gmail for the mailing list...).

I sent it as a reply, but the patches are against master.  The last of
the four patches is from your series with a few small changes and its
in-message From: line is set accordingly.  Sorry for the confusion.

Jonathan
