From: Markus Elfring <Markus.Elfring@web.de>
Subject: Addition of "xmlto" to install documentation
Date: Sat, 13 Oct 2007 22:42:18 +0200
Message-ID: <47112DAA.5080701@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 13 22:42:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ignof-000516-JK
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 22:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756967AbXJMUmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 16:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756939AbXJMUmY
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 16:42:24 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:32986 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888AbXJMUmX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 16:42:23 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 7F41AA3794C7
	for <git@vger.kernel.org>; Sat, 13 Oct 2007 22:42:22 +0200 (CEST)
Received: from [80.140.112.115] (helo=[192.168.2.2])
	by smtp05.web.de with asmtp (WEB.DE 4.108 #197)
	id 1IgnoU-0004xl-00
	for git@vger.kernel.org; Sat, 13 Oct 2007 22:42:22 +0200
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1/vAgX41am4QToSmBGBREUoLnNJ8Xg6SR3Z47/J
	DAB0369ZJCq4v7vIouJOmvj5HGxKFyGvYauv/S4q6S4ZCQvuPm
	pv7lpSa8cJ9UFcE5QhaA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60777>

Hello,

I have cloned the current Git release to my computer. I resolved all
dependencies that were mentioned in the file "INSTALL". But when I've
tried "make install install-doc" I got the message that "xmlto" was not
found on my openSUSE 10.3 system. (I have installed it now.)
Would you like to add this tool to the system requirements in the
documentation?

Regards,
Markus
