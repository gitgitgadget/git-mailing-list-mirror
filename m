From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: gitk on Windows: layout problem
Date: Sun, 4 Jun 2006 14:30:59 +1200
Message-ID: <46a038f90606031930p6212bdf9n3e81dee878d41fe5@mail.gmail.com>
References: <20060530185441.GA10985@nospam.com>
	 <Pine.LNX.4.63.0605302121410.11532@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@wingding.demon.nl, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 04:31:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmiOO-0001B3-G0
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 04:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWFDCbA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 22:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWFDCbA
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 22:31:00 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:1957 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751477AbWFDCa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jun 2006 22:30:59 -0400
Received: by wr-out-0506.google.com with SMTP id i22so748168wra
        for <git@vger.kernel.org>; Sat, 03 Jun 2006 19:30:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C5PFYH4i6UO6uxTC1IFxZuKcUfduzm4QLny9EJl2enK1wuBAqH90+rpd2qr1T5OBbCNXFTqLV2O4JMdYtAehZ9PpDYSHMIYAHS+41KwT3pr8mFFhVzU/2IRvsN+2gkasDHcs/LAEX491eNH23qel8nY2txP0KHcfw6P39hcaTDg=
Received: by 10.54.94.16 with SMTP id r16mr3606025wrb;
        Sat, 03 Jun 2006 19:30:59 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Sat, 3 Jun 2006 19:30:59 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0605302121410.11532@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21243>

On 5/31/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> This is a known problem. See
>
> http://article.gmane.org/gmane.comp.version-control.git/18209

Indeed. MacOSX has the same problem, and that patch "fixes" it too.
It's a bit of a hack but I think it should be merged in, conditional
on OS naturally.

cheers,


m
