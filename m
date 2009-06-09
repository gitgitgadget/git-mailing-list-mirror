From: Nicolas Pitre <nico@cam.org>
Subject: Re: EasyGit Integration
Date: Tue, 09 Jun 2009 15:43:32 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906091535520.31536@xanadu.home>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 21:44:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME7Et-0000z5-JS
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 21:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbZFITn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 15:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbZFITn6
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 15:43:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35130 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbZFITn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 15:43:58 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KKZ00LEULGKAS00@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 09 Jun 2009 15:43:34 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121214>

On Tue, 9 Jun 2009, Scott Chacon wrote:

> Hey all,
> 
> I have been playing with the EasyGit project lately and I have been
> really impressed.  I looked back to the last announcement here and the
> conversation didn't really go anywhere, sadly.  I thought it might be
> nice to adopt or at least consider a number of the design decisions
> they made in modifying the defaults and commands available.  Perhaps
> as a 1.7 goal or something?  I like it because it addresses a lot of
> the issues that I hear from beginning users:
[...]
> Does this resonate with anyone else?  Does 1.7 seem like a good goal
> for amending some of these things?  Completely redefining 'revert'
> seems like the only backward incompatible change - everything else is
> just wrappers and whatnot, I think.

Completely agreed.

This is indeed refreshing to see some of the git UI warts being 
addressed by people who simply aren't too used to them like I am.

And like you said, most of those changes don't create any 
incompatibilities and therefore could be fed back _piecemeal_ into the 
main git repository today without even requiring a major version bump.


Nicolas
