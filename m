From: Wolfgang Denk <wd@denx.de>
Subject: Cannot build git RPM
Date: Tue, 09 Aug 2005 12:40:40 +0200
Message-ID: <20050809104040.B9C61352B36@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Aug 09 12:42:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2RY5-0002B6-E0
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 12:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbVHIKlE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 06:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbVHIKlE
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 06:41:04 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:22971 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932510AbVHIKlD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2005 06:41:03 -0400
Received: from fwd32.aul.t-online.de 
	by mailout02.sul.t-online.com with smtp 
	id 1E2RXW-00031S-00; Tue, 09 Aug 2005 12:40:58 +0200
Received: from denx.de (GQcBJiZOwe5MSCp31hsjbj1VGe9kD00kxJO93mCnuca7G8sMNqA+05@[84.150.75.60]) by fwd32.sul.t-online.de
	with esmtp id 1E2RXJ-0zukkK0; Tue, 9 Aug 2005 12:40:45 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP id 0C16F42BAA
	for <git@vger.kernel.org>; Tue,  9 Aug 2005 12:40:40 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id B9C61352B36
	for <git@vger.kernel.org>; Tue,  9 Aug 2005 12:40:40 +0200 (MEST)
To: git@vger.kernel.org
X-ID: GQcBJiZOwe5MSCp31hsjbj1VGe9kD00kxJO93mCnuca7G8sMNqA+05@t-dialin.net
X-TOI-MSGID: 04beee89-2e6f-4a11-a177-de0704c49c68
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

it is not possible to build RPMs from the current git code:

RPM build errors:
    Installed (but unpackaged) file(s) found:
   /usr/share/git-core/templates/description
   /usr/share/git-core/templates/hooks/post-update
   /usr/share/git-core/templates/hooks/update
   /usr/share/git-core/templates/info/exclude
make: *** [rpm] Error 1


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Computers are not intelligent.  They only think they are.
