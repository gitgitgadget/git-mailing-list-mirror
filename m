From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Sun, 21 Mar 2010 17:55:02 +0530
Message-ID: <f3271551003210525l761cf36eh69cdfddf4e645ef3@mail.gmail.com>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com> 
	<32541b131003191132y119037f8rae598d0037786703@mail.gmail.com> 
	<fabb9a1e1003191139v6ea37df3uba441f2cba9bc992@mail.gmail.com> 
	<32541b131003191430ld0eaa9cw1d2aac08cff15682@mail.gmail.com> 
	<alpine.DEB.1.00.1003201148230.7596@pacific.mpi-cbg.de> <f3271551003201334o4919cd47s44d06288b0d6068b@mail.gmail.com> 
	<20100320210406.GA29899@progeny.tock> <alpine.DEB.1.00.1003211125290.7596@pacific.mpi-cbg.de> 
	<20100321110807.GA24016@progeny.tock> <alpine.DEB.1.00.1003211236050.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephan Beyer <s-beyer@gmx.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 21 13:25:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtKDh-0004oF-Fk
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 13:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034Ab0CUMZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 08:25:24 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:58236 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab0CUMZX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 08:25:23 -0400
Received: by gxk9 with SMTP id 9so2808468gxk.8
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 05:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=1GKT0DuGoQaITNRCF3kXjsMw41aa01zFLzIZTZqdG7s=;
        b=OTVWEl2du8orTytungrTQ1kIwI2MELrONElSk07JXwPKeM37xmpDy++x2L52I+ahle
         6PV9ysyJwzubydUAh17gij3IX/SRNh6xGLR26SNhxWnfljvTQxFPi7eFW02W1cp7hmit
         K8oJgBcHcaNQgl2N4rhoHyZmOUcqUBdlPKzX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=nk1nfjiXMFYKJZXXqxwl5GFXxr/jfu7fnw0tgrK031YCBPpEaquLT5dWQK+ZfOl+7B
         Iyjlgnn23eqPBXDFM0MK3jo2arqnRX+kQy8ldEh8TUB1CQmNTmu38E1YDX2CZaE/cqGI
         OSSR7WnyAEXzkcPp+1OUZJb8LEOl2MyF3MfHY=
Received: by 10.91.130.2 with SMTP id h2mr247820agn.100.1269174322262; Sun, 21 
	Mar 2010 05:25:22 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1003211236050.7596@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142821>

Hi,

> Personally, I would have little problems just adding the remote and
> checking out the branch, just to test the thing after I got a promising
> progress report. And I think those who are truly interested in
> git-remote-svn will have little problems, either. The important part would
> be the visible progress (i.e. mails by the student to this list).

Thanks for the elaborate explanation. The way I see it, there are two
extreme situations I must avoid. The first is being opaque for the
risk of not being able to integrate it into git.git at the end of the
summer term. The other extreme is worrying so much about the
integration of each little bit that the project keeps getting
detracted, and eventually loses focus. To strike a balance, I will
post progress reports to the mailing list (atleast) once a week, and
keep a public development branch for myself. Occasionally, it might
help to post patches for small components of the project with
unittests to get a wider test audience.

Ramkumar
