From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Google Code: Support for Mercurial and Analysis of Git and 
	Mercurial
Date: Sun, 26 Apr 2009 11:47:19 -0500
Message-ID: <b4087cc50904260947n394d9c89nf0e821b0504091c5@mail.gmail.com>
References: <200904260703.31243.chriscool@tuxfamily.org>
	 <alpine.DEB.1.00.0904261208000.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 27 11:48:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly7XL-0007Yq-P7
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 18:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195AbZDZQrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 12:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbZDZQrU
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 12:47:20 -0400
Received: from mail-qy0-f180.google.com ([209.85.221.180]:38194 "EHLO
	mail-qy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713AbZDZQrU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 12:47:20 -0400
Received: by qyk10 with SMTP id 10so817280qyk.33
        for <git@vger.kernel.org>; Sun, 26 Apr 2009 09:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=f1+vw0lhd2szEGO8nMMZrp7Ai+xpNyajQcxp6OfgiiQ=;
        b=IVnLXz2zvwXhwR/tRco0P1D3qMAyY6gzIbysIlvFeZsBEkBTtmf9crO9VQ8xrt/Skh
         ORnlttkUcGl3lcC3g3OZ7efM83ndLtoG3jT5q2uPrYh3DtbVnKsNPbNFcgzMKhyNEnX0
         KiCIzQAdcK+4ddcObPIC/ETmQgYsKKaQzZsVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Xt+0K1vPSMPglN7EG1GYN+2JQ59M61Qf1mwbmCqRt///e0pk7MDLpcGsdxu9tPaDvc
         Dhc4nvd+OcTswFLXSaT+TQTEsS9mYzUiCRKErZTUVVip4QvqSi+wdFg8y4PYDt4lDezQ
         DgrFK5aMUmqVksy93IxTuyZncGNXtcLKy1+L4=
Received: by 10.224.11.136 with SMTP id t8mr4855658qat.73.1240764439369; Sun, 
	26 Apr 2009 09:47:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904261208000.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117636>

On Sun, Apr 26, 2009 at 05:13, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> So, don't believe that the reason Git is not supported by Google Code is a
> technical one (just like it was no technical reason at all for Python to
> choose Hg over Git).

Frankly, I think that it can be considered technical for Python
developers to choose an SCM written in Python. I can't fault them for
that.
