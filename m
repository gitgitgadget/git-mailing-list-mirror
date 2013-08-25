From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: [PATCH 06/13] Simplify "How to make a commit"
Date: Sun, 25 Aug 2013 11:20:04 +0200 (CEST)
Message-ID: <397485266.481399.1377422404293.JavaMail.ngmail@webmail16.arcor-online.net>
References: <20130825050527.GI2882@elie.Belkin> <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
 <1687455733.1090999.1377329376866.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, wking@tremily.us
To: jrnieder@gmail.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Sun Aug 25 11:20:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDWUW-0002lb-Lf
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 11:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756216Ab3HYJUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 05:20:07 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:44451 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755103Ab3HYJUF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Aug 2013 05:20:05 -0400
Received: from mail-in-20-z2.arcor-online.net (mail-in-20-z2.arcor-online.net [151.189.8.85])
	by mx.arcor.de (Postfix) with ESMTP id 51708A9D3F;
	Sun, 25 Aug 2013 11:20:04 +0200 (CEST)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-20-z2.arcor-online.net (Postfix) with ESMTP id 4BF9B834005;
	Sun, 25 Aug 2013 11:20:04 +0200 (CEST)
Received: from webmail16.arcor-online.net (webmail16.arcor-online.net [151.189.8.70])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 4230A3AE433;
	Sun, 25 Aug 2013 11:20:04 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-08.arcor-online.net 4230A3AE433
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377422404; bh=+GQ2LtmUWUP3UVroQff9a01jjR0o5Th+mS6EXDVPSyU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=J6dqEGu9F7lQVWERbsOcsf/rbfc21FkaCnurcuCYxnjYXVBq4gAIfVwKkG5ULSBwK
	 VRzXeYQHvpf6blqSEPm7fJrX05yPxrZd1aduKCdoZoqA6RoT4fFFLNbvCexEHJVt5W
	 WIDfyE4Fyx+HxwqilDTfBAwpqlPmxNVIAYV8HTTM=
Received: from [178.7.23.208] by webmail16.arcor-online.net (151.189.8.70) with HTTP (Arcor Webmail); Sun, 25 Aug 2013 11:20:04 +0200 (CEST)
In-Reply-To: <20130825050527.GI2882@elie.Belkin>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.23.208
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232943>

 
> 
> That's a mouthful.  I'd say
> 
> 	To update the index with the contents of a new or modified file, use
> 

OK; thanks! I will change this.


---
Thomas
