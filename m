From: david@lang.hm
Subject: how to track multiple upstreams in one repository
Date: Sun, 18 Jan 2009 18:58:06 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0901181855400.20741@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 02:56:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOjN7-0003rK-09
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 02:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030AbZASBys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 20:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755969AbZASBys
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 20:54:48 -0500
Received: from mail.lang.hm ([64.81.33.126]:34480 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755757AbZASByr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 20:54:47 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n0J1sk9i015645
	for <git@vger.kernel.org>; Sun, 18 Jan 2009 17:54:46 -0800
X-X-Sender: dlang@asgard.lang.hm
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106299>

for linux I want to track both the linus tree and the -stable tree. 
Ideally I want to be able to do a checkout of tags from either tree from 
the same directory (along with diffs between items in both trees, etc)

I have found documentation on how to clone from each of them, but I 
haven't found any simple documentation on how to work with both of them.

David Lang
