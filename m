From: jaseem abid <jaseemabid@gmail.com>
Subject: Re: [GSOC] Contributing to git.
Date: Fri, 30 Mar 2012 18:19:37 +0530
Message-ID: <CAH-tXsDBEKOQANzU_oDr_vbWVznv0Yqs0t1YrZhnzC_DeyHxkw@mail.gmail.com>
References: <CAH-tXsB39OpbmVcD3Fd+tq8UcBsyCf6JBZ-rSyf1VwrQPKLiFQ@mail.gmail.com>
 <20120330052631.GB11648@sigill.intra.peff.net> <201203301305.23567.jnareb@gmail.com>
 <CACeyogeboKPEhsaY357+hBvVquW7kn3ygOk11ZSKvXOt4vkzvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: chaitanyaa nalla <nallachaitu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 14:50:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDbHc-0000Lf-Lp
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 14:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760754Ab2C3MuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 08:50:20 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:40616 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760237Ab2C3MuS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 08:50:18 -0400
Received: by wibhq7 with SMTP id hq7so573810wib.1
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 05:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fFjfeUNRx0eS1q2N6R4BtQHxskhlvff/DwGAD13QT9I=;
        b=MYsj1rqhaPob1IHXHFBLo6N5arVS5NhvhvlakDMabQ5yuJ4oRmyFLfGWmGi5SSNXFQ
         dgb/SIgxe2qc88Ceo8DtAkCOW/UvyOWDbx5hPE4c56EzZi6Uljukt32+5xBSNEJro5De
         bgSuWaeJ3W2PnhWamNc+8VseTsfYS4hR+V4QHu6jT67gTMBBFFxGa+EEm16ChsVaZfV3
         n8o8qxfWUOvk0w7sSy7h+SMSVjw8OVWHF8/TTyWTIKv7YFeweSlAHe0KmtpYr9PgAt6a
         7ZlvHf5CKi7dhArp1SdhpZv5sEjuVqoShXVP7EIMA5O3/4aRu5P2B+Dfvy9hoL8HMGCm
         cwRw==
Received: by 10.180.92.130 with SMTP id cm2mr6261804wib.4.1333111817448; Fri,
 30 Mar 2012 05:50:17 -0700 (PDT)
Received: by 10.227.155.6 with HTTP; Fri, 30 Mar 2012 05:49:37 -0700 (PDT)
In-Reply-To: <CACeyogeboKPEhsaY357+hBvVquW7kn3ygOk11ZSKvXOt4vkzvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194355>

On Fri, Mar 30, 2012 at 4:48 PM, chaitanyaa nalla <nallachaitu@gmail.com> wrote:
> There are good Opensource tools like
> TestSwarm (jQuery)

TestSwarm is still in its alpha stage.

> JSTestDriver(Google).

Too much for this project. Too many unwanted features.

> Both are distributed

does it have to be?

> javascript testing tools that supports testing on all major browsers.

Node.js will let us test in a console. Else we can fallback to a browser option.

-- 
Jaseem Abid
+91 8891 72 43 72
S6 CSE student
National Institute of Technology , Calicut.
