From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: request for pre-generated git.info pages
Date: Thu, 30 Oct 2008 12:01:53 +0000
Message-ID: <e2b179460810300501s5569b03ej56616a8ab1c8c28e@mail.gmail.com>
References: <ee2a733e0810291500o67b3f94fibef63e0a173e8cc1@mail.gmail.com>
	 <e2b179460810300206g79e06c63m2060092fa654b18b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: SLONIK.AZ@gmail.com, "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 13:03:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvWF3-0003Mv-KU
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 13:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525AbYJ3MB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 08:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753484AbYJ3MB4
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 08:01:56 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:30617 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475AbYJ3MBz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 08:01:55 -0400
Received: by rv-out-0506.google.com with SMTP id k40so558280rvb.1
        for <git@vger.kernel.org>; Thu, 30 Oct 2008 05:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4K00vfdCzdmJKH2VO7+dVAdv51IcPWsceL+ktImy2uI=;
        b=cm7ALcfB/Zzt4UHyhbqxEzpUGPlCVfAjVok64coUnGLCgKROtGNi/dNASszcKWXB2P
         ngEJN/TiAq/jrrpnX6fAeCbS9wF0UJavzKWVxMRB4rmlcsN/hZA3kro7xTwKsNDFdzhO
         socFcF6HI5S77fTkTixotCrRIuMNhI/GFhhos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=a6JIXifELC/vkanjOkkAkCtFoRS/nZnIJ2hb0qT8sJOqH1CNbFLAfHEgebmCnm20Nh
         eWJI7M82h5vFmUxiP/W8GsONFdtoS8clAgqbrJ0JbE188mRzm1qPb0yb6p1csDtYGfyq
         QC06xN+qJiTNJkPvynVFY8KQMHDUWl3HV/F+M=
Received: by 10.141.171.6 with SMTP id y6mr5595516rvo.174.1225368114038;
        Thu, 30 Oct 2008 05:01:54 -0700 (PDT)
Received: by 10.141.52.18 with HTTP; Thu, 30 Oct 2008 05:01:53 -0700 (PDT)
In-Reply-To: <e2b179460810300206g79e06c63m2060092fa654b18b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99461>

2008/10/30 Mike Ralphson <mike.ralphson@gmail.com>:
> Unfortunately I don't have a working asciidoc etc toolchain either
> (though I will take a look at getting it working on my central git box
> which is Linux based). As I'm not an emacs or Info user I probably
> wouldn't know if they were building correctly anyway.

The only machine at my disposal with a working Python installation
(and I'm afraid I don't feel inclined to install it anywhere else,
Python on AIX is painful, and obviously if I was a Python nut, I'd be
running mercurial anyway, right?) is my desktop cygwin installation.

At least there obtaining asciidoc was no problem, but I think I'm
stuck in some docbook2x dependency hell with lots of twisty turny
prerequisities, all alike.

Now deep in a dark cave with a sign saying "Can't locate
XML/Handler/SGMLSpl.pm in @INC", which is where my adventure ends.
Score 0/100.

So a volunteer would still be appreciated.

Mike
