From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: git format-patch
Date: Thu, 18 Jun 2009 11:57:28 +0200
Message-ID: <200906181157.29032.markus.heidelberg@web.de>
References: <1976ea660906170703k1f17301gcbae4a8bc8805014@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 11:57:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHENB-0004Ei-2W
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 11:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756036AbZFRJ5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 05:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756218AbZFRJ5M
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 05:57:12 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:39010 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298AbZFRJ5L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 05:57:11 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 176F8100650DE;
	Thu, 18 Jun 2009 11:57:13 +0200 (CEST)
Received: from [89.59.73.110] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MHEMq-0007M7-00; Thu, 18 Jun 2009 11:57:13 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1976ea660906170703k1f17301gcbae4a8bc8805014@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19VVwot8OC8UevaYeNFH7lPwwvsOxssy7PL38sA
	t12t3FOYytncKCOg4uE/p/wGKM7FQ2kg+9NkGPLnKVef7NeHGI
	ulIFrZ/XX7sntFmd6VTw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121826>

Frank Li, 17.06.2009:
> git format-patch -4
> only 3 patchs is created
> 
> git format-patch -5
> 4 patchs is created
> 
> I remember old git version -<n>, n patchs is created.

Is one of the last 4 commits a merge commit?
