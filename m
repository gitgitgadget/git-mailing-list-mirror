From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: emacs and git...
Date: Fri, 23 Mar 2007 18:29:48 +0100
Message-ID: <38b2ab8a0703231029m4b010686t4428158013b4acbc@mail.gmail.com>
References: <38b2ab8a0703220753s67809e87l76ffc57adb725898@mail.gmail.com>
	 <86lkhpmftt.fsf@blue.stonehenge.com>
	 <38b2ab8a0703230029h7f3faa95u1e2ccb6a9ee4be5e@mail.gmail.com>
	 <864poch0xl.fsf@blue.stonehenge.com>
	 <38b2ab8a0703230132j64cf0b94x7c210593f3f31387@mail.gmail.com>
	 <7vtzwcqqf9.fsf@assigned-by-dhcp.cox.net>
	 <38b2ab8a0703230254x585ff89fp3e425b08cac56900@mail.gmail.com>
	 <7vaby4qnhk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 18:30:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUnaX-0006lT-Cn
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 18:30:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbXCWR3w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 13:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753261AbXCWR3w
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 13:29:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:40968 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259AbXCWR3v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 13:29:51 -0400
Received: by nf-out-0910.google.com with SMTP id o25so2117393nfa
        for <git@vger.kernel.org>; Fri, 23 Mar 2007 10:29:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AXzOgy4klaaA/ehw0ycnpGj/l197qs5BQgAqQLNtclNIF3F4Z6N8HZdiZ/blydcLMFYBvzIAu9gr2DhhbW52HzL5Ayg8c8mNo/xuJmksaaGkRPzBNEu63MP4Ykf6UsSKEboQL4Lee8Vq2IggGvo14kIn56l/qZ3hIa7M9ONZzIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bor1jRYvJTE4S9WUoz6cii/+rYuhujQXTT3LTa1lgEg3pAd6dN5X9cz/hshP4ESNlZzd9IzCUGDOqzGWCUwhulYdBEFFCSAFLj2HzDCioEyoZh7FFWXLl+PhaIn3TFYKTfPaGFUrWpjiDBW75/PIHcyHxkZwPd9kjrV2rFeGKCw=
Received: by 10.114.56.1 with SMTP id e1mr1292873waa.1174670988831;
        Fri, 23 Mar 2007 10:29:48 -0700 (PDT)
Received: by 10.114.38.12 with HTTP; Fri, 23 Mar 2007 10:29:48 -0700 (PDT)
In-Reply-To: <7vaby4qnhk.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42950>

On 3/23/07, Junio C Hamano <junkio@cox.net> wrote:
> "Francis Moreau" <francis.moro@gmail.com> writes:
>
> > BTW Junio, just out of curiosity, do you use shell or term mode ?
>
> Neither.  Almost all of my external command session inside Emacs
> is done in compilation mode.  I even bind "C-x c" to "compile".
>

hm do you also run all git commands in this mode ??
-- 
Francis
