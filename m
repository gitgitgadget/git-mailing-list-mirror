From: jidanni@jidanni.org
Subject: Re: [PATCH] Documentation/git-format-patch.txt: fix weird backslash at --root
Date: Sun, 28 Dec 2008 06:36:21 +0800
Message-ID: <877i5ljlei.fsf@jidanni.org>
References: <7v4p0pcliy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 27 23:42:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGhry-0002kS-L9
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 23:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbYL0Wg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2008 17:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbYL0Wg0
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 17:36:26 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:36058 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751168AbYL0Wg0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Dec 2008 17:36:26 -0500
Received: from jidanni.org (122-127-33-180.dynamic.hinet.net [122.127.33.180])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 4D70CD270A;
	Sat, 27 Dec 2008 14:36:23 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104027>

JCH> http://www.kernel.org/pub/software/scm/git/docs/git-format-patch.html
That looks OK. All I know is on Debian (1:1.5.6.5-2) it gets rendered:
$ w3m -dump /usr/share/doc/git-doc/git-format-patch.html|fgrep \\-
    $ git format-patch \--root origin

I was patching offline from Debian. OK, in the future I will clone
upstream directly properly first.
