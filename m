From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] diff-options: add --patch-with-stat
Date: Sat, 15 Apr 2006 13:50:21 +0200
Message-ID: <e5bfff550604150450u37ce1660u2db4f6e97c586e13@mail.gmail.com>
References: <Pine.LNX.4.63.0604151340210.24303@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Apr 15 13:50:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUjIH-0004yW-Ff
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 13:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWDOLuX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 07:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWDOLuW
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 07:50:22 -0400
Received: from wproxy.gmail.com ([64.233.184.238]:38753 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932496AbWDOLuW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 07:50:22 -0400
Received: by wproxy.gmail.com with SMTP id i6so377398wra
        for <git@vger.kernel.org>; Sat, 15 Apr 2006 04:50:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EPGtE1kMDVUVFFUL6wDPta1ah6mN0GPRo62XxgsKMv8MtusMikTAXFX6/RrWAdM2RKUj5FtPq6VI+c5JjASJd+Rqcnhdnt0W8vKGNrXQdaoBhp5Si4ZWWL0JZbn4y/dEXU9QIuKwrpT6BkSdD5q8yz+MZwYC08wNwvn/Frk8eJc=
Received: by 10.64.204.12 with SMTP id b12mr1271479qbg;
        Sat, 15 Apr 2006 04:50:21 -0700 (PDT)
Received: by 10.64.131.14 with HTTP; Sat, 15 Apr 2006 04:50:21 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604151340210.24303@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18740>

On 4/15/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> With this option, git prepends a diffstat in front of the patch.
>

Thanks!  qgit will set this as default!

>
>         Buggeth, and you shall be given.
>
>         BTW I really would like to have a diffstat for combined diffs.
>         Any ideas?
>

Well..hem..why do not  count  the (shifted) + and - in the combined diffs ouput?

I suspect this can be a total idiocy, but now I'm missing why.  :-)

Marco
