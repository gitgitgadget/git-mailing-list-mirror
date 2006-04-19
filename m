From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: GIT Error issue
Date: Thu, 20 Apr 2006 09:53:45 +1200
Message-ID: <46a038f90604191453q567192b0l9a35d50f96f8705d@mail.gmail.com>
References: <3857255c0604190416j62abeae8va164896c5100f6ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 23:53:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWKcR-0004D4-GW
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 23:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWDSVxs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 17:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWDSVxs
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 17:53:48 -0400
Received: from wproxy.gmail.com ([64.233.184.231]:26795 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751262AbWDSVxr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 17:53:47 -0400
Received: by wproxy.gmail.com with SMTP id i2so405519wra
        for <git@vger.kernel.org>; Wed, 19 Apr 2006 14:53:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YukMjiu+5WZJhdMhlHWDH2fw2Im6BdznEoNxhssAWBxMcn8Eu6dp1Y5jyOQE6BTjSKokWOTFI+9wIqWcAKtGfEoS4zQTwL6O7KNhvfOqryrobox7KQT2xivmpw4fMJ2Vf7hAR0BpbCuVXoSp7Krj0fYKxTmjrC4uXbb21o1uJTU=
Received: by 10.54.60.26 with SMTP id i26mr119411wra;
        Wed, 19 Apr 2006 14:53:45 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Wed, 19 Apr 2006 14:53:45 -0700 (PDT)
To: "Shyamal Sadanshio" <shyamal.sadanshio@gmail.com>
In-Reply-To: <3857255c0604190416j62abeae8va164896c5100f6ee@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18943>

If you are using Debian or a derivative, just do

   apt-get install git-core

which will remove the 'git' package (GNU Interactive Tools) and
install the git SCM. On RPM systems, probably

   yum install git-core

will do the trick.

cheers,


martin
