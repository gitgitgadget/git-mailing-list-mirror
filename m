From: horry <qch1695@motorola.com>
Subject: Problems during upgrade git from 1.5.3.2 to latest
Date: Sun, 26 Oct 2008 19:29:31 -0700 (PDT)
Message-ID: <20180862.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 03:33:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuHuo-0000aq-Pj
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 03:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbYJ0C3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 22:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbYJ0C3c
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 22:29:32 -0400
Received: from kuber.nabble.com ([216.139.236.158]:59716 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbYJ0C3b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 22:29:31 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1KuHrH-0001RW-4b
	for git@vger.kernel.org; Sun, 26 Oct 2008 19:29:31 -0700
X-Nabble-From: qch1695@motorola.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99198>


Hello ,
   My previous git version is 1.5.3.2 and i perform the suggested commands : 
git clone http://www.kernel.org/pub/scm/git/git.git  and it goes well , end
up with :

....................................................................
got d00da833cbeec16da9415e0ac11269594279545a
Checking 1480 files out...
 100% (1480/1480) done

Then i checked git version , it still shows previous version without any
change .

XXXXXXX:/apps/mds_lrt/git/git> git version
git version 1.5.3.2

Is there additional command which i should perform after clone ?

thanks,
Horry
-- 
View this message in context: http://www.nabble.com/Problems-during-upgrade-git-from-1.5.3.2-to-latest-tp20180862p20180862.html
Sent from the git mailing list archive at Nabble.com.
