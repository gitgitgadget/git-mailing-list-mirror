From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: [PATCH] gitweb: Add some installation notes in gitweb/INSTALL
Date: Sat, 24 Mar 2007 23:18:48 -0300
Message-ID: <f329bf540703241918y22830d50jbf20928d402c67fe@mail.gmail.com>
References: <etufpl$7en$1@sea.gmane.org>
	 <11747663931269-git-send-email-jnareb@gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 04:18:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVIJp-0004Rw-0i
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 04:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbXCYCSu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 22:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbXCYCSu
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 22:18:50 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:28061 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964806AbXCYCSt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 22:18:49 -0400
Received: by an-out-0708.google.com with SMTP id b33so1908932ana
        for <git@vger.kernel.org>; Sat, 24 Mar 2007 19:18:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pOMEnY5a1Ym9W2XtJUle6rb/AE5ugeAb3BOj6W035LARtdrDBnzK3EFantXAdkB61sc66NTL3VzCZfmGeo43yHSQuXNAQvua6bWL8gcPG2hyQsMwC4YuobSOrS44JKP82S0zd+zEDVRct4cvRK89PXbdIm6w7LH9cCQply4T/2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gajRQW0n0C/CcD0dzG9y6uXwhxm69MQ0o4YXkDpD8xRHrnDEt5SgLuc16FaL1TgDFfCJ9c793f7AGzftHgiDNw0fgRgL8gURuIM+l3rk2kg8tbFOIIXAB/FBb2FhE2TfhDPgwClAI0uSFQDARSylf73DWT0IIT5uAMDdPI1NJjQ=
Received: by 10.100.112.19 with SMTP id k19mr3851887anc.1174789128379;
        Sat, 24 Mar 2007 19:18:48 -0700 (PDT)
Received: by 10.100.92.11 with HTTP; Sat, 24 Mar 2007 19:18:48 -0700 (PDT)
In-Reply-To: <11747663931269-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43030>

2007/3/24, Jakub Narebski <jnareb@gmail.com>:
> Add some installation and configuration notes for gitweb in
> gitweb/INSTALL. Make use of filling gitweb configuration by
> Makefile.
>
> It does not cover (yet?) all the configuration variables and
> options.

I got it running with the help of the list, but this patch surely
improves the state of the docs. Just one nit: it should give a small
example of the desired syntax of the gitweb_conf.perl file

-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
