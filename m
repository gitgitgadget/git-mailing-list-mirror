From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: C++ *for Git*
Date: Sat, 22 Sep 2007 17:23:15 +0200
Message-ID: <e5bfff550709220823p241d04d1n370bda4fa0ef2733@mail.gmail.com>
References: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com>
	 <Pine.LNX.4.64.0709221348180.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>,
	Git <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 22 17:23:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZ6pH-0004kj-4Y
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 17:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbXIVPXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 11:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbXIVPXS
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 11:23:18 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:13751 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbXIVPXR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 11:23:17 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1050428rvb
        for <git@vger.kernel.org>; Sat, 22 Sep 2007 08:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=M5XfKRVJMcUrzxhfkYDzWENDWAxfGnw/bdY9zNoE8EI=;
        b=lnHlLRZ1xi1haYqW3jFSwt72LU23oReX0SkG+J3tlxUbWSfRTmdXMIPPT/DgpyJDEp0fahmOInI5X98FtTPYR3gPWBAWhWIrZHGon5j5eZF1a2VEvlocBHb+3kFpbKF3fyFiI3K5VNA2Ewa4yT9JEwhS+oQvY9igK6cXK7/9Ig0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X8xKDInoJa/FwbqJ/fRdRsbQs0R5vKCSGmpOLpTd5WGRILv5fxfWreOCYOqUfN5ZTihFkCxsLHkCcB87ggyF7Os7b8Ua96F1pwyTCWXKIq8xJ20FOPFUGUcRqvmaOnT0e/9Pm8jm2so/94xk/Xy4H+tJ2pHfIgPZFBYieLfJuSE=
Received: by 10.114.179.1 with SMTP id b1mr906746waf.1190474595921;
        Sat, 22 Sep 2007 08:23:15 -0700 (PDT)
Received: by 10.140.185.19 with HTTP; Sat, 22 Sep 2007 08:23:15 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0709221348180.28395@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58936>

On 9/22/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> We don't want C++.  Why is that so hard to accept?
>

Dmitry, I think what Johannes says in the above line is 100% the core
point of this (sad) discussion.

You cannot force/convince someone to use something he hates. That's
it. And there's no point in trying to do this.

git developers were also kind enough to give explanations on 'why' C++
is not a good language for them. Do you don't agree? do you find the
arguments not totally satisfying for you? That's not their problem.

I like C++ (a my little git related GUI tool called qgit is done in
C++) and at the same time I understand also much of the concerns that
where expressed in the list.

Your position will never be successful for a number of reasons, some
clear expressed other less clear but at the same time, perhaps more
important. So I really don't understand why you insist.

Thanks
Marco


P.S: The example you show is a pity for C++, it's like to advertise a
1000cc 200Hp motorbike saying "...and you will no have problems in
parking in your box."
