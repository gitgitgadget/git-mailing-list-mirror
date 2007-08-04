From: Ismail =?iso-8859-1?q?D=F6nmez?= <ismail@pardus.org.tr>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sat, 4 Aug 2007 03:41:36 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200708040341.36147.ismail@pardus.org.tr>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 02:41:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH7hg-0007n8-M7
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 02:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756287AbXHDAlI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 20:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753762AbXHDAlH
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 20:41:07 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:59523 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753819AbXHDAlG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 20:41:06 -0400
Received: from ninjamobile.local (unknown [85.96.18.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 0BB8860B2BD3;
	Sat,  4 Aug 2007 03:41:03 +0300 (EEST)
User-Agent: KMail/1.9.7
In-Reply-To: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54781>

On Saturday 04 August 2007 03:28:26 you wrote:
> I tagged 1.5.3-rc4 and it will soon be mirrored out.  This is
> the last rc before the real thing, which I am hoping to happen
> by mid August.  Until then, I won't look at anything but
> regression fixes and documentation updates.  Please test this
> one well.

Can't build manpages, same error as 
http://lists-archives.org/git/625107-having-problems-with-building-the-manpages.html :

xmlto -m callouts.xsl man git-add.xml
runtime error: file 
file:///usr/share/sgml/docbook/xsl-stylesheets-1.73.0/manpages/other.xsl line 
129 element call-template
The called template 'read-character-map' was not found.

Regards,
ismail

-- 
Perfect is the enemy of good
