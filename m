From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: [PATCH 11/13] Remove obscure reference from "Examples"
Date: Sun, 25 Aug 2013 11:30:15 +0200 (CEST)
Message-ID: <923442091.481498.1377423015102.JavaMail.ngmail@webmail16.arcor-online.net>
References: <20130825052553.GL2882@elie.Belkin> <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
 <883409466.1091151.1377329645768.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, wking@tremily.us
To: jrnieder@gmail.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Sun Aug 25 11:30:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDWeU-0003Oo-OK
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 11:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756176Ab3HYJaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 05:30:17 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:52275 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754619Ab3HYJaQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Aug 2013 05:30:16 -0400
Received: from mail-in-18-z2.arcor-online.net (mail-in-18-z2.arcor-online.net [151.189.8.35])
	by mx.arcor.de (Postfix) with ESMTP id 1E87A1975AB;
	Sun, 25 Aug 2013 11:30:15 +0200 (CEST)
Received: from mail-in-17.arcor-online.net (mail-in-17.arcor-online.net [151.189.21.57])
	by mail-in-18-z2.arcor-online.net (Postfix) with ESMTP id 168B033B52D;
	Sun, 25 Aug 2013 11:30:15 +0200 (CEST)
Received: from webmail16.arcor-online.net (webmail16.arcor-online.net [151.189.8.70])
	by mail-in-17.arcor-online.net (Postfix) with ESMTP id 16560CBAB1;
	Sun, 25 Aug 2013 11:30:15 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-17.arcor-online.net 16560CBAB1
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377423015; bh=0UTmgy9dQQJ+kXgbaSIsOxBwAnF7TU3uXwKoWDz24xU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=QwrxeyJVuJrTVqh9ff/BvaY1AFcimpzDRDM+CEN5h4qYTUMoVkh7BeUDbVxn7dA/j
	 pmpHvPGN4SreNp/nSrCiZsuMtzDn9Bs45JhHVkt2Cu4VHKqKhd5Ac3/JtOhu0obsBD
	 tplM/UZJi2KzOBlaK0zqeBkTBqX5RHGktcP61jo8=
Received: from [178.7.23.208] by webmail16.arcor-online.net (151.189.8.70) with HTTP (Arcor Webmail); Sun, 25 Aug 2013 11:30:15 +0200 (CEST)
In-Reply-To: <20130825052553.GL2882@elie.Belkin>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.23.208
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232944>

 
> >  
> >   - A "test" tree into which patches are initially placed so that they
> >     can get some exposure when integrated with other ongoing development.
> > -   This tree is available to Andrew for pulling into -mm whenever he
> > -   wants.
> 
> This drops useful information (namely, that Tony was publishing
> history for two people to consume).  Perhaps it should spell out "the
> bleeding-edge -mm tree"?
> 

This is even worse for me;-) For everyone not involved in Linux kernel development
this sentence completely makes no sense. Is there perhaps a more general
description for the situation?


---
Thomas
