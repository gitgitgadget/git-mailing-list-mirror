From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 00:11:48 +0100
Message-ID: <46d6db660701291511v700bfcf7l4851dd6be4fc6e03@mail.gmail.com>
References: <200701292320.43888.johannes.sixt@telecom.at>
	 <20070129223513.GA31372@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <johannes.sixt@telecom.at>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 00:11:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBffF-00088y-K6
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 00:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbXA2XLu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 18:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbXA2XLu
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 18:11:50 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:17594 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964852AbXA2XLt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 18:11:49 -0500
Received: by an-out-0708.google.com with SMTP id b33so803293ana
        for <git@vger.kernel.org>; Mon, 29 Jan 2007 15:11:49 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rW/cvDEVWHNPpbPy4cFfNBFGxkCybzUGOvijnaPdeBaELY1X960H05QVcs63mLgiOvSK6cy2EeE7nkPn5KX10upuMN+873n2/KM+XyslR4hqiB1Wzd14dh/TXQDGqG6N1/oiYN1eiS+E+MOmb+qbGhTr6GmeHxUR3N9jZYMqIco=
Received: by 10.114.195.19 with SMTP id s19mr318499waf.1170112308911;
        Mon, 29 Jan 2007 15:11:48 -0800 (PST)
Received: by 10.115.16.9 with HTTP; Mon, 29 Jan 2007 15:11:48 -0800 (PST)
In-Reply-To: <20070129223513.GA31372@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38111>

On 1/29/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Johannes Sixt <johannes.sixt@telecom.at> wrote:
> > I'd like to point interested parties to the MinGW port at
> >
> >  git://repo.or.cz/git/mingw.git
> >
> > which is now in a usable state, methinks. I'm using it with git-gui and gitk
> > on a (almost) production repository.
>
> Well, that's pretty sweet that git-gui is working in a MinGW case.
>
> Last night I pushed out a number of changes to avoid cygpath when
> we don't have it in PATH (commit 20ddfcaa).  Were you testing with
> that version, or something earlier?
>

my last compilation is less than 8 hours old, and I do not have cygwin
installed. What is it you want to test actually ?

git-gui and gitk have been working for a bit more than a week, if I
recall well. I'd like to see git-blame latest patch work with git-gui.

:)

-- 
Christian
