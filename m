From: Nicolas Pitre <nico@cam.org>
Subject: Re: GSoC 2009 Prospective student
Date: Sun, 22 Feb 2009 17:22:11 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902221709460.5511@xanadu.home>
References: <a149495b0902221158h16d499f7w8bd18abaf1321e46@mail.gmail.com>
 <20090222204334.GY4371@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Rohan Dhruva <rohandhruva@gmail.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Feb 22 23:24:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbMk4-0006Ri-5L
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 23:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530AbZBVWWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 17:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755373AbZBVWWj
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 17:22:39 -0500
Received: from relais.videotron.ca ([24.201.245.36]:57202 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580AbZBVWWi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 17:22:38 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KFH005UDNGZQQ20@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 22 Feb 2009 17:22:11 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090222204334.GY4371@genesis.frugalware.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111064>

On Sun, 22 Feb 2009, Miklos Vajna wrote:

> On Mon, Feb 23, 2009 at 01:28:33AM +0530, Rohan Dhruva <rohandhruva@gmail.com> wrote:
> > That being said, I have knowledge of C/C++ what was taught to me in
> > school and college. I realize that my qualifications as such are not
> > very impressive, and hence I wish to start with a smaller project. I
> > read on the http://git.or.cz/gitwiki/SoC2009Ideas page that a
> > "jump-in" project might be the "Restartable Clones" proposal.
> 
> I would recommend you to read this thread:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/55254/focus=55298
> 
> Especially Shawn's message, which can be a base for your proposal, if
> you want to work in this.

I don't particularly agree with Shawn's proposal.  Reliance on a stable 
sorting on the server side is too fragile, restrictive and cumbersome.

Restartable clone is _hard_.  Even I who has quite a bit of knowledge in 
the affected area didn't find a satisfactory solution yet.

I think restartable clone is a really bad suggestion for SOC students.  
After all we want successful SOC projects, not ones that even core git 
developers did not yet find a good solution for.

IMHO of course.


Nicolas
