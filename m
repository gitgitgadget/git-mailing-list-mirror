From: Emanuele Zattin <emanuelez@gmail.com>
Subject: Re: Git performance results on a large repository
Date: Tue, 7 Feb 2012 08:58:02 +0000 (UTC)
Message-ID: <loom.20120207T095317-899@post.gmane.org>
References: <CB5074CF.3AD7A%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 10:00:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuguP-00034t-PI
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 10:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756716Ab2BGJAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 04:00:11 -0500
Received: from plane.gmane.org ([80.91.229.3]:56064 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756665Ab2BGJAK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 04:00:10 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RuguB-0002zm-SI
	for git@vger.kernel.org; Tue, 07 Feb 2012 10:00:04 +0100
Received: from espcolo-webproxy01.nokia.com ([192.100.120.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 10:00:03 +0100
Received: from emanuelez by espcolo-webproxy01.nokia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 10:00:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 192.100.120.41 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.77 Safari/535.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190156>

Joshua Redstone <joshua.redstone <at> fb.com> writes:

> 
> Hi Git folks,
> 

Hello everybody! 

I would just like to contribute a small set of blog posts 
about this issue and a possible solution. 
Sorry for the tone in which I wrote those posts, 
but I think there are some valid points in there.

https://gist.github.com/1758346

BR,

Emanuele Zattin
