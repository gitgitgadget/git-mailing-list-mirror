From: "Steven" <redalert.commander@gmail.com>
Subject: git revert ignore whitespace
Date: Fri, 10 Sep 2010 09:57:52 +0200 (CEST)
Message-ID: <14756.91.183.48.98.1284105472.squirrel@stevenleeuw.kwik.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 10 10:08:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtyfE-0004gH-KA
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 10:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699Ab0IJIIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 04:08:46 -0400
Received: from mailrelay008.isp.belgacom.be ([195.238.6.174]:27270 "EHLO
	mailrelay008.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754148Ab0IJIIo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 04:08:44 -0400
X-Belgacom-Dynamic: yes
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AkodACGDiUxbsdtz/2dsb2JhbACELo9UjT5yrFyIUS6IH4U9BA
Received: from 115.219-177-91.adsl-dyn.isp.belgacom.be (HELO debian.LAN) ([91.177.219.115])
  by relay.skynet.be with ESMTP; 10 Sep 2010 10:08:37 +0200
Received: from localhost ([127.0.0.1] helo=stevenleeuw.kwik.to)
	by debian.LAN with esmtp (Exim 4.63)
	(envelope-from <redalert.commander@gmail.com>)
	id 1OtyUa-0001IU-1h
	for git@vger.kernel.org; Fri, 10 Sep 2010 09:57:52 +0200
Received: from 91.183.48.98
        (SquirrelMail authenticated user steven)
        by stevenleeuw.kwik.to with HTTP;
        Fri, 10 Sep 2010 09:57:52 +0200 (CEST)
User-Agent: SquirrelMail/1.4.9a
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155921>

Hi,

Please CC me, as I'm not subscribed to the list.

I want to revert a specific commit using 'git revert',
however in the meantime there were some whitespace changes.
Is it still possible to do this? The manual doesn't mention a -w or
--ignore-whitespace option for git revert.

I'm using git 1.7.0.2 (msysgit)

Kind regards,
Steven


-- 
Rarely do people communicate; they just take turns talking.
