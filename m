From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Remote git-cat-file?
Date: Sun, 28 May 2006 14:00:21 +0200
Organization: At home
Message-ID: <e5c3c5$i47$1@sea.gmane.org>
References: <loom.20060528T002420-957@post.gmane.org> <Pine.LNX.4.64.0605271727110.5623@g5.osdl.org> <loom.20060528T124835-757@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun May 28 14:00:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkJwb-0005S9-7L
	for gcvg-git@gmane.org; Sun, 28 May 2006 14:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWE1MAY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 08:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWE1MAY
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 08:00:24 -0400
Received: from main.gmane.org ([80.91.229.2]:25292 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750741AbWE1MAY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 08:00:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FkJwK-0005PN-Vv
	for git@vger.kernel.org; Sun, 28 May 2006 14:00:13 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 May 2006 14:00:12 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 May 2006 14:00:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20880>

Elrond wrote:

> Linus Torvalds <torvalds <at> osdl.org> writes:
>> 
>> Just out of interest, why would you ever want to just look at a single 
>> object?
[...]
>
> The other possible use for remote git-cat-file:
> It might be useful in shallow repos to selectively load objects "on demand".
> (In fact, I screwed my repo by trying to make it shallow.)

It would be nice I think to be able to have remote alternatives, loading
(downloading and saving) objects "on demand" ("lazy alternatives"). Not necessary
only with "shallow repo"/"shallow clone".

-- 
Jakub Narebski
Warsaw, Poland
