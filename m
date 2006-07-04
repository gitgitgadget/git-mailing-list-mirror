From: llandre <r&d2@dave-tech.it>
Subject: Can't import Xenomai svn repo
Date: Tue, 04 Jul 2006 10:48:16 +0200
Message-ID: <44AA2B50.4060403@dave-tech.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jul 04 10:46:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxgY3-0005OL-0s
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 10:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWGDIqU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 04:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWGDIqU
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 04:46:20 -0400
Received: from host46-203-static.38-85-b.business.telecomitalia.it ([85.38.203.46]:58377
	"HELO dave-tech.it") by vger.kernel.org with SMTP id S932144AbWGDIqT
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 04:46:19 -0400
Received: (qmail 30090 invoked by uid 0); 4 Jul 2006 08:46:16 -0000
Received: from unknown (HELO ?192.168.0.6?) (192.168.2.253)
  by 192.168.2.1 with SMTP; 4 Jul 2006 08:46:16 -0000
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23273>

Hi all,

I tried to import Xenomai svn repo but the script failed:

git-svnimport -v -C xenomai.git http://svn.gna.org/xenomai/trunk
RA layer request failed: PROPFIND request failed on '/xenomai/trunk': 
PROPFIND of '/xenomai/trunk': 405 Method Not Allowed 
(http://svn.gna.org) at /usr/bin/git-svnimport line 135

Git version is 1.4.0.
Anybody can help me?


TIA,
llandre

DAVE Electronics System House - R&D Department
web:   http://www.dave-tech.it
email: r&d2@dave-tech.it
