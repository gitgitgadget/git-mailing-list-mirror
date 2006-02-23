From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Port git-annotate to qx{} syntax, and make default output more like CVS
Date: Thu, 23 Feb 2006 16:08:16 +0100
Message-ID: <81b0412b0602230708y37bebe8co1bc3cdaf63302465@mail.gmail.com>
References: <Pine.LNX.4.63.0602231442390.24946@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Feb 23 16:08:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCI4r-0001Th-0G
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 16:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWBWPIS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 10:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWBWPIS
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 10:08:18 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:49024 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751278AbWBWPIR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 10:08:17 -0500
Received: by nproxy.gmail.com with SMTP id p77so47958nfc
        for <git@vger.kernel.org>; Thu, 23 Feb 2006 07:08:16 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jIr/cwRChbjcrENDpxw2tPigOSke7DOGmosIoebURLnp3ftbOttYu1rfU1sO+RNIeMC/xhQCCW88z+DDE3SFmz7GUIXzC02TSQFW+88r3NGWNgXJ6NIjwiHFXqfAEOgp4grOPdkgsa3w3Oa79AdAM5TiY+2YCEn+RfehC5o3oCE=
Received: by 10.49.61.3 with SMTP id o3mr2018987nfk;
        Thu, 23 Feb 2006 07:08:16 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 23 Feb 2006 07:08:16 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602231442390.24946@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16650>

On 2/23/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> This uses the qx{} syntax Alex digged up, and it makes output without "-l"
> quite similar to CVS's annotate output.
>

Works here.
