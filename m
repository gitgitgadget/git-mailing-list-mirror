From: Peter van der Does <peter@ourvirtualhome.com>
Subject: git tag listing order
Date: Tue, 24 Nov 2009 10:56:09 -0500
Message-ID: <20091124105609.0980e796@montecarlo.grandprix.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 24 18:09:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCytl-00076S-0M
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 18:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933506AbZKXRJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 12:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933483AbZKXRJl
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 12:09:41 -0500
Received: from bellona.lunarservers.com ([74.50.21.190]:53734 "EHLO
	bellona.lunarservers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933457AbZKXRJl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 12:09:41 -0500
X-Greylist: delayed 4411 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Nov 2009 12:09:41 EST
Received: from c-69-248-103-68.hsd1.nj.comcast.net ([69.248.103.68] helo=monza.grandprix.int)
	by bellona.lunarservers.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <peter@ourvirtualhome.com>)
	id 1NCxkU-0003iA-KU
	for git@vger.kernel.org; Tue, 24 Nov 2009 07:56:14 -0800
Received: from montecarlo.grandprix.int (unknown [192.168.1.102])
	by monza.grandprix.int (Postfix) with ESMTPA id 895BC101FCD
	for <git@vger.kernel.org>; Tue, 24 Nov 2009 10:56:12 -0500 (EST)
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.18.3; i486-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bellona.lunarservers.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - ourvirtualhome.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133583>

I'm using git 1.6.5.3 on Ubuntu and was wondering if there is a way to
list tags in order of when they were added to the tree, instead of
alphabetical?


-- 
Peter van der Does

GPG key: E77E8E98
Twitter: @petervanderdoes
git Ubuntu Packages:
http://blog.avirtualhome.com/git-packages-for-ubuntu/
