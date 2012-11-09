From: Bogolisk <bogolisk@gmail.com>
Subject: Re: Revert option for git add --patch
Date: Fri, 9 Nov 2012 14:09:06 +0000 (UTC)
Message-ID: <loom.20121109T150732-186@post.gmane.org>
References: <EE89F0A1-1C07-4597-B654-035F657AD09F@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 15:09:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWpH5-0008DY-8h
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 15:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538Ab2KIOJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 09:09:22 -0500
Received: from plane.gmane.org ([80.91.229.3]:43547 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753522Ab2KIOJV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 09:09:21 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TWpGw-00089A-Pn
	for git@vger.kernel.org; Fri, 09 Nov 2012 15:09:29 +0100
Received: from 173-195-49.74.tel-ott.com ([173-195-49.74.tel-ott.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Nov 2012 15:09:26 +0100
Received: from bogolisk by 173-195-49.74.tel-ott.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Nov 2012 15:09:26 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 173.195.49.74 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209220>

Jonathon Mah <jmah <at> me.com> writes:

> 
> Nathan,
> 
> I find myself performing similar actions to you: using git add -p to stage 
hunks, sometimes editing the
> staged patch; and keeping mental notes of things I wanted to revert, sometimes 
changing them in the editor
> in another window, and sometimes reverting them after the add session with git 
checkout -p).

Other front-ends like Egg and Magit has been providing the ability to move hunks 
back and forth, for a long time.
