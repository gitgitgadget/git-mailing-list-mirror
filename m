From: Steve <shrotty@gmx.ch>
Subject: Re: git-push on packed refs via HTTP
Date: Fri, 20 Mar 2009 10:25:27 +0000 (UTC)
Message-ID: <loom.20090320T102357-212@post.gmane.org>
References: <loom.20090320T094550-421@post.gmane.org> <200903201103.59907.thomas.jarosch@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:29:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkby9-0000on-0z
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 11:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761644AbZCTKZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 06:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759664AbZCTKZq
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 06:25:46 -0400
Received: from main.gmane.org ([80.91.229.2]:47954 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762092AbZCTKZo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 06:25:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lkbv3-0007E9-I0
	for git@vger.kernel.org; Fri, 20 Mar 2009 10:25:41 +0000
Received: from 172.120.221.87.dynamic.jazztel.es ([87.221.120.172])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Mar 2009 10:25:41 +0000
Received: from shrotty by 172.120.221.87.dynamic.jazztel.es with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Mar 2009 10:25:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.221.120.172 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.7) Gecko/2009021906 Firefox/3.0.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113934>

Thomas Jarosch <thomas.jarosch <at> intra2net.com> writes:
> Check the permissions of the files on the server, I once accidentally executed
> git commands as root user and the HTTP server was later
> unable to read/write the repository properly.

The perms are okay, yet the error message remains.
