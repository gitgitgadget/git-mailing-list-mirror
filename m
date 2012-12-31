From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: Aw: Re: [PATCH 0/3] Move CodingGuidelines and
 SubmittingPatches to ./Documentation/technical
Date: Mon, 31 Dec 2012 10:33:51 +0100 (CET)
Message-ID: <2010399637.417873.1356946431500.JavaMail.ngmail@webmail08.arcor-online.net>
References: <7v1ue7fcbh.fsf@alter.siamese.dyndns.org> <1965427282.405137.1356879393533.JavaMail.ngmail@webmail18.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: artagnon@gmail.com, git@vger.kernel.org
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Mon Dec 31 10:34:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpblR-0005dK-Qt
	for gcvg-git-2@plane.gmane.org; Mon, 31 Dec 2012 10:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883Ab2LaJdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 04:33:54 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:48210 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750719Ab2LaJdx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Dec 2012 04:33:53 -0500
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mx.arcor.de (Postfix) with ESMTP id 8B507198302;
	Mon, 31 Dec 2012 10:33:51 +0100 (CET)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 8AEEF7FEE9A;
	Mon, 31 Dec 2012 10:33:51 +0100 (CET)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 8044CAA5D3;
	Mon, 31 Dec 2012 10:33:51 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-04.arcor-online.net 8044CAA5D3
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1356946431; bh=ABM5M83UB4NvA7M1tg3486/FQpXCVN1AkzUPfgDUmU4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=R5b1qRd747EeOOQmDgN5UYESNEU4aVwEFwvWyciut4j3RvA1SEmUrpvWbTC/+2L+o
	 WVfdHb5spRxIC8iZy8PH6Jvz1vy6vwyr6FPNnNQzeNn7mnoGS/iIibitNuQwxRAzZ1
	 2C03qJq/OrmMEeoPZKguVkoscZIe9FGyfHBLHIkc=
Received: from [178.7.24.66] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Mon, 31 Dec 2012 10:33:51 +0100 (CET)
In-Reply-To: <7v1ue7fcbh.fsf@alter.siamese.dyndns.org>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.24.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212349>

 
> 
> Implementation details are part of API; CG and SP are social not
> technical.
> 
This depends on your definition of "social" ;-)
> 
> Also CG and SP are in the part of the documents that are not
> installed for end-users and that is their right place.  They matter
> only to the people who grab our source code.
> 
But isn't that true for all files in ./technical? CG and SP currently
are in ./Documentation which contains *only* files which are installed
for end-users with CG and SP the only exception ...


---
Thomas
