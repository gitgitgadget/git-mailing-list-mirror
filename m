From: mastermindxs <mastermindxs@gmail.com>
Subject: What is the mechanism of a git checkout?
Date: Thu, 28 May 2009 08:21:59 -0700 (PDT)
Message-ID: <23764024.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 17:23:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9hRY-0007Ay-1L
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 17:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762547AbZE1PWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 11:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758764AbZE1PV7
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 11:21:59 -0400
Received: from kuber.nabble.com ([216.139.236.158]:55978 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756944AbZE1PV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 11:21:58 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1M9hQd-0002d0-NN
	for git@vger.kernel.org; Thu, 28 May 2009 08:21:59 -0700
X-Nabble-From: mastermindxs@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120193>


does a git checkout pull the contents of a branch? how does it physically
separate files in your working directory from other branches? 

The speed of which it works leads me to the logical conclusion that the
files in the working directory are all there for all branches and git simply
only shows you the files of the active branch.

Can anyone shed more light on the underlying mechanisms of git checkout
maybe even branch and merge as well?

thanks
-diego
www.greyrobot.com
-- 
View this message in context: http://www.nabble.com/What-is-the-mechanism-of-a-git-checkout--tp23764024p23764024.html
Sent from the git mailing list archive at Nabble.com.
