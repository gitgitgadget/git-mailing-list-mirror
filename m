From: Jan Engelhardt <jengelh@inai.de>
Subject: release-notes could be clearer on git-fetch changes
Date: Wed, 19 Feb 2014 19:53:32 +0100 (CET)
Message-ID: <alpine.LSU.2.11.1402191952070.31131@nerf08.vanv.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 19 19:59:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGCMr-0002tl-2m
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 19:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664AbaBSS7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Feb 2014 13:59:33 -0500
Received: from ares08.inai.de ([46.4.84.70]:56361 "EHLO ares08.inai.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754402AbaBSS7c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Feb 2014 13:59:32 -0500
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Feb 2014 13:59:32 EST
Received: by ares08.inai.de (Postfix, from userid 25121)
	id 1359A10677D33; Wed, 19 Feb 2014 19:53:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by ares08.inai.de (Postfix) with ESMTP id 0EF82189D469C
	for <git@vger.kernel.org>; Wed, 19 Feb 2014 19:53:32 +0100 (CET)
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242397>

Greetings.


The release notes for 1.9.0 read:

> * The "--tags" option to "git fetch" no longer tells the command to
>   fetch _only_ the tags. It instead fetches tags _in addition to_
>   what are fetched by the same command line without the option.

I think the release notes should also say -- like it was done
extensively for git add -- how to get back the old
behavior (perhaps through now-different commands).


thanks,
Jan
