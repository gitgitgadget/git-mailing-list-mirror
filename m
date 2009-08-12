From: Michael Gaffney <mr.gaffo@gmail.com>
Subject: [ANNOUNCE] Scumd
Date: Wed, 12 Aug 2009 13:28:41 -0500
Message-ID: <4A8309D9.8070008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 12 20:29:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbIZH-0008Sb-JW
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 20:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756AbZHLS2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 14:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754477AbZHLS2m
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 14:28:42 -0400
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:44030 "EHLO
	friskymail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753450AbZHLS2m (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Aug 2009 14:28:42 -0400
Received: from [192.168.11.102] (nat.asynchrony.com [66.236.120.131])
	by friskymail-a4.g.dreamhost.com (Postfix) with ESMTP id 1582B121CCD
	for <git@vger.kernel.org>; Wed, 12 Aug 2009 11:28:42 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125723>

Greetings,
    This is an initial announcement of SCuMD, a pure java git sshd 
daemon. The source is at git://github.com/gaffo/scumd. The impetus 
behind SCuMD is to provide a highly configurable git daemon which can 
authenticate and authorize off of flat files, databases, LDAP, web 
services, or any other resource you can think of. SCuMD's other goal is 
to remove the need to serve off of normal sshd which some find to be a 
security risk on the open Internet. Currently SCuMD supports LDAP as the 
authentication module but coding other modules is quite simple.
    I would welcome any feedback including a better name. SCuMD stands 
for SCM Daemon.

Thanks,
    Mike Gaffney
