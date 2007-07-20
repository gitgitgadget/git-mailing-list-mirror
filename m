From: "David Frech" <david@nimblemachines.com>
Subject: Re: Another question about importing SVN with fast-import
Date: Fri, 20 Jul 2007 00:16:13 -0700
Message-ID: <7154c5c60707200016x45f4493ep3635be87afdc3e2c@mail.gmail.com>
References: <Pine.LNX.4.64.0707162204480.14971@reaper.quantumfyre.co.uk>
	 <7154c5c60707190009r6d460debs71158d4db9a028d4@mail.gmail.com>
	 <20070720051142.GO32566@spearce.org>
	 <Pine.LNX.4.64.0707200646400.18125@beast.quantumfyre.co.uk>
	 <7154c5c60707192354k7db677a6m4f8cbd474747ca92@mail.gmail.com>
	 <Pine.LNX.4.64.0707200759090.20056@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Julian Phillips" <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 20 09:16:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBmir-0002Uf-5G
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 09:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932714AbXGTHQR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 03:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbXGTHQQ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 03:16:16 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:9112 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932306AbXGTHQP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 03:16:15 -0400
Received: by nz-out-0506.google.com with SMTP id s18so709075nze
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 00:16:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ZbUTmHRQBARU8jYBmeO5U7berLNAiREwRNp3HtH7qPGngj976iLX6GZUrPHrOtQYiZxzlUrptWcp9oqI0wtSMw+UHMyDhFf4cT5+QNXkuLBmWPCp+PnM9uoPS8v4ubh3wAhEkZhLJDeURY3wIAxTtatcru6gqruk/ae7xvMcVgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=p8VqnycOoDjAO8ublum15qJD09FQk01ztbWO+dGCTZei9c/FqDu+Rc6JpKnw09wH5lEqAVK62YfQ8H6ln4B12qNZS4D81SifAmUzLMo8EnjF9T2xS1C6fDQiMQZyxtsHspIj+TO26lK5KLJJFvSf6a1Wa+655DpXuFJpwqDArpc=
Received: by 10.114.126.1 with SMTP id y1mr198405wac.1184915773995;
        Fri, 20 Jul 2007 00:16:13 -0700 (PDT)
Received: by 10.115.59.9 with HTTP; Fri, 20 Jul 2007 00:16:13 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707200759090.20056@beast.quantumfyre.co.uk>
Content-Disposition: inline
X-Google-Sender-Auth: 86521e23d06e70b2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53066>

On 7/20/07, Julian Phillips <julian@quantumfyre.co.uk> wrote:
> On Thu, 19 Jul 2007, David Frech wrote:
> > Since we'll be referring to past commits via marks (with start with
> > ":") how about this:
> >
> > 'C' SP srcpath:mark SP dstpath
>
> Why only via marks?  That may be what you happen to want, but no other
> command restricts you to _only_ using marks ...

I was using the royal "we". ;-)

Yes, you're right of course. My bad.

- David

> --
> Julian
>
>   ---
> What say you, Mr. American Ambassador?
>
> Fuck Canada!
>


-- 
If I have not seen farther, it is because I have stood in the
footsteps of giants.
