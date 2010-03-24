From: "Neal Kreitzinger" <neal@rsss.com>
Subject: color (red) for error messages on all git commands
Date: Wed, 24 Mar 2010 17:44:09 -0500
Message-ID: <hoe4j3$2vg$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 24 23:44:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuZJA-0008Ds-0b
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 23:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336Ab0CXWoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 18:44:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:56359 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939Ab0CXWoH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 18:44:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NuZIx-00086j-CY
	for git@vger.kernel.org; Wed, 24 Mar 2010 23:44:03 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 23:44:03 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 23:44:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5843
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143134>

Problem Scenario:  programmer doesn't pay attention to messages as he 
becomes more familiar with git and as a result doesn't notice error messages 
until its too late.  Mistakes take longer to remediate because the original 
error message was not resolved at the time it occurred.

Desired Solution:  configure git to display all error messages in color, 
e.g. red, so that the programmer does not overlook error messages.

Does anyone know how to configure this in git?


v/r,
Neal 
