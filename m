From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: gitignore design
Date: Sat, 30 Jul 2011 17:52:00 +0200
Message-ID: <CAA01Csq4L6ceGcjDJEsz5xyNeS+3q+Cb5txto0nPDzjqT1+zXw@mail.gmail.com>
References: <1311934832699-6632987.post@n2.nabble.com>
	<m3pqktql6s.fsf@localhost.localdomain>
	<4E32B637.1030201@viscovery.net>
	<201107292339.51753.jnareb@gmail.com>
	<CACsJy8CurvKd_=hdRQyjjzWLvKF0jbWOQhbLSsmk1BqB_dK3og@mail.gmail.com>
	<CAA01Cspv4yShnKBKFFrf8K1tbARahyYf7KZPqbiDFrvFsX9hwg@mail.gmail.com>
	<CACsJy8DcFJUK91cJm3EmHn8BMyA78gzu_pMtqJ0z9oO1RF+suw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	llucianf <llucianf@gmail.com>, Ferry Huberts <mailings@hupie.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 30 17:52:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnBpg-0005qZ-OH
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 17:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab1G3PwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 11:52:05 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:43097 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab1G3PwC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 11:52:02 -0400
Received: by yia27 with SMTP id 27so2979798yia.19
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CT3oNoGQ+iEydVF1c+3vmmP62k6Tja2GhUDTpqyaPiA=;
        b=XfBbbYPTaSbja/6HvXv37ZMo2XL4+d1M1dJTxWbQE/HN3qmkG8UgOWKHCqgod9n8Zd
         kilcIQ/ZP2h5vFPC3g7dFRKI7iqBhjIg6vQ9HOTo/2+8/DNJ8cmsW88KAnw1X/aoZ2VY
         D2l0ji1D793K4TLOVSXc0dVvdjq2vASe8E7yM=
Received: by 10.150.8.13 with SMTP id 13mr223899ybh.103.1312041120992; Sat, 30
 Jul 2011 08:52:00 -0700 (PDT)
Received: by 10.151.147.1 with HTTP; Sat, 30 Jul 2011 08:52:00 -0700 (PDT)
In-Reply-To: <CACsJy8DcFJUK91cJm3EmHn8BMyA78gzu_pMtqJ0z9oO1RF+suw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178207>

On Sat, Jul 30, 2011 at 3:22 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Sat, Jul 30, 2011 at 1:45 PM, Piotr Krukowiecki
> <piotr.krukowiecki@gmail.com> wrote:
>> I was using assume-unchanged for some time but stopped after some
>> weird problems during updates. I'm not sure if this was caused by this
>> or by sparse-checkout (and I use git-svn too). Anyway, after stopping
>> using assume-unchanged and sparse-checkout mysterious problems
>> disappeared.
>
> I'm interested in the problems you had (even better if you found a way
> to reproduce).

Sorry, but that was some time ago and I don't remember details.
I could try using it again (which one are you interested in, sparse-checkout or
assume-unchanged?) and report back if I find any problems.


-- 
Piotr Krukowiecki
