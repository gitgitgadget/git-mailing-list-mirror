From: Henk <henk_westhuis@hotmail.com>
Subject: Quick command to count commits
Date: Tue, 6 Jan 2009 10:51:36 -0800 (PST)
Message-ID: <1231267896595-2118851.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 19:53:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKH2z-0005Wx-VW
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 19:53:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbZAFSvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 13:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbZAFSvi
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 13:51:38 -0500
Received: from kuber.nabble.com ([216.139.236.158]:49967 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbZAFSvh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 13:51:37 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LKH1c-0008WF-Jj
	for git@vger.kernel.org; Tue, 06 Jan 2009 10:51:36 -0800
X-Nabble-From: henk_westhuis@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104705>


Hi,

For GitExtensions (windows git ui) I need a command to count all commits. I
now use this command:
git.cmd rev-list --all --abbrev-commit | wc -l

This works perfect but its very slow in big repositories. Is there a faster
way to count the commits?

Henk
-- 
View this message in context: http://n2.nabble.com/Quick-command-to-count-commits-tp2118851p2118851.html
Sent from the git mailing list archive at Nabble.com.
