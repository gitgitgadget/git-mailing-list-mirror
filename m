From: jidanni@jidanni.org
Subject: gitk --help doesn't
Date: Tue, 06 Jan 2009 11:22:06 +0800
Message-ID: <87aba5nmox.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 04:23:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK2XS-0002f2-Pc
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 04:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbZAFDWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 22:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbZAFDWJ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 22:22:09 -0500
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:37594 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751301AbZAFDWI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jan 2009 22:22:08 -0500
Received: from jidanni.org (122-127-36-59.dynamic.hinet.net [122.127.36.59])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 47DA4119E28
	for <git@vger.kernel.org>; Mon,  5 Jan 2009 19:22:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104629>

gitk --help doesn't print the man text, instead it furls headlong
into, well, gitk --help which of course is not a happy scene.
