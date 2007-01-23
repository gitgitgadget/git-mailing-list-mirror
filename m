From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 16:45:58 +0100
Message-ID: <81b0412b0701230745g4b18747ep73d37674a969c1aa@mail.gmail.com>
References: <200701192148.20206.johannes.sixt@telecom.at>
	 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>
	 <Pine.LNX.4.64.0701220823260.32200@woody.linux-foundation.org>
	 <Pine.LNX.4.63.0701231220470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0701230736180.32200@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Christian MICHON" <christian.michon@gmail.com>,
	"Johannes Sixt" <johannes.sixt@telecom.at>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 16:46:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9Nqe-0003Dr-Gq
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 16:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932955AbXAWPqI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 10:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932939AbXAWPqI
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 10:46:08 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:4415 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932596AbXAWPqG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 10:46:06 -0500
Received: by wr-out-0506.google.com with SMTP id 70so1113803wra
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 07:46:06 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B63B+HSrbgeH0Wu1YkkHVxD/joUK5NmYvW8NRvM1NSc82Gsjyo/7UWn0jN5icPZY1gUrRoZgI8zafnmBmAsBCFU87wMMmz/CDvqaY34hP4YS5x/Hqcx7v93IVw52BBGlinGhXck8xLUvlcqrJFVIKONeJ3CwZ2DSZ7lUhfV4otg=
Received: by 10.78.203.13 with SMTP id a13mr420465hug.1169567158826;
        Tue, 23 Jan 2007 07:45:58 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Tue, 23 Jan 2007 07:45:58 -0800 (PST)
To: "Linus Torvalds" <torvalds@linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0701230736180.32200@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37535>

On 1/23/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > Lucky you! Fortunately, I don't have any Windows at home (but I still have
> > windows, thank God!). So I cannot even be tempted to work on this thing in
> > my free time.
>
> Actually, I have been seriously wondering if there is some setup under
> Wine that I could run, just so that I'd see the Windows development
> environment for git.

You have to stea... purchase large parts of windows to get enough
of it to be able to develop on it. I tried to run installers under
Wine: nothing worked until the not-to-be-mentioned parts
(ok, the whole "Windows" and "Program Files"  directories from an
existing installation) were provided. I didn't tried cygwin, though.

> Has anybody tried anything like that?

Why would anyone want to try anything like that?
