From: =?UTF-8?Q?Goran_Meki=C4=87?= <meka@ns-linux.org>
Subject: Git push from bare repo
Date: Fri, 28 May 2010 08:57:13 +0200
Message-ID: <3197051701046e645c8ff2ae7dca872a@ns-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 28 09:06:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHte1-0008Ti-2B
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 09:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576Ab0E1HGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 May 2010 03:06:08 -0400
Received: from barbossa.ns-linux.org ([85.131.239.116]:35941 "EHLO
	barbossa.ns-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128Ab0E1HGG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 03:06:06 -0400
X-Greylist: delayed 529 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 May 2010 03:06:05 EDT
Received: by barbossa.ns-linux.org (Postfix, from userid 1011)
	id 280027D9FF7; Fri, 28 May 2010 08:57:13 +0200 (CEST)
X-Sender: meka@ns-linux.org
User-Agent: RoundCube Webmail/0.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147917>


    I have to push from first server to second (yeah, the names are great

:o) when ever someone pushes to first server. It should be done using

post-receive hook, for example. The problem is that I can not specify ssh

key, and even if I could, anything but 600 perm for the key is rejected.

What would be the best way to acomplish this? Thanx!



-- 

FreeB(eer)S(ex)D(rugs) are the real daemons
