From: Chris Dumoulin <dumoulin@oanda.com>
Subject: EGIT compare editor
Date: Tue, 14 Oct 2008 10:18:27 -0400
Message-ID: <48F4AA33.40605@oanda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 14 16:42:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kpl4w-0004PP-8P
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 16:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbYJNOji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 10:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbYJNOji
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 10:39:38 -0400
Received: from mail.oanda.com ([216.220.44.220]:35234 "EHLO mail.oanda.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113AbYJNOjh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 10:39:37 -0400
X-Greylist: delayed 1268 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Oct 2008 10:39:37 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.oanda.com (Postfix) with ESMTP id A65C4EC020
	for <git@vger.kernel.org>; Tue, 14 Oct 2008 10:18:28 -0400 (EDT)
Received: from mail.oanda.com ([127.0.0.1])
	by localhost (mail.q9.oanda.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 13792-08 for <git@vger.kernel.org>;
	Tue, 14 Oct 2008 10:18:28 -0400 (EDT)
Received: from gateway.oanda.com (unknown [216.235.10.210])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.oanda.com (Postfix) with ESMTPS id 8EBAEEC016
	for <git@vger.kernel.org>; Tue, 14 Oct 2008 10:18:28 -0400 (EDT)
Received: from [10.0.10.50] (unknown [10.0.10.50])
	by eddie.dev.oanda.com (Postfix) with ESMTP id 276716408A
	for <git@vger.kernel.org>; Tue, 14 Oct 2008 10:18:28 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98187>

I seem to have successfully installed EGIT in Eclipse 3.4.1, but I can't 
figure out how to bring up the compare editor to view diffs.

The EGIT plugin seems to be loaded and working for my project; I see 
"[Git @ master]" beside the project name, and ">" beside changed files. 
Also, the quickdiff seems to be working; I see a different colour in the 
left margin beside changes within the file. The "Team" context menu 
seems to be populated properly: "Commit", "Update Index (Refresh)", 
"Show in Resource History", "Assume unchanged", "Track (Add)", "Untrack 
(Remove)", "Apply Patch...", and below the separator "Show Local History".

I expect that after right-clicking on a changed file, I would have some 
option under "Compare With" or "Team" that would allow me to diff the 
current file against the HEAD or some other revision using the compare 
editor, but I can't seem to find any way to do this. How do I bring up 
the compare editor to view diffs?

Thanks,
Chris
