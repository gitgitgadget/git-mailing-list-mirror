From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: Autoconf/Automake
Date: Fri, 16 Jun 2006 08:51:22 +0200
Message-ID: <dbfc82860606152351t20b73948m646a12e2e478daaa@mail.gmail.com>
References: <1150324030.23268.12.camel@dv>
	 <20060615072450.GF7766@nowhere.earth>
	 <20060615133146.GA5794@steel.home>
	 <20060615163209.GJ7766@nowhere.earth>
	 <Pine.LNX.4.64.0606150954430.5498@g5.osdl.org>
	 <20060615211454.GK7766@nowhere.earth>
	 <Pine.LNX.4.64.0606151545050.5498@g5.osdl.org>
	 <Pine.LNX.4.63.0606160105100.7480@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Yann Dirson" <ydirson@altern.org>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Pavel Roskin" <proski@gnu.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 16 08:51:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fr8Aw-0000pa-IW
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 08:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWFPGvX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 02:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWFPGvX
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 02:51:23 -0400
Received: from wx-out-0102.google.com ([66.249.82.206]:25413 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751116AbWFPGvX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 02:51:23 -0400
Received: by wx-out-0102.google.com with SMTP id h28so388479wxd
        for <git@vger.kernel.org>; Thu, 15 Jun 2006 23:51:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=CP5rE/qRlq+KVATLbC9uvR14G7VUpBVXJ9Tx93Q7oTEa7TTMXJL2heLdSLwrrIzIBfaUCE5dHsx0bmU8XZrxbsc1strnoJfeaWNCTG/xLHQW/JOEYXZcp7moSremc+RAevSte3bMBgafQeOabsUAbwzr7uW0K6uGHRQuVOq3IgA=
Received: by 10.70.83.9 with SMTP id g9mr3488133wxb;
        Thu, 15 Jun 2006 23:51:22 -0700 (PDT)
Received: by 10.70.63.4 with HTTP; Thu, 15 Jun 2006 23:51:22 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606160105100.7480@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Google-Sender-Auth: fddfe28df29124ac
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21934>

On 6/16/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> In a project I am stuck in, maven is used. It tries -- of all things -- to
> fix a few shortcomings of ant -- which was supposed to fix shortcomings of
> make! And let's face it. Maven is complicated, slow as a dog lacking all
> four feet, and it still does not do the things I can do in three lines
> with make. It's a complete desaster.

But...it uses XML...how can it not be a panacea?

  nikolai
