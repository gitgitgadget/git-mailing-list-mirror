From: Christoph Duelli <duelli@melosgmbh.de>
Subject: Is a given file known to git?
Date: Tue, 11 Mar 2008 08:15:09 +0100
Message-ID: <47D6317D.7030700@melosgmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 08:18:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYyl5-00027n-EJ
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 08:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbYCKHSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 03:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbYCKHSG
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 03:18:06 -0400
Received: from mo-p07-fb.rzone.de ([81.169.146.191]:59483 "EHLO
	mo-p07-fb.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbYCKHSF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 03:18:05 -0400
Received: from mo-p07-ob.rzone.de (mrclete-mo-p07-ob.mail [192.168.63.176])
	by gibbsson-fb-04.store (RZmta 16.9) with ESMTP id R066e9k2ALj31i
	for <git@vger.kernel.org>; Tue, 11 Mar 2008 08:18:03 +0100 (MET)
	(envelope-from: <duelli@melosgmbh.de>)
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: hvKqOO6Ph79JHUJJIwMxXgzUdNi97hMDGc5n+ojdbo9B56/YXBytmKws+HDNQA471tmH
Received: from mail.melosgmbh.de
	(p5B07A7E6.dip0.t-ipconnect.de [91.7.167.230])
	by post.webmailer.de (mrclete mo29) (RZmta 16.8)
	with ESMTP id u047d9k2B6MQGq for <git@vger.kernel.org>;
	Tue, 11 Mar 2008 08:16:46 +0100 (MET)
	(envelope-from: <duelli@melosgmbh.de>)
X-Spam-Status: No, hits=0.0 required=4.0
	tests=AWL: 0.035,BAYES_00: -1.665,TOTAL_SCORE: -1.630
X-Spam-Level: 
Received: from [172.27.1.229] ([172.27.1.229])
	(authenticated user duelli@melosgmbh.de)
	by mail.melosgmbh.de (Kerio MailServer 6.4.1 patch 1)
	for git@vger.kernel.org;
	Tue, 11 Mar 2008 08:16:45 +0100
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76803>

Given a repository and a path p to a file in it:
Is it possible (how?) to detect (in a bash script) if the file pointed 
to by p is "known" to git?
Something along the line:
if `git knows p?
then
...
fi

Thanks and keep up the good work!
-- 
Christoph Duelli
