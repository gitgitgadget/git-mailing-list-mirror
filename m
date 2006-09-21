From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Git Survey summary
Date: Thu, 21 Sep 2006 23:49:52 +0700
Message-ID: <fcaeb9bf0609210949l3d7e6e1ch825d2ef31caae89a@mail.gmail.com>
References: <fcaeb9bf0609120205m38a44571we21e05864c04a731@mail.gmail.com>
	 <fcaeb9bf0609210712i125822c4gf8af3ecccdbd3d13@mail.gmail.com>
	 <eeuapj$mgn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 21 18:53:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQRkK-0001hQ-Ui
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 18:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWIUQty (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 12:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWIUQty
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 12:49:54 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:23910 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751336AbWIUQtx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 12:49:53 -0400
Received: by wx-out-0506.google.com with SMTP id s14so722558wxc
        for <git@vger.kernel.org>; Thu, 21 Sep 2006 09:49:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AhfGKevUxkakbptwARXf8hNW+BXHPlb6QsaAqZUYf1x9vzM/8OO1uyNRCXaCqQ1fYezkyB2Sr+IE9+wyQDzjeLtlHy58fedUOGVEMQhAg6X9Ewc3Yj964CHeDBAs6m1F8toouVcwnbmbsi20EJSKI7cFGJQH2+WXGv4GN74eoZY=
Received: by 10.70.8.20 with SMTP id 20mr27321552wxh;
        Thu, 21 Sep 2006 09:49:52 -0700 (PDT)
Received: by 10.70.45.19 with HTTP; Thu, 21 Sep 2006 09:49:52 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <eeuapj$mgn$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27490>

On 9/21/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Nguyen Thai Ngoc Duy wrote:
>
> > - A place to post bugs and feature requests (if bugzilla is too big,
> > maybe mantis?)
>
> Isn't this mailing list the place to post bugreports and feature requests
> (and of course patches)?

Because it's harder to keep track of a long-living bug/request which
spans many threads. I think git mailing list is for git development
and helping users. It's not clear it should be a place to request
features. I'm still wondering why people requested a lot in the survey
while more than half subscribed to the mailing list. I personally feel
the mailing list is a place for _contributing_ features (thoughtful
ideas or patches) not just requesting features (desires without no
clear idea how to implement it).
Anyway it's still good to clearly state the git mailing list is for
discussion, bug reports and feature requests in git.7 man page
(together with git homepage maybe)

>  Any bugtracker has to be tied to mailing list, and
> perhaps also two-way to gitweb (gitweb making links to bugtracker issues,
> bugtracker having links to gitweb; perhaps incrementing revision
> numbers...).
Ruby (or YARV, I don't remember exactly) uses a bug tracking system
that depends heavily on mailing lists (open bug with a mail, close bug
with a mail ...). The benefit is that we have at least bug numbers :-)

> --
> Jakub Narebski
> Warsaw, Poland
> ShadeHawk on #git
--
Duy
