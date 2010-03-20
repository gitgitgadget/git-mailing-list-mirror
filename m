From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Sun, 21 Mar 2010 02:25:22 +0530
Message-ID: <f3271551003201355h73deb7d8l8084335b09c01560@mail.gmail.com>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com> 
	<32541b131003191132y119037f8rae598d0037786703@mail.gmail.com> 
	<fabb9a1e1003191139v6ea37df3uba441f2cba9bc992@mail.gmail.com> 
	<32541b131003191430ld0eaa9cw1d2aac08cff15682@mail.gmail.com> 
	<alpine.DEB.1.00.1003201148230.7596@pacific.mpi-cbg.de> <f3271551003201334o4919cd47s44d06288b0d6068b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 20 21:55:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt5i0-00010Z-3m
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 21:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576Ab0CTUzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 16:55:43 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37407 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935Ab0CTUzm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 16:55:42 -0400
Received: by gyg8 with SMTP id 8so2061891gyg.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 13:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=V9cv8QPhktnrFm9fNbCNzwUuJln8MRn9XNYIIc5ElOk=;
        b=T2MKxKggmravZvUObfQ1rFNljoiJw7h5JjHaUZZpOIDopW7uKK7GEmUd291Q5GCqLz
         eoZ4Hbd0Asd4d8BGi0+OPpRr3tD6m+WNKdqrRj/r7wezjDpi8NmPm5ZXjma1q9Kl3tc0
         +4vfJhDTMLzLqEyZhKmuALuo5qMa29mAGgwQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=s4PXjXFQhtJBXIl+hijOsGhb+wJd/MImhDhPBfOf9miyrM4j8kCa8gMpGR6NsDggN8
         gpNwSVtpvdcEIcPieY5vLQUr8YC7urBbkFAEGycOwSRVbxioJl94YCU331O/t2yuvcH1
         67SHDywdTfJcJ1Ymbaf48DBjDmok7IodsB2m0=
Received: by 10.91.188.19 with SMTP id q19mr2404563agp.32.1269118542158; Sat, 
	20 Mar 2010 13:55:42 -0700 (PDT)
In-Reply-To: <f3271551003201334o4919cd47s44d06288b0d6068b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142750>

> July 5 - July 10: Write a quick UI binder. This will involve
> modifications to builtin-push, builtin-fetch, builtin-clone, and
> remote to use the SVN client to perform the corresponding actions in
> the case of an SVN remote.

Correction: This functionality is already present. I'll just continue
working on my SVN client for this period.

Regards,
Ramkumar
