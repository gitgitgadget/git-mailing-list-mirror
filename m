From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: visualization tool?
Date: Fri, 06 May 2005 14:40:31 +0200
Message-ID: <m3ll6sjznk.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 06 14:34:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU21y-0006ke-UE
	for gcvg-git@gmane.org; Fri, 06 May 2005 14:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVEFMkj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 08:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVEFMkj
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 08:40:39 -0400
Received: from khc.piap.pl ([195.187.100.11]:31492 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S261212AbVEFMkf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 08:40:35 -0400
Received: by khc.piap.pl (Postfix, from userid 500)
	id CDA6A1097C; Fri,  6 May 2005 14:40:31 +0200 (CEST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

Do we have anything (making sense) that can visualize a git tree?
I know gitweb.pl but it doesn't do what I want: which is displaying
a tree, displaying diffs between specific parents and childs etc.
Somebody mentioned some monotone (IIRC) util hacked for git - does
that make sense?

If there is none, I'm of course going to write one right now. I was
thinking about *HTML output (so it could be used over Internet with
standard protocol and tools), but the language is missing graphical
operations, right?
-- 
Krzysztof Halasa
