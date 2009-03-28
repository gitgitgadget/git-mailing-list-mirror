From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 1/2] init: support --import to add all files and commit right after init
Date: Sat, 28 Mar 2009 11:58:50 +0100
Message-ID: <200903281158.51012.markus.heidelberg@web.de>
References: <1237978720-2500-1-git-send-email-pclouds@gmail.com> <200903262223.28546.markus.heidelberg@web.de> <alpine.DEB.1.00.0903270259470.10279@pacific.mpi-cbg.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Santi =?iso-8859-1?q?B=E9jar?= <santi@agolina.net>,
	Jeff King <peff@peff.net>,
	Nguydn =?iso-8859-1?q?Th=E1i_Ngdc?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 28 12:01:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnWHd-0003aw-OK
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 12:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbZC1K65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 06:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753246AbZC1K64
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 06:58:56 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:42764 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbZC1K6z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 06:58:55 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id F1DF6FF18446;
	Sat, 28 Mar 2009 11:58:52 +0100 (CET)
Received: from [89.59.72.204] (helo=.)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LnWFY-00031p-00; Sat, 28 Mar 2009 11:58:52 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0903270259470.10279@pacific.mpi-cbg.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+nlcfv7eh6oHru3bqohlnQ9Z2NEZR7oPzL8lvy
	rjbcdDUacTo+7EnGLD2TrvV810jxEqyB8s1kPFCS3GFhzZjmSo
	9U7nK+es54xyaoCdmQQQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114949>

Johannes Schindelin, 27.03.2009:
> Others who want to have a quick way to work safely with something they 
> might need to change, and might then want to use the full power of Git to 
> see what they changed.  Without any need for a "nice" first commit.

What's the difference between the first commit and the others? I don't
see the reason, not to have a short description for it.

Markus
