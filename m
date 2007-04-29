From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 0/2] Make test suite work with dash as /bin/sh
Date: Mon, 30 Apr 2007 01:44:24 +0300
Message-ID: <b0943d9e0704291544h2e4225d2jb32925bdca584e98@mail.gmail.com>
References: <20070429210713.4004.60467.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 00:44:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiI87-0003a8-2K
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 00:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031454AbXD2Wo2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 29 Apr 2007 18:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031452AbXD2Wo2
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 18:44:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:32336 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031334AbXD2Wo0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Apr 2007 18:44:26 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1182685uga
        for <git@vger.kernel.org>; Sun, 29 Apr 2007 15:44:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XApXzLciKN/KeLmLzw7JVOhRlRsbM6+kYmF/+NGq0MPL4RtE1YVJ5YbOKNLaSEtsZVKU5GPRZZi0tv47QVHIKwFKbEWTSpvaWHVyRtr6S9UD1VlhLVcxwkRTrnTI75c/waovu7mYOlwSBXoYqoUbRShkE07y5gcTaMnOK8rCpD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BToyTA6b4fIwoJhm5+kMlxWKn/W2/xkJ16QbL0UVE3HrqTM4uuvGQ4BTXpvDEfV0V0h7+iaFMLPohfSAS1Jp+m9g2IKlARm6yIYeGgR88KFDQn6tW4+TLanvgXeqSLJPzTzppqrZdClPEHEn7Tq0jqgII0jpZH0Ecqkk6tzLOPc=
Received: by 10.66.254.2 with SMTP id b2mr4921447ugi.1177886665211;
        Sun, 29 Apr 2007 15:44:25 -0700 (PDT)
Received: by 10.66.255.11 with HTTP; Sun, 29 Apr 2007 15:44:24 -0700 (PDT)
In-Reply-To: <20070429210713.4004.60467.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45847>

On 30/04/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> I got some strange errors when running the StGIT test suite on a
> machine I hadn't tried developing on before. It turned out that its
> /bin/sh was dash, and that a few bashisms needed fixing.

Thanks for your patches. I'll apply them in about 2 weeks time (when I
get back to the UK).

--=20
Catalin
