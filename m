From: Eric Raible <raible@gmail.com>
Subject: Re: [RFC] Colorization of log --graph
Date: Thu, 19 Mar 2009 12:52:56 -0700
Message-ID: <279b37b20903191252h4c1541a1m8e391e01114d2ce6@mail.gmail.com>
References: <20090318100512.GA7932@linux.vnet>
	 <adf1fd3d0903181004k2554ae90uc101aad64947be7@mail.gmail.com>
	 <279b37b20903181029q7a526168y360874a48783d1dc@mail.gmail.com>
	 <200903192032.42117.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Eric Raible <raible+git@gmail.com>, git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Thu Mar 19 20:54:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkOKK-0005NQ-5g
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 20:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839AbZCSTw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 15:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754551AbZCSTw7
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 15:52:59 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:34053 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877AbZCSTw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 15:52:58 -0400
Received: by wf-out-1314.google.com with SMTP id 29so813401wff.4
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 12:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SZk853Hy5UVC9z+NJ67yQBFLzIDa4WPxPdeNr9GUnE0=;
        b=v/RzhcJU3aDC+P2pN9Apd+cuFRkHljqczsQb4ByJWBYEMj7tnqXOfQaNmRI2iQXKeU
         a9oFhCOMxr6j4hz2dwz9eYrAL+L0TUMq6LquYBE1iTXkSiMdkdOTgigCS1vMRHpEQ7eP
         vSuMhLkRydAqI5IQ4PIvuxg5ph5/IqUo1MRBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UYoHFBOVsKJQtnGgc46drC9iYR+VXQQ/pWq/epC/k/Q1VMOOXBHLHz+rJfm4f8uYUH
         9Zc2W1xGjSVSipbGvMDcfdvudM5zogKQBJIrqJkBRb2qnCLtIhRm7Gd1dE5hLLdZ2YmN
         ZM+ewQeOquD5rqcK/6dhiIWhOcgcsPmOls4Uc=
Received: by 10.143.3.7 with SMTP id f7mr1093485wfi.92.1237492376559; Thu, 19 
	Mar 2009 12:52:56 -0700 (PDT)
In-Reply-To: <200903192032.42117.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113815>

2009/3/19 Markus Heidelberg <markus.heidelberg@web.de>:
>
> If scrolling through a history with many branches (so many parallel
> lines) like git.git, colors help you to follow a particular line.
>
> I don't find it easy to follow a line in a PCB, where you normally don't
> have colors :)
>
> Markus

I find it easier to simply click on the line and then click the parent
in the lower window.  Which I'm only mentioning b.c. others might
not realize that it's possible.

The meta question is: anyone know of any gitk/git gui documentation
aside from Junio's excellent "Fun with msysgit 1.6.1 preview"
(http://gitster.livejournal.com/24080.html)?

Anything additional would be useful in my quest to get $dayjob to switch to git.

- Eric
