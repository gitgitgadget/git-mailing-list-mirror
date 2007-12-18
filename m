From: Christoph Duelli <duelli@melosgmbh.de>
Subject: preventing a push
Date: Tue, 18 Dec 2007 13:32:24 +0100
Message-ID: <4767BDD8.9080404@melosgmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 13:35:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4bfG-0005MV-On
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 13:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769AbXLRMev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 07:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753426AbXLRMev
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 07:34:51 -0500
Received: from cg-p07-fb.rzone.de ([81.169.146.215]:33945 "EHLO
	cg-p07-fb.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbXLRMeu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 07:34:50 -0500
Received: from mo-p07-ob.rzone.de (fruni-mo-p07-ob.mail [192.168.63.183])
	by gibbsson-fb-03.store (RZmta 14.0) with ESMTP id i00207jBIBws3q
	for <git@vger.kernel.org>; Tue, 18 Dec 2007 13:34:48 +0100 (MET)
	(envelope-from: <duelli@melosgmbh.de>)
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: hvKqOO6Ph79JHUJJIwMxXgzUdNi97hMDGc5n+ojdbo9B56/YXBytmKws+HDNT6n5rcY=
Received: from mail.melosgmbh.de (p5B07A85D.dip0.t-ipconnect.de [91.7.168.93])
	by post.webmailer.de (fruni mo23) (RZmta 14.6)
	with ESMTP id I0365djBIBwAEq for <git@vger.kernel.org>;
	Tue, 18 Dec 2007 13:33:46 +0100 (MET)
	(envelope-from: <duelli@melosgmbh.de>)
X-Spam-Status: No, hits=0.0 required=4.0
	tests=AWL: 0.032,BAYES_00: -1.665,TOTAL_SCORE: -1.633
X-Spam-Level: 
Received: from [172.27.1.229] ([172.27.1.229])
	(authenticated user duelli@melosgmbh.de)
	by mail.melosgmbh.de (Kerio MailServer 6.4.1 patch 1)
	for git@vger.kernel.org;
	Tue, 18 Dec 2007 13:33:44 +0100
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68739>

Is there a (recommended?) way to prevent accidental pushing (or pulling) 
from one repository into another (like the level command from bk days)?

Best regards
Christoph
