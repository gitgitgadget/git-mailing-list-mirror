From: david@lang.hm
Subject: git documentation
Date: Mon, 5 Jan 2009 17:46:56 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0901051745280.28514@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 01:45:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK04m-0001HW-3y
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 01:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbZAFAoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 19:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbZAFAoZ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 19:44:25 -0500
Received: from mail.lang.hm ([64.81.33.126]:56129 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750845AbZAFAoY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 19:44:24 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n060iN0x012104
	for <git@vger.kernel.org>; Mon, 5 Jan 2009 16:44:23 -0800
X-X-Sender: dlang@asgard.lang.hm
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104608>

on lwn there is a comment (under the GNOME survey topic)
http://lwn.net/Articles/313435/

The Shlomi Fish "Better SCM" site for example is very clear that Git won't 
do a merge across a rename. It even has a citation for this claim. But as 
a Git user who has actually done a merge across a rename I know it works 
just fine, and anyone familiar with Git's internals will guess immediately 
why. Yet probably there is no line of documentation on the Git site or 
elsewhere that I can quote to justify adding a "Yes" to the comparison.


sounds like a missing piece of documentation that someone should be able 
to fill in fairly easily.

David Lang
