From: "Shyamal Sadanshio" <shyamal.sadanshio@gmail.com>
Subject: Re: GIT Error issue
Date: Thu, 20 Apr 2006 20:28:29 +0530
Message-ID: <3857255c0604200758h20d7e3eel253fd5a916be4309@mail.gmail.com>
References: <3857255c0604190416j62abeae8va164896c5100f6ee@mail.gmail.com>
	 <46a038f90604191453q567192b0l9a35d50f96f8705d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 16:58:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWac8-0006Kw-F4
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 16:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWDTO6c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 10:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWDTO6c
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 10:58:32 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:35332 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750960AbWDTO6c convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 10:58:32 -0400
Received: by pproxy.gmail.com with SMTP id i49so221912pye
        for <git@vger.kernel.org>; Thu, 20 Apr 2006 07:58:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j0tWHfj+aU2n8at6seaP9v3EHFCgReKllYs+OnPZ7PSuEurkpbRPB2sbzeg7rYIMYqqFvLmmyqNKtht1w0NMIJ6MV/bKA1332nE2VrteVSNFgC1dyPS31I6JIR5XrrPJBTIsxxZO/20JWONfjGIy5+C3kXLv4PcDcWvlR7hLRGk=
Received: by 10.35.101.9 with SMTP id d9mr957889pym;
        Thu, 20 Apr 2006 07:58:29 -0700 (PDT)
Received: by 10.35.60.20 with HTTP; Thu, 20 Apr 2006 07:58:29 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90604191453q567192b0l9a35d50f96f8705d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18973>

Thanks a lot for the pointer!
It worked now!!

Thanks and Regards,
Shyamal



On 4/20/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> If you are using Debian or a derivative, just do
>
>    apt-get install git-core
>
> which will remove the 'git' package (GNU Interactive Tools) and
> install the git SCM. On RPM systems, probably
>
>    yum install git-core
>
> will do the trick.
>
> cheers,
>
>
> martin
>
