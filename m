From: Christoph Duelli <duelli@melosgmbh.de>
Subject: how to ignore all .xvpics directories
Date: Mon, 03 Nov 2008 11:11:32 +0100
Message-ID: <490ECE54.5090505@melosgmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 11:28:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwwfI-00006d-V9
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 11:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941AbYKCK0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 05:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754943AbYKCK0w
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 05:26:52 -0500
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:41051 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754941AbYKCK0v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 05:26:51 -0500
X-RZG-CLASS-ID: mo00
X-RZG-AUTH: :P2kWY0mrft+7PRqjQVQfkgnIveo2zsFMc4bua7BlzFdiPwP9DUuD8pO0q5s=
Received: from mail.melosgmbh.de (p5B07AD3C.dip0.t-ipconnect.de [91.7.173.60])
	by post.webmailer.de (mrclete mo45) (RZmta 17.14)
	with ESMTP id 600e14kA39uYLp for <git@vger.kernel.org>;
	Mon, 3 Nov 2008 11:14:58 +0100 (MET)
	(envelope-from: <duelli@melosgmbh.de>)
X-Spam-Status: No, hits=0.0 required=4.0
	tests=AWL: 0.034,BAYES_00: -1.665,TOTAL_SCORE: -1.631
X-Spam-Level: 
Received: from [172.27.1.229] ([172.27.1.229])
	(authenticated user duelli@melosgmbh.de)
	by mail.melosgmbh.de (Kerio MailServer 6.4.1 patch 1)
	for git@vger.kernel.org;
	Mon, 3 Nov 2008 11:14:54 +0100
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99928>

Is it possible to ignore (once and for all) that directories like .pics 
or .xvpics (that might occur all over the place where xv was called) 
should be ignored?

[ Note: some time ago this issue has already popped up:
http://thread.gmane.org/gmane.comp.version-control.git/50504

However, adding a line with just .xvpics in the toplevel .gitignore does 
not help. Neither does /**/.xvpics
]

Best regards
-- 
Christoph Duelli
