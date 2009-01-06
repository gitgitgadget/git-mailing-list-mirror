From: jidanni@jidanni.org
Subject: git-completion.bash missing --help
Date: Tue, 06 Jan 2009 11:29:14 +0800
Message-ID: <877i59nmd1.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 04:33:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK2gd-0004Ey-RH
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 04:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbZAFD3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 22:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbZAFD3R
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 22:29:17 -0500
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:44750 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750836AbZAFD3R (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jan 2009 22:29:17 -0500
Received: from jidanni.org (122-127-36-59.dynamic.hinet.net [122.127.36.59])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 828B4119DEA;
	Mon,  5 Jan 2009 19:29:16 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104631>

git-completion.bash seems to be missing --help. Hitting TAB just shows e.g.,
$ git add --<TAB>
--dry-run --ignore-errors --interactive --patch --refresh --update
Only for plain
$ git --<TAB>
is one able to complete --help.
