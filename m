From: Srijak Rijal <srijak@gmail.com>
Subject: Re: Gittorent .. avahi ?
Date: Tue, 03 Apr 2007 20:58:11 -0400
Message-ID: <4612F823.2060503@gmail.com>
References: <9d916d5b0704011059g31394159kfdd5e01ba81915c2@mail.gmail.com> <euurc0$js8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 02:58:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYtpP-0000iY-Tp
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 02:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966215AbXDDA6V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 20:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966218AbXDDA6V
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 20:58:21 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:47372 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966215AbXDDA6U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 20:58:20 -0400
Received: by an-out-0708.google.com with SMTP id b33so38536ana
        for <git@vger.kernel.org>; Tue, 03 Apr 2007 17:58:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=WeXq+zY63MqBg2y/ppa5TRDSyWUQKvurrhaCc5bFUJHB8wTUZQPck+WELYoc4IlQEBmvSiRQN+IJUFInE9KfJkM/G4QcLdQiQxFnMsdz1eQxgCMYW8AoBscgNs5vnyY0GB7vf6+LNWLPCldn+MYZLjQ8Q+0nbCcdZ++3io0h2Bw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=FOcxjkgutEM/6Wb3G9AaJifSZyip+eXsTnTJB4AoBps9hOnF2sseXalOo3ERNhqEXasLJcipOZrJnPuXBIz2VUGYHy+osKP0l31U2PdDe3tco7UhVd3RnHppjE836GjJVt4bOELn5NAlmkc6PYe6j4ZZZG5SBE3ZpsaLGu30Ino=
Received: by 10.100.143.1 with SMTP id q1mr68455and.1175648299721;
        Tue, 03 Apr 2007 17:58:19 -0700 (PDT)
Received: from ?192.168.2.8? ( [24.127.52.205])
        by mx.google.com with ESMTP id c20sm205633ana.2007.04.03.17.58.18;
        Tue, 03 Apr 2007 17:58:19 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
In-Reply-To: <euurc0$js8$1@sea.gmane.org>
X-Enigmail-Version: 0.94.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43700>

Hi Jakub,
> I hope that you have not missed deadline.
>
>   
I have already applied :)
> Avahi is Zeroconf implementation... wouldn't it be better to think
> about implementing Kademlia?
>
>   
Kademlia is something to look at. But not anytime soon :).
The current-"est" and working plan is to strictly follow the spec for
functionality.
Then, according to community requirement/recommendation etc. features
will be added.


Srijak.
