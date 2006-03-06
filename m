From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: What's in git.git
Date: Mon, 6 Mar 2006 22:05:41 +1300
Message-ID: <46a038f90603060105m29595745ke64d4a623506c0b0@mail.gmail.com>
References: <7v1wxg82r3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 10:05:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGBf7-0001CQ-8m
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 10:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWCFJFn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 04:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbWCFJFn
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 04:05:43 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:39035 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751396AbWCFJFm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Mar 2006 04:05:42 -0500
Received: by wproxy.gmail.com with SMTP id i20so1092479wra
        for <git@vger.kernel.org>; Mon, 06 Mar 2006 01:05:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oO0o8Gcu4hGoowT5Vi2VpICc5Glg850lk/jueMkYWd/oe1rUOrHgg65AmOtix3bq1JXGpE+7xzy5La364e8XgwFEgOz0ZJOQEdSF2mSLssff/9fb4l/2D+UmUa29EgG178wmgzGAUeO38ZXYOHfOxQ4s52obelfdXbE92MNwg6E=
Received: by 10.54.153.2 with SMTP id a2mr4898576wre;
        Mon, 06 Mar 2006 01:05:41 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Mon, 6 Mar 2006 01:05:41 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v1wxg82r3.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17286>

On 3/6/06, Junio C Hamano <junkio@cox.net> wrote:
> - The deathmatch between annotate/blame (Ryan Anderson, Fredrik
>   Kuivinen, me cheerleading)

Add fuel to the fire  ;-) Can git-blame take cached git-rev-list
output like annotate does with -S?


m
