From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Problem running git-gui
Date: Tue, 17 Jul 2007 12:48:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707171244080.13359@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 17 13:48:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAlXY-0003US-Fk
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 13:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358AbXGQLsZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 07:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756363AbXGQLsZ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 07:48:25 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:45784 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754992AbXGQLsZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2007 07:48:25 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id A240AC610C
	for <git@vger.kernel.org>; Tue, 17 Jul 2007 12:48:23 +0100 (BST)
Received: (qmail 25610 invoked by uid 103); 17 Jul 2007 12:48:22 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3630. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.031119 secs); 17 Jul 2007 11:48:22 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 17 Jul 2007 12:48:22 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52755>

I have a machine on which git was installed from a tarball created by 
running git-archive on master (so a 1.5.3ish version).

When I try running git-gui I get an error message:

'Error in startup script: expected version number but got "1.5.3.GIT"'

followed by what I assume is a code snippet where it failed (I wouldn't 
know tcl if it hit me with a large brick).

Is this expected? driver error? or maybe a bug?

-- 
Julian

  ---
mixed emotions:
 	Watching a bus-load of lawyers plunge off a cliff.
 	With five empty seats.
