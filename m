From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: [PATCH 3/3] Remove definition of refspec and pathspec from
 glossary-content.txt
Date: Tue, 2 Apr 2013 19:05:50 +0200 (CEST)
Message-ID: <1741446121.741075.1364922350572.JavaMail.ngmail@webmail15.arcor-online.net>
References: <7vy5d0gbkj.fsf@alter.siamese.dyndns.org> <1481339149.727628.1364894663266.JavaMail.ngmail@webmail14.arcor-online.net>
 <1622068154.727718.1364894924364.JavaMail.ngmail@webmail14.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Tue Apr 02 19:06:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN4fY-0001M8-Ix
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 19:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760545Ab3DBRGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 13:06:04 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:40855 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761822Ab3DBRFw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 13:05:52 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mx.arcor.de (Postfix) with ESMTP id 9D3F72D629E;
	Tue,  2 Apr 2013 19:05:50 +0200 (CEST)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 99D01562ED3;
	Tue,  2 Apr 2013 19:05:50 +0200 (CEST)
Received: from webmail15.arcor-online.net (webmail15.arcor-online.net [151.189.8.68])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 92EED2D629E;
	Tue,  2 Apr 2013 19:05:50 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-10.arcor-online.net 92EED2D629E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1364922350; bh=X5IMCCUPLskrHvKl8lAFNLg9i1WueRQveWQ0f2PQBfs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=SDKESJlfksvbNvxM83iCgLO5OAssb3zqny/qCyYi2LvPHRYgDTJYRY57HooZPjnrf
	 NX/Q4gXATWHXr7Z3iSmSVOQiqfmWzf62K6a4bClLnXCwSc36E/si35Az9GQW1gT7kd
	 TqgIdreQp+wTFS2irbTukvR3V8dHMKdxVEYT9ioQ=
Received: from [94.217.19.243] by webmail15.arcor-online.net (151.189.8.68) with HTTP (Arcor Webmail); Tue, 2 Apr 2013 19:05:50 +0200 (CEST)
In-Reply-To: <7vy5d0gbkj.fsf@alter.siamese.dyndns.org>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.19.243
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219801>

 
> 
> I think we can just drop "See ... for details" from here.  Besides,
> why just "push" and not "fetch"?
> 

I just kept the original reference which only linked to git-push.


---
Thomas
