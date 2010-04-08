From: Tor Arntsen <tor@spacetec.no>
Subject: Re: ***SPAM*** Re: What's cooking in git.git (Apr 2010, #03; Wed, 07)
Date: Thu, 8 Apr 2010 11:16:32 +0200
Message-ID: <w2zd2d39d861004080216y5017824aodff2fa3272f5ebfd@mail.gmail.com>
References: <7v6342ahx9.fsf@alter.siamese.dyndns.org>
	 <4BBD7228.8080403@viscovery.net>
	 <7vwrwi78t7.fsf@alter.siamese.dyndns.org>
	 <o2u4c8ef71004080201pdbdc7aa8j99500d7643c278c9@mail.gmail.com>
	 <m2sd2d39d861004080214sedf4a65fm7e081d468f4d88f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 11:16:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nznqp-0000t5-Pk
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 11:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756428Ab0DHJQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 05:16:35 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:65332 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab0DHJQe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 05:16:34 -0400
Received: by fxm23 with SMTP id 23so1859888fxm.21
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 02:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:received:message-id:subject
         :from:to:cc:content-type;
        bh=2yz8lJSdoJ9d00Vo6A2Xt2ae20QKXEEf4wEGa1blwfo=;
        b=b5PQKwtnkhiXlGld5E7uEWfs5vsoa8OAFZEtXE5EHk+BHIsW10ymst4/4PmioQw0+F
         zyL3LIUdrBr0Ci6Szt3FGsJNhWIJpazCeOGNbLqEl9QXNgvSzN9wK7Y89kdmURk452kC
         GbL7EF6dbCpPiC4z+He/5yt7//H0OzwsSQVcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=Hi1fS1jFHYu42+N4fGAEawpLuQrsRPxOhLVK+C359OaVFpu2VzBKxdyfShmwuxZm+V
         zYF65KbBOWVicfXNAhZ9JVfdJGxWqN08E5U3A3pxrOaC9zm4TLHO6/JVSB7f9X1Zcrw/
         YB5pNUyhVv4Ma5Y/234qvDZcdmUS8siBYxQyQ=
Received: by 10.239.179.197 with HTTP; Thu, 8 Apr 2010 02:16:32 -0700 (PDT)
In-Reply-To: <m2sd2d39d861004080214sedf4a65fm7e081d468f4d88f2@mail.gmail.com>
X-Google-Sender-Auth: dbbe15016ff6856a
Received: by 10.239.190.81 with SMTP id w17mr987042hbh.45.1270718192991; Thu, 
	08 Apr 2010 02:16:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144350>

On Thu, Apr 8, 2010 at 11:14, Tor Arntsen <tor@spacetec.no> wrote:
> Every other system I have (irix 6.5/solaris/aix) appears
> to have PTHREAD_MUTEX_RECURSIVE.

I forgot Tru64 5.1, which is also OK in this respect. So, IRIX 6.2 is
negative for now.

-Tor
