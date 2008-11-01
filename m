From: Nicolas Pitre <nico@cam.org>
Subject: Re: Are binary xdeltas only used if you use git-gc?
Date: Sat, 01 Nov 2008 09:25:17 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0811010924550.13034@xanadu.home>
References: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com>
 <m37i7pggnk.fsf@localhost.localdomain>
 <f1d2d9ca0810310428o166dc075wbb43c00c1a555350@mail.gmail.com>
 <200810311726.57122.jnareb@gmail.com> <vpqej1wra1c.fsf@bauges.imag.fr>
 <alpine.LFD.2.00.0810311549570.13034@xanadu.home>
 <f1d2d9ca0811010454u203a7c88x1e09735b3fc1358f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Thanassis Tsiodras <ttsiodras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 14:26:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwGV9-00010S-JQ
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 14:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbYKANZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 09:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbYKANZY
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 09:25:24 -0400
Received: from relais.videotron.ca ([24.201.245.36]:16906 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbYKANZX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 09:25:23 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9N0086IPA53950@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 01 Nov 2008 09:25:17 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <f1d2d9ca0811010454u203a7c88x1e09735b3fc1358f@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99741>

On Sat, 1 Nov 2008, Thanassis Tsiodras wrote:

> Thanks to everybody for your help.
> 
> I will setup an alias to always use "git push --thin".
> For the reverse direction, I don't see a --thin for "git pull",
> 
> My understanding is that "git pull" is optimal,
> and does what --thin does for push anyway, right?

Exact.


Nicolas
