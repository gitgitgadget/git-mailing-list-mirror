From: Rene Herman <rene.herman@keyaccess.nl>
Subject: "git pull . <branch>" versus "git merge <branch>"
Date: Wed, 11 Jun 2008 02:51:00 +0200
Message-ID: <484F2174.9020508@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 02:52:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6EZQ-0004LZ-5m
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 02:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407AbYFKAu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 20:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754485AbYFKAu4
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 20:50:56 -0400
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:45367 "EHLO
	smtpq2.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565AbYFKAuz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 20:50:55 -0400
Received: from [213.51.130.189] (port=60654 helo=smtp2.groni1.gr.home.nl)
	by smtpq2.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1K6EYB-0007Ba-0f
	for git@vger.kernel.org; Wed, 11 Jun 2008 02:50:55 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:48134 helo=[192.168.0.3])
	by smtp2.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1K6EYA-0001N0-Tf
	for git@vger.kernel.org; Wed, 11 Jun 2008 02:50:55 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84567>

Good day.

The manpages seem to be making somewhat of a point of mentioning "git 
pull . <branch>" as the way to merge a local branch into the current one 
but a simple "git merge <branch>" seems to work well. Is there a difference?

Rene.
