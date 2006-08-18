From: Wolfgang Denk <wd@denx.de>
Subject: (unknown)
Date: Fri, 18 Aug 2006 12:35:11 +0200
Message-ID: <20060818103511.4C278353A32@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Aug 18 12:35:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE1hA-00034q-B9
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 12:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWHRKfP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 06:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWHRKfP
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 06:35:15 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:8679 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S1751351AbWHRKfN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 06:35:13 -0400
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id DB00C9842C
	for <git@vger.kernel.org>; Fri, 18 Aug 2006 12:35:11 +0200 (CEST)
X-Auth-Info: XuJ6IwuQtrkqqIp9ea8Hf8Uv0cviOBHAFKqt88I5om4=
Received: from mail.denx.de (p5496628C.dip.t-dialin.net [84.150.98.140])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id C295492633
	for <git@vger.kernel.org>; Fri, 18 Aug 2006 12:35:11 +0200 (CEST)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id 5B08B6D004A
	for <git@vger.kernel.org>; Fri, 18 Aug 2006 12:35:11 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 4C278353A32
	for <git@vger.kernel.org>; Fri, 18 Aug 2006 12:35:11 +0200 (MEST)
To: git@vger.kernel.org
Subject: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25645>

Hi,

"gitk" procudes output like this:

	Author: Stefan Roese <sr@denx.de>  2006-01-26 13:51:42
	Committer: Stefan Roese <sr@denx.de>  2006-01-26 13:51:42
	Parent: f565c2d4c8b945b5bfbafb8dda50b8784167b4e3 (Merge with /home/git/linux-2.6)
	Child:  d216d89489cce4021a75dea19ef1b19ad93958ec (Git rid of debug output.) Branches: origin, master
	Follows: DENX-v2.6.15
	Precedes: DENX-2006-02-01-2215

Is there a CLI tool or a hidden option to "git log"  or  "cg-log"  or
some  other  clever command to get similar "Follows:" and "Precedes:"
tag information?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The IQ of the group is the lowest IQ of a member of the group divided
by the number of people in the group.
