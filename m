From: jidanni@jidanni.org
Subject: Re: commit.template
Date: Sat, 27 Dec 2008 09:04:06 +0800
Message-ID: <874p0qsa2h.fsf@jidanni.org>
References: <200812261853.55464.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bss@iguanasuicide.net
X-From: git-owner@vger.kernel.org Sat Dec 27 02:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGNcS-0000qk-7J
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 02:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbYL0BEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 20:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbYL0BEJ
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 20:04:09 -0500
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:54692 "EHLO
	homiemail-a4.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752084AbYL0BEJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Dec 2008 20:04:09 -0500
Received: from jidanni.org (122-127-32-218.dynamic.hinet.net [122.127.32.218])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a4.dreamhost.com (Postfix) with ESMTP id 1654E414BD;
	Fri, 26 Dec 2008 17:04:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103978>

OK, but there should be a reference to any %escapes available in
templates, etc.

Or say the template is purely and additional ".signature" style file
that will be inserted at some certain spot...
