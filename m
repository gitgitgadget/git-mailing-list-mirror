From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 09:26:37 +0200
Message-ID: <46d6db660610170026i23f53e66sae8fb10ea572712a@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <45340713.6000707@utoronto.ca>
	 <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	 <200610170155.10536.jnareb@gmail.com>
	 <Pine.LNX.4.63.0610170157270.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0610161714590.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 17 09:26:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZjLa-0001SD-4C
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 09:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWJQH0k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 03:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWJQH0k
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 03:26:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:39636 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932188AbWJQH0j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 03:26:39 -0400
Received: by nf-out-0910.google.com with SMTP id c2so199239nfe
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 00:26:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GiEeNVR+CpyIxSok8t0IZ1cqbU/yOZWT1PPyivO48eQLI9lnhnvYcbWnzdiW6epg0Ze87vcpsjHvwaGF1i4o20Q67J8QWQwmK4/0TqVF1z/jDsZSfZrBavTWD40tjUN7eJDxQT4gQutBEhq2lQmRvCwBzaEXfLlF8+uYxk52ufQ=
Received: by 10.78.151.15 with SMTP id y15mr8970910hud;
        Tue, 17 Oct 2006 00:26:37 -0700 (PDT)
Received: by 10.78.198.20 with HTTP; Tue, 17 Oct 2006 00:26:37 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610161714590.3962@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29028>

On 10/17/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Well, you can just add
>
>        [alias]
>                cat=-p cat-file -p
>
> to your ~/.gitconfig file, and you're there.

_WONDERFUL_. Really :)

-- 
Christian
