From: Roland Lutz <rlutz@hedmen.org>
Subject: Arrow keys broken in gitk
Date: Sat, 28 Mar 2015 16:52:09 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1503281637160.7351@nimbus>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 28 17:35:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ybthr-0002Ss-SX
	for gcvg-git-2@plane.gmane.org; Sat, 28 Mar 2015 17:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbbC1QfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2015 12:35:18 -0400
Received: from abakus.grinsen-ohne-katze.de ([178.77.97.95]:60016 "EHLO
	abakus.grinsen-ohne-katze.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751083AbbC1QfQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Mar 2015 12:35:16 -0400
X-Greylist: delayed 2427 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Mar 2015 12:35:16 EDT
Received: from localhost ([::1])
	by abakus.grinsen-ohne-katze.de with esmtp (Exim 4.80)
	(envelope-from <rlutz@hedmen.org>)
	id 1Ybt4Q-0003ZL-IY
	for git@vger.kernel.org; Sat, 28 Mar 2015 16:54:46 +0100
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266420>

Hi,

in gitk on Debian jessie (Git version 2.1.4), the left/right arrow keys 
don't work in the text input fields.  When I click into the SHA ID field 
or either search field and press the left or right arrow key, nothing 
happens.  I'd expect the text cursor to move one character forward or back.

Roland
