From: Christoph Bartoschek <bartoschek@gmx.de>
Subject: Setting http proxy and http password
Date: Mon, 22 Nov 2010 23:39:52 +0100
Organization: =?UTF-8?B?VW5pdmVyc2l0w6R0?= Bonn
Message-ID: <o28rr7-5r4.ln1@homer.bruehl.pontohonk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 22 23:40:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKf3o-0003Ys-Qr
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 23:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757752Ab0KVWkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 17:40:19 -0500
Received: from lo.gmane.org ([80.91.229.12]:39259 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757741Ab0KVWkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 17:40:16 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PKf3X-0003Pn-Gq
	for git@vger.kernel.org; Mon, 22 Nov 2010 23:40:15 +0100
Received: from p4ff4ad3b.dip.t-dialin.net ([79.244.173.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 23:40:15 +0100
Received: from bartoschek by p4ff4ad3b.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 23:40:15 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p4ff4ad3b.dip.t-dialin.net
User-Agent: KNode/4.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161915>

Hi,

I have two questions on the git http backend.

1. How can I set the proxy that should be used for git commands? For 
externals pages I have a proxy. But for our git server no proxy should be 
used. How can I configure git to never use the proxy?

2. How can I have git remember the username and password for our git server?

Christoph
