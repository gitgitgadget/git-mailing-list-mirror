From: astubbs <antony.stubbs@gmail.com>
Subject: git gui rescane_stage2 error on windows
Date: Tue, 30 Sep 2008 10:41:13 -0700 (PDT)
Message-ID: <1222796473795-1129562.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 30 19:42:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkjF4-00084j-Up
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 19:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbYI3RlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 13:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753123AbYI3RlP
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 13:41:15 -0400
Received: from kuber.nabble.com ([216.139.236.158]:48355 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069AbYI3RlO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 13:41:14 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1KkjDl-0001hd-Ul
	for git@vger.kernel.org; Tue, 30 Sep 2008 10:41:13 -0700
X-Nabble-From: antony.stubbs@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97135>


Fresh install and fresh repository on Vista.Getting this error when launching
git gui:child process exited abnormallychild process exited abnormally   
while executing"close $fd"    (procedure "rescan_stage2" line 7)    invoked
from within"rescan_stage2 file1192de8 ui_ready"Any ideas?git version 1.6.0.2
-- 
View this message in context: http://n2.nabble.com/git-gui-rescane_stage2-error-on-windows-tp1129562p1129562.html
Sent from the git mailing list archive at Nabble.com.
