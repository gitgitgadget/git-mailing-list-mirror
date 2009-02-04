From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: Support various HTTP authentication methods
Date: Wed, 4 Feb 2009 23:09:46 +0100 (CET)
Message-ID: <alpine.DEB.1.10.0902042307540.3383@yvahk2.pbagnpgbe.fr>
References: <1233556274-1354-1-git-send-email-gitster@pobox.com> <1233556274-1354-2-git-send-email-gitster@pobox.com> <1233556274-1354-3-git-send-email-gitster@pobox.com> <1233556274-1354-4-git-send-email-gitster@pobox.com>
 <20090204185109.GA31250@klangraum.plasmasturm.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1084551540-268651684-1233785372=:3383"
Cc: git@vger.kernel.org
To: Aristotle Pagaltzis <pagaltzis@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 04 23:15:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUq1Z-0005EQ-GG
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 23:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757015AbZBDWNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 17:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756291AbZBDWNe
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 17:13:34 -0500
Received: from kluster1.contactor.se ([91.191.140.11]:34756 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756828AbZBDWNd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 17:13:33 -0500
Received: from linux2.contactor.se (linux2.contactor.se [91.191.140.14])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id n14MDQIo022465;
	Wed, 4 Feb 2009 23:13:26 +0100
X-X-Sender: dast@linux2.contactor.se
In-Reply-To: <20090204185109.GA31250@klangraum.plasmasturm.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-fromdanielhimself: yes
Content-ID: <alpine.DEB.1.10.0902042309380.3383@yvahk2.pbagnpgbe.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108443>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1084551540-268651684-1233785372=:3383
Content-Type: TEXT/PLAIN; CHARSET=UTF-8; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.1.10.0902042309381.3383@yvahk2.pbagnpgbe.fr>

On Wed, 4 Feb 2009, Aristotle Pagaltzis wrote:

> Does that have to do with something being missing in the Digest support or 
> is that operator error? If the latter, what might be the culprit – how do I 
> diagnose it?

Can you use curl the command line tool with Digest successfully against some 
of those URLs?

What libcurl version are you using?

-- 

  / daniel.haxx.se
---1084551540-268651684-1233785372=:3383--
