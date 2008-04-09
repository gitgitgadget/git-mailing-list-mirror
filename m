From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/8] config.c: Escape backslashes in section names properly
Date: Wed, 09 Apr 2008 08:31:12 +0200
Message-ID: <47FC62B0.3060802@viscovery.net>
References: <> <cover.1207702130.git.bdonlan@fushizen.net> <1207704604-30393-1-git-send-email-bdonlan@fushizen.net> <1207704604-30393-2-git-send-email-bdonlan@fushizen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	gitster@pobox.com
To: Bryan Donlan <bdonlan@fushizen.net>
X-From: git-owner@vger.kernel.org Wed Apr 09 08:32:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjTqq-0005cw-2q
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 08:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbYDIGbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 02:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753919AbYDIGbW
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 02:31:22 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:6913 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865AbYDIGbU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 02:31:20 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JjTpw-0004rt-NO; Wed, 09 Apr 2008 08:31:12 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5EF25546; Wed,  9 Apr 2008 08:31:12 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1207704604-30393-2-git-send-email-bdonlan@fushizen.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79074>

Bryan Donlan schrieb:
> Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>

What is your definition of "properly"? Please give an example of what went
wrong.

-- Hannes
