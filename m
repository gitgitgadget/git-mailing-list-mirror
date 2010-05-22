From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCHv2 GSoC] git-instaweb: Configure it to work with new gitweb 
	structure
Date: Sun, 23 May 2010 00:48:12 +0530
Message-ID: <AANLkTikSJQ7MMWytdMjJwaP1YBV1lebo4f7I4OUOIXAV@mail.gmail.com>
References: <1274523105-3327-1-git-send-email-pavan.sss1991@gmail.com>
	 <201005221757.38376.jnareb@gmail.com>
	 <AANLkTinbzlRsmQekpLlFQC3xOMB2ZUurLqJoyFCnHZFG@mail.gmail.com>
	 <201005222059.54995.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 22 21:18:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFuDD-0004KN-1f
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 21:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757983Ab0EVTSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 15:18:14 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46314 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773Ab0EVTSN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 15:18:13 -0400
Received: by gwaa20 with SMTP id a20so966207gwa.19
        for <git@vger.kernel.org>; Sat, 22 May 2010 12:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=st1B8GMoX3MbcvyBrteUAOzU/fGwGhvz+ounB6Xy+Zo=;
        b=mMnxLLlBQy9NlzKDs0ceIgmKAKtY/0C2f4N391eb/5mic0yq+U8DUshdoF+x8w5PwR
         gMPBse2XY1RFhp5e9w3qHoFd4q74oc8A1Q9eIAf+nNl44YTe9Pw2CzcYj23Xe7i3Bt9Q
         Kr8OM97tSTbtr7r7QQBdLfn7LQswUn/goxe00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lthTLuWZXp6x2Dk2TBj9nGj0qH+kMEjeKXBCV21+2f5sJ2SmbQ2FfPjsaO3/4I96HQ
         KKMnnXBtGatXiYILSK7zGsxq7TwTlJmpVbh4x0m6RZcZpofT0ViY2zplM04scuqF9hYd
         PSj3J0lIzlhGkFf3fPuNTLhwWysjm2pFt1nLY=
Received: by 10.91.161.39 with SMTP id n39mr1804781ago.55.1274555892885; Sat, 
	22 May 2010 12:18:12 -0700 (PDT)
Received: by 10.90.84.5 with HTTP; Sat, 22 May 2010 12:18:12 -0700 (PDT)
In-Reply-To: <201005222059.54995.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147538>

No. It doesn't.

Do you want me to make that change to and send the patch again ?

- Pavan
