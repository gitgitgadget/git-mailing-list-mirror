From: jidanni@jidanni.org
Subject: Re: just can't live without a user.name
Date: Sat, 20 Dec 2008 08:36:49 +0800
Message-ID: <877i5vbs2m.fsf@jidanni.org>
References: <20081220000803.GK21154@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: vmiklos@frugalware.org
X-From: git-owner@vger.kernel.org Sat Dec 20 01:38:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDprA-0007PG-AF
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 01:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbYLTAgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 19:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752767AbYLTAgy
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 19:36:54 -0500
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:47854 "EHLO
	homiemail-a3.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752638AbYLTAgy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Dec 2008 19:36:54 -0500
Received: from jidanni.org (122-127-33-249.dynamic.hinet.net [122.127.33.249])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a3.dreamhost.com (Postfix) with ESMTP id BD994C5222;
	Fri, 19 Dec 2008 16:36:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103612>

MV> I said you can use utf-8 in the user.name field and showed you an example
But I want to use null or (my favorite string of) ASCII.
Anyway no program so far on UNIX broke with just
$ grep $USER /etc/passwd
jidanni:x:1000:1000:,,,:/home/jidanni:/bin/bash
except git.
