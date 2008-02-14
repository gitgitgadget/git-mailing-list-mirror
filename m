From: "Vincent Legoll" <vincent.legoll@gmail.com>
Subject: [PATCH][EGIT] README typo fixes
Date: Thu, 14 Feb 2008 23:47:49 +0100
Message-ID: <4727185d0802141447j4b34958eg5dea5daf52346345@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: spearce@spearce.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 14 23:48:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPmsX-0005N6-6E
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 23:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758117AbYBNWrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 17:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757878AbYBNWrz
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 17:47:55 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:26957 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757046AbYBNWry (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 17:47:54 -0500
Received: by wx-out-0506.google.com with SMTP id h31so457933wxd.4
        for <git@vger.kernel.org>; Thu, 14 Feb 2008 14:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=FdzNV0wLSDb41Pu37QjLvqdX4BYN54bEcj5EhFVMpS0=;
        b=WiVAgAFZlvm6r8xEiox+Ot/+g67qkKrOnVbi7iCXlTB6wT7RURxPn8ht5/zvK7Q/E7gRdsKkCe44n72Pcpte4sJSWKHXQIOr0h335NEYnpksfpe04UIqSF1O/+K3fcfq4RXuuvpunWvunQhDaCjY5JhF83yGwNGJqwXqAXDtfTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EZ70YkD0I7tL42SFzFQTJ1WdS/3D0TUnI6MCel5VvwNSZZMtZ20hQMl89YXgzKebU4JwoTnHUclwrY7KirLrrCBjpJz5ndvh9wOtTLszf1a1DCz6IbvZIpPonSpZxZObdD1Gd7+na3bz1mYhcQvR02Eg67JsI3vFjQysY5Av8m0=
Received: by 10.70.135.3 with SMTP id i3mr1235963wxd.36.1203029269969;
        Thu, 14 Feb 2008 14:47:49 -0800 (PST)
Received: by 10.70.84.14 with HTTP; Thu, 14 Feb 2008 14:47:49 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73920>

Hello,

Reading egit README file I fixed a bunch of typos, random
whitespace and such small things, and produced the attached
patch, could you integrate it in your repository ?

-- 
Vincent Legoll
