From: "Chris.Cheney" <chris.cheney.nospam@tesco.net>
Subject: qgit question: tagged commits not on a branch
Date: Thu, 26 Nov 2009 21:54:44 +0000 (UTC)
Message-ID: <Xns9CCFDEF02D061ChrisCheneytesconet@80.91.229.13>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 23:00:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDmNs-0005op-KG
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 23:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbZKZWAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 17:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753039AbZKZWAD
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 17:00:03 -0500
Received: from lo.gmane.org ([80.91.229.12]:36471 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892AbZKZWAC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 17:00:02 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NDmNh-0005lw-Dd
	for git@vger.kernel.org; Thu, 26 Nov 2009 23:00:05 +0100
Received: from 86.9.238.195 ([86.9.238.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 23:00:05 +0100
Received: from chris.cheney.nospam by 86.9.238.195 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 23:00:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 86.9.238.195
User-Agent: Xnews/5.04.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133840>

My commit graph has a number of forks (I can't use the word "branches" 
here) that are referenced only by a tag. Whereas gitk --all displays this 
graph including those forks, qgit does not display those forks - I don't 
see a way to make it do so, other than by adding branches to those tagged 
commits. 

Have I overlooked something?

TIA

Chris
