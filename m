From: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Fri, 22 Dec 2006 09:50:32 +0100
Message-ID: <9a8748490612220050t294d3785r94f0b3c74e935b24@mail.gmail.com>
References: <4589F9B1.2020405@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 22 09:50:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxg6x-0001Mo-Gq
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 09:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945987AbWLVIud (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 03:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945992AbWLVIud
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 03:50:33 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:12471 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945987AbWLVIuc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 03:50:32 -0500
Received: by wx-out-0506.google.com with SMTP id h27so2669981wxd
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 00:50:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kol5LuRVYDlO3hgtgs9mhM2ZUjSvyG9UTsOA0MwxvOw1GJy9vZZ/tojn9Obfw/+ltYdS6glyUdPD5sKhdaS6PMmvqeFycQJZ3yjLEaoQfngUb8nnxlZvI17F3MTpxzo4aq2mxg7q8R1Y3y3oSGKwVQFgxlOGriJi7GYSN3t9O1I=
Received: by 10.90.75.10 with SMTP id x10mr9176715aga.1166777432241;
        Fri, 22 Dec 2006 00:50:32 -0800 (PST)
Received: by 10.90.29.7 with HTTP; Fri, 22 Dec 2006 00:50:32 -0800 (PST)
To: "Jeff Garzik" <jeff@garzik.org>
In-Reply-To: <4589F9B1.2020405@garzik.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35151>

On 21/12/06, Jeff Garzik <jeff@garzik.org> wrote:
> I refreshed my git intro/cookbook for kernel hackers, at
> http://linux.yyz.us/git-howto.html
>
> This describes most of the commands I use in day-to-day kernel hacking.
>   Let me know if there are glaring errors or missing key commands.
>
Very nice.

A bit on how to revert a commit and how to rebase a branch would make
it even nicer :)

Thank you for a very good document, Jeff.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
