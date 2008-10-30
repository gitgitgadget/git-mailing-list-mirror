From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI
 revamp
Date: Thu, 30 Oct 2008 13:17:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810301316220.13034@xanadu.home>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
 <20081030143918.GB14744@mit.edu> <vpqmygmw1mr.fsf@bauges.imag.fr>
 <alpine.LFD.2.00.0810301259130.13034@xanadu.home>
 <20081030170329.GK24098@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Theodore Tso <tytso@mit.edu>,
	Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 18:18:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvbAS-00065R-9X
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 18:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758013AbYJ3RRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 13:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757998AbYJ3RRX
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 13:17:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49456 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757980AbYJ3RRX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 13:17:23 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9K00AAHANPT5I0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 30 Oct 2008 13:16:37 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081030170329.GK24098@artemis.corp>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99504>

On Thu, 30 Oct 2008, Pierre Habouzit wrote:

> On Thu, Oct 30, 2008 at 05:00:18PM +0000, Nicolas Pitre wrote:
> > On Thu, 30 Oct 2008, Matthieu Moy wrote:
> > 
> > > I've already argued in favor of allowing "git reset --hard <files>",
> > > which is consistant with existing terminology and doesn't add an extra
> > > command, but without success.
> > 
> > If you have a file argument, the --hard option is redundant, isn't it?
> > So what about simply "git reset <file>" ?
> 
> errrrm, git reset <file> resets the index notion of the file to its status
> in HEAD... which I'm sure is *somehow* useful to "some" people ;P

Too bad...


Nicolas
