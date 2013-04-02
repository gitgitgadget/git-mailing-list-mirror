From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: Aw: Re: [PATCH 3/3] Remove definition of refspec and
 pathspec from glossary-content.txt
Date: Tue, 2 Apr 2013 19:34:01 +0200 (CEST)
Message-ID: <1581037762.741803.1364924041066.JavaMail.ngmail@webmail15.arcor-online.net>
References: <7vwqsketim.fsf@alter.siamese.dyndns.org> <7vy5d0gbkj.fsf@alter.siamese.dyndns.org>
 <1481339149.727628.1364894663266.JavaMail.ngmail@webmail14.arcor-online.net>
 <1622068154.727718.1364894924364.JavaMail.ngmail@webmail14.arcor-online.net>
 <1741446121.741075.1364922350572.JavaMail.ngmail@webmail15.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Tue Apr 02 19:34:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN56U-0003Ul-Ds
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 19:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758614Ab3DBReE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 13:34:04 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:46807 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758562Ab3DBReC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 13:34:02 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mx.arcor.de (Postfix) with ESMTP id 1F4A9E3B69;
	Tue,  2 Apr 2013 19:34:01 +0200 (CEST)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 1B31C7FEFAA;
	Tue,  2 Apr 2013 19:34:01 +0200 (CEST)
Received: from webmail15.arcor-online.net (webmail15.arcor-online.net [151.189.8.68])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 152672D629D;
	Tue,  2 Apr 2013 19:34:01 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-10.arcor-online.net 152672D629D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1364924041; bh=APn6GX5KO4lP1E9Njb03k/75DjGei70AYSpHmXOh+Gg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=hcvNngChHWjQT3euGgviGMCuHppb2XZYEwHxF23oJzWi9rWkljRzFH0nEfvfAP44a
	 oV8C9znRnenwxcxXfgqqI5LL+2Gq2A0KOZ17kULaV4v2E6KZ3FUG6RYb9B+zYD9JNP
	 5z0qgfYG7bLqFHg8bBQMgveznIcKgWE1Y37+jsOA=
Received: from [94.217.19.243] by webmail15.arcor-online.net (151.189.8.68) with HTTP (Arcor Webmail); Tue, 2 Apr 2013 19:34:00 +0200 (CEST)
In-Reply-To: <7vwqsketim.fsf@alter.siamese.dyndns.org>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.19.243
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219814>

 
> 
> That is only because the last example the "See ... for details"
> refers to is about 'git push', isn't it?
> 
This is correct but there was no direct link to git-fetch in the first example
and I did not check which combination of man pages gives the complete
definition of refspecs ...


---
Thomas
