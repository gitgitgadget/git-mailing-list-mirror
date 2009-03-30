From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re:
Date: Mon, 30 Mar 2009 09:02:28 +0200
Message-ID: <200903300902.28821.markus.heidelberg@web.de>
References: <1238389428-69328-1-git-send-email-davvid@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 09:04:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoBXM-0001o0-Ic
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 09:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbZC3HCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 03:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbZC3HCa
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 03:02:30 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:37776 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbZC3HC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 03:02:29 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 84D91F9B9B84;
	Mon, 30 Mar 2009 09:02:27 +0200 (CEST)
Received: from [89.59.73.72] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LoBVr-0006WI-00; Mon, 30 Mar 2009 09:02:27 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1238389428-69328-1-git-send-email-davvid@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+K/6x4rrjBJRKqdfDOCnsgMydiv3ybDn9+oTFC
	EpnswxnuEVOzRpXPo7Etq7bZWplcF1sHKQXVcdKYS35oSCbHzE
	3/AEp4yUPseuTDl5Ab7g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115094>

David Aguilar, 30.03.2009:
> This is based on top of Junio's "pu" branch and is a
> continuation of the recent difftool series.

For everyone who wants to apply the patch series: Patch 5/8 depends on
this:
  [PATCH v2] difftool: add support for a difftool.prompt config variable
sent about 8 minutes before this series.

Markus
