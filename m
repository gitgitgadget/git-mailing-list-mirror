From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: MinGW port - initial work uploaded
Date: Thu, 8 Feb 2007 15:06:30 +0100
Message-ID: <46d6db660702080606u58a6233l61d1f56faf7eac3@mail.gmail.com>
References: <200701192148.20206.johannes.sixt@telecom.at>
	 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>
	 <Pine.LNX.4.64.0701220823260.32200@woody.linux-foundation.org>
	 <46d6db660701221425i672e826coc9eef4bd8d22ae9d@mail.gmail.com>
	 <45CADCB7.5050107@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Johannes Sixt" <johannes.sixt@telecom.at>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 15:06:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF9v2-0006xd-V6
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 15:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161222AbXBHOGc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 09:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161418AbXBHOGc
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 09:06:32 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:23614 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161517AbXBHOGb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 09:06:31 -0500
Received: by wr-out-0506.google.com with SMTP id 68so515198wri
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 06:06:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DrjFs3oLzNwXxabtKdf0sSzS9gj9dY3Afaav+sflmOhF2eup6y67QCTIJHqkdC9IZ3FDXZy2cCINdLAtfHyxekHnfVlS4PcFiwuZA9ECuTEJsuWjvbDrBvmZYIxUAAcQ74k8twZfw9RvdxlmaJ5Vg8eT8ZXa2aKIjBJGu+FhBok=
Received: by 10.114.199.1 with SMTP id w1mr3025610waf.1170943590945;
        Thu, 08 Feb 2007 06:06:30 -0800 (PST)
Received: by 10.115.16.8 with HTTP; Thu, 8 Feb 2007 06:06:30 -0800 (PST)
In-Reply-To: <45CADCB7.5050107@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39058>

I know that. I meant efficient alternative...

On 2/8/07, H. Peter Anvin <hpa@zytor.com> wrote:
> Christian MICHON wrote:
> >
> > the only recent alternative on Windows I came with was to run git
> > through coLinux and share directories using cofs.
> >
>
> Actually, git has been working on Cygwin for years.
>
>        -hpa
>


-- 
Christian
