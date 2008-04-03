From: Christoph Duelli <duelli@melosgmbh.de>
Subject: File info from SHA ID
Date: Thu, 03 Apr 2008 18:58:45 +0200
Message-ID: <47F50CC5.20502@melosgmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 19:02:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhSon-00069v-Pk
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 19:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756281AbYDCRA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 13:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756287AbYDCRA3
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 13:00:29 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:41149 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbYDCRA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 13:00:28 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: hvKqOO6Ph79JHUJJIwMxXgzUdNi97hMDGc5n+ojdbo9B56/YXBytmKws+HDM9bklv94=
Received: from mail.melosgmbh.de (p5B07AA29.dip0.t-ipconnect.de [91.7.170.41])
	by post.webmailer.de (fruni mo38) (RZmta 16.18)
	with ESMTP id j013d3k33EUFm5 for <git@vger.kernel.org>;
	Thu, 3 Apr 2008 19:00:24 +0200 (MEST)
	(envelope-from: <duelli@melosgmbh.de>)
X-Spam-Status: No, hits=0.0 required=4.0
	tests=AWL: 0.036,BAYES_00: -1.665,TOTAL_SCORE: -1.629
X-Spam-Level: 
Received: from [172.27.1.229] ([172.27.1.229])
	(authenticated user duelli@melosgmbh.de)
	by mail.melosgmbh.de (Kerio MailServer 6.4.1 patch 1)
	for git@vger.kernel.org;
	Thu, 3 Apr 2008 19:00:24 +0200
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78762>

Given (only) a SHA ID (say from a file's $ID$ expansion), is it possible 
to determine the file's name, date of commit etc?
I'd be most interested in the file path.

Best regards, keep up the good work
-- 
Christoph Duelli
