From: bill lam <cbill.lam@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Fri, 13 Feb 2009 10:31:20 +0800
Message-ID: <20090213023120.GA7322@b2j>
References: <20090205204436.GA6072@diku.dk> <op.uo9di902a8ed4e@dellschleppa> <2c6b72b30902121424o5d4ac0d7u67a7afb3b861aa19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tilo Schwarz <tilo@tilo-schwarz.de>, git@vger.kernel.org
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 03:36:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXnv1-00055c-Mu
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 03:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbZBMCb1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Feb 2009 21:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756545AbZBMCb1
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 21:31:27 -0500
Received: from ti-out-0910.google.com ([209.85.142.187]:62736 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbZBMCb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 21:31:26 -0500
Received: by ti-out-0910.google.com with SMTP id d10so656504tib.23
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 18:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=64W4oYuEHRPjD4w5LI8YL+7QncczotziYsLGZpMv1BI=;
        b=DnF7xsUw4BLo+sDR55MHnYNSB+kz0HtPrTf5uAb8ZVQ1UQ9/PkWWHUFCa/i66WeVr8
         33Dj0J4rGUUvqByQi5yt894dp9veic5BLBI1b+KHSmT6Qw4tS5SNixmPGVZ+NNBa3vyZ
         EHl+IFwQbHkEWz91z2ToyolLH4wOPkUTswsXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=aw8jwMDfkJACVXaH5s5H5x3ZvOyrRCxc/zc7k1NhhnvZeOJyHLldGomA/dMP4VOvAq
         NyDOfJMGQUEqLc5WfeDwUojImPJtsPcqe7uRZGRqhN/sqNssFAA2ly001jg/wzj8xAvO
         ey/HZkOq6T/E6GUirwKWWIZZe2xIaxqyV1O9Q=
Received: by 10.110.31.5 with SMTP id e5mr2400174tie.1.1234492284473;
        Thu, 12 Feb 2009 18:31:24 -0800 (PST)
Received: from localhost (pcd589208.netvigator.com [218.102.121.208])
        by mx.google.com with ESMTPS id a14sm3607715tia.27.2009.02.12.18.31.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Feb 2009 18:31:23 -0800 (PST)
Mail-Followup-To: Jonas Fonseca <jonas.fonseca@gmail.com>,
	Tilo Schwarz <tilo@tilo-schwarz.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <2c6b72b30902121424o5d4ac0d7u67a7afb3b861aa19@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109702>

On Thu, 12 Feb 2009, Jonas Fonseca wrote:
> The last one uses "browsing state variables". There is more
> information about those in tigrc(5)[1]

I can see that scroll-left/right only do it for one column, that is
not very convenient, Will it be possible to scroll for 10 columns or
half screen?

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9260 =E6=9D=8E=E7=9B=8A  =E6=B1=9F=E5=8D=97=E6=9B=B2
    =E5=AB=81=E5=BE=97=E7=9E=BF=E5=A1=98=E8=B3=88  =E6=9C=9D=E6=9C=9D=E8=
=AA=A4=E5=A6=BE=E6=9C=9F  =E6=97=A9=E7=9F=A5=E6=BD=AE=E6=9C=89=E4=BF=A1=
  =E5=AB=81=E8=88=87=E5=BC=84=E6=BD=AE=E5=85=92
