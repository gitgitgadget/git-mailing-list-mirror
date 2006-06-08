From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: [PATCH 0/2] Introduce ~/.gitconfig
Date: Thu, 8 Jun 2006 14:06:18 +0200
Message-ID: <dbfc82860606080506y52dc2771sbf6c90e7246ca4c9@mail.gmail.com>
References: <Pine.LNX.4.63.0606081329200.11910@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060608120216.46722.qmail@web25908.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Jun 08 14:06:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoJHM-00066r-OJ
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 14:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWFHMGU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 08:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWFHMGU
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 08:06:20 -0400
Received: from wx-out-0102.google.com ([66.249.82.199]:36600 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964811AbWFHMGT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 08:06:19 -0400
Received: by wx-out-0102.google.com with SMTP id h28so289329wxd
        for <git@vger.kernel.org>; Thu, 08 Jun 2006 05:06:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=l7euMIsMmDhowHlfDsGqxjZE86JDfc/zkGVoVXrmEuUrPrxl0WANnIofxZTHQiyC14LPm9pYJ2QzA65JjJxBMoJpaOAz9gYxC4YZj5Fg6oaphZv/7RIMCpv4WvLgy/whHN3rMza/YE7KC1LSLjKjU2ztGSzgf47ky21QrSNW278=
Received: by 10.70.7.5 with SMTP id 5mr1928952wxg;
        Thu, 08 Jun 2006 05:06:18 -0700 (PDT)
Received: by 10.70.66.6 with HTTP; Thu, 8 Jun 2006 05:06:18 -0700 (PDT)
To: "Sven Ekman" <svekman@yahoo.se>
In-Reply-To: <20060608120216.46722.qmail@web25908.mail.ukl.yahoo.com>
Content-Disposition: inline
X-Google-Sender-Auth: 1a58cae99765d2fd
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21483>

On 6/8/06, Sven Ekman <svekman@yahoo.se> wrote:
> <Johannes.Schindelin@gmx.de> skrev:
>
> > There are three subjects for discussion:
>
> Have you considered making ~/.gitconfig a directory?
> Maybe Git wants to store more data later.

I second that.  And it'd be nice if it was configurable through
an environment variable, e.g., GIT_USER_CONFIG_HOME.
A better name may be possible ;-).

  nikolai
