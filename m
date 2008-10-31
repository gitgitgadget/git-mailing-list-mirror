From: Alessandro Guido <ag@alessandroguido.name>
Subject: Re: git archive problem with 1.6.0.3 (maybe regression?)
Date: Fri, 31 Oct 2008 23:43:39 +0100
Message-ID: <200810312343.40354.ag@alessandroguido.name>
References: <200810312213.32224.ag@alessandroguido.name> <490B8896.6040007@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 23:44:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw2jR-0004AN-K4
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 23:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbYJaWn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 18:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbYJaWn2
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 18:43:28 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:43608 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbYJaWn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 18:43:27 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1154890fgg.17
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 15:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=OVxzus8+Fz4nd7Tod1tSaBX843Nv46M+bDylHgx5MDA=;
        b=L5PTH6ccLjb+oeRQADw/CSKdJpXbTh+2096Y3OpIesU+Pjsls0b7Zks3yGb9VMkyWL
         vLEcMZlPkhmEd/FZEe+bYHQZSiIZJzqbdHhgYpXV/kno8lLFk3QoNQMsqDaKE6FAvHdA
         rflHgivtcwI8315T1Bvwd607u2y7cE1cgdSUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=RTeEWhVK/ZTFH7rxAUS/UrNtsEYbsrAqwfjoWeZG3HDigaS37WV/70HfVWjUMRUmyT
         aBwRaM1t/Mzt+aRc0F5zGH5YwVfu5CHVxM54u1suc4zKnMcwo2qw1isaatkYs2wQPorG
         QPd+W4v7hfMQvzcos2IbCGYg6diTZfXU9qQ18=
Received: by 10.86.66.19 with SMTP id o19mr8756593fga.18.1225493005311;
        Fri, 31 Oct 2008 15:43:25 -0700 (PDT)
Received: from odino.localnet ([151.65.145.100])
        by mx.google.com with ESMTPS id 3sm4835341fge.3.2008.10.31.15.43.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Oct 2008 15:43:24 -0700 (PDT)
User-Agent: KMail/1.10.1 (Linux/2.6.28-rc2-385-g721d5df; KDE/4.1.2; i686; ; )
In-Reply-To: <490B8896.6040007@hashpling.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99666>

On Friday 31 October 2008 23:37:10 Charles Bailey wrote:
> http://git.kernel.org/?p=git/git.git;a=commit;h=ddff8563510a2c5c675d488a02e
>2642306430fc1

Good. Thank you for the link
