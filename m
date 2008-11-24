From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: Hello All and Seeking Information
Date: Mon, 24 Nov 2008 17:39:44 +0100
Message-ID: <46d6db660811240839n76d96887w7c497851f04c8658@mail.gmail.com>
References: <c115fd3c0811240828y61e7bfecka1cacdd37865a4e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Tim Visher" <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 17:41:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4eUm-0000Ft-I0
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 17:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbYKXQjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 11:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753502AbYKXQjr
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 11:39:47 -0500
Received: from gv-out-0910.google.com ([216.239.58.189]:28769 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402AbYKXQjq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 11:39:46 -0500
Received: by gv-out-0910.google.com with SMTP id e6so353310gvc.37
        for <git@vger.kernel.org>; Mon, 24 Nov 2008 08:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2ELXfYv23va0yYo02NqmVhUATgB9kehycrD6hm0y74s=;
        b=ogrBYarZDrF9osAGgJ2mJkQH6XuYhqAyM3cBLbM6wXmsKLGzcURVcK9KrNDk9CM8Te
         PvhUEvbZU9UQ85DKo3ZzM+dDxygMfn2ULWQPlelHzCY42uQRv6pUBGt6o4chpi2SLvCj
         oPHR+TKGdp4W8tYbtZTLqlNIX6y71I2+daKWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=BVq/pTayGrucX5oXfffdQCb9DHHQ4b4uJVYFzv7F4k7u7Z/GBrwSCO+R2JEogVwANV
         wWjGWDAHX8jgKs0RPR4AXtxB8eHiJcUMKRqio3E9wKcw/YeigKYSjZNCHRAWiA1dp0wB
         fbK2x2z7TKw/BHahZVZx/OuyjZuvSAdly+Hq4=
Received: by 10.103.245.18 with SMTP id x18mr1140763mur.62.1227544784223;
        Mon, 24 Nov 2008 08:39:44 -0800 (PST)
Received: by 10.103.189.18 with HTTP; Mon, 24 Nov 2008 08:39:44 -0800 (PST)
In-Reply-To: <c115fd3c0811240828y61e7bfecka1cacdd37865a4e8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101616>

On Mon, Nov 24, 2008 at 5:28 PM, Tim Visher <tim.visher@gmail.com> wrote:
> Hello Everyone,
>
> I'm new to the list so I figured I'd introduce myself instead of just
> wall-flowering... "Hello"... :)
>
> Anyway, I really like a lot of the concepts found in Git and the
> reported power and flexibility of it are very intriguing.  However,
> there are some issues that I can't wrap my head around, such as how
> you can guarantee that all developers are working on the same
> code-base without a central repo.  I would classify a lot of my issues
> as paradigm rather than technically related. I understand a lot of
> Git's underpinnings and the basic usage of it, I just can't wrap my
> head around the higher-order parts of it.
>
> I've done some Googling and I can't find a good 'Introduction to
> Distributed SCM Concepts for Centralized SCM Developers' article yet.
> Ideally, this would be an article all about the high-level thought
> processes that go into utilizing Distributed SCM in a team environment
> where having a single canonical representation of your project that
> all developers are working off of is important.
>

http://git.or.cz/gitwiki/LinusTalk200705Transcript

but the video is obviously more fun

http://www.youtube.com/watch?v=4XpnKHJAok8

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
