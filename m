From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sat, 4 Aug 2007 15:11:04 +0200
Message-ID: <200708041511.05191.robin.rosenberg.lists@dewire.com>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 15:09:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHJOI-0008OI-AI
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 15:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761383AbXHDNJz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 09:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761410AbXHDNJz
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 09:09:55 -0400
Received: from [83.140.172.130] ([83.140.172.130]:2548 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757614AbXHDNJz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 09:09:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 857EF80264F;
	Sat,  4 Aug 2007 15:02:28 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07731-03; Sat,  4 Aug 2007 15:02:28 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 44EE780019B;
	Sat,  4 Aug 2007 15:02:28 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54843>


Commit 281a53bb79786a6d7e54f9715cc8ad46fc2bdb0e introduced some stains on my man pages. They
look like:

           .ft C
                     A---B---C topic
                    /
               D---E---F---G master
           .ft

Versions (Mandriva 20071):

	asciidoc-8.1.0-1mdv2007.1
	docbook-style-xsl-1.72.0-1mdv2007.1


You should also mention that the man pages goes to a new location when installed.

-- robin
