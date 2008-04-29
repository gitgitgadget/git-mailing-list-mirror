From: Fredrik Skolmli <fredrik@frsk.net>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 22:50:31 +0200
Message-ID: <20080429205031.GA14547@frsk.net>
References: <20080429124152.GB6160@dpotapov.dyndns.org> <481733A3.4010802@op5.se> <alpine.LFD.1.10.0804291132060.23581@xanadu.home> <7f9d599f0804290859y6a579302m5db9f7f827b320a4@mail.gmail.com> <alpine.LFD.1.10.0804291232130.23581@xanadu.home> <7f9d599f0804291048n2c706f3amdf159ffe86bdbc8@mail.gmail.com> <alpine.LFD.1.10.0804291352120.23581@xanadu.home> <7f9d599f0804291102j4a30c344h18d12d03a6d5953b@mail.gmail.com> <alpine.LNX.1.00.0804291410340.19665@iabervon.org> <7f9d599f0804291331v2f44bee1y29c1580d68a3107a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Henrik Austad <henrikau@orakel.ntnu.no>, git@vger.kernel.org
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Tue Apr 29 22:51:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqwna-0001Kd-IC
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 22:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761631AbYD2Uuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 16:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761482AbYD2Uut
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 16:50:49 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:53965 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761261AbYD2Uut (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 16:50:49 -0400
Received: from asterix.samfundet.no ([2001:700:300:1800::f] ident=postfix)
	by cassarossa.samfundet.no with esmtp (Exim 4.63)
	(envelope-from <fredrik@frsk.net>)
	id 1JqwmV-0006uV-Sf; Tue, 29 Apr 2008 22:50:32 +0200
Received: by asterix.samfundet.no (Postfix, from userid 1000)
	id D0975A60359; Tue, 29 Apr 2008 22:50:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7f9d599f0804291331v2f44bee1y29c1580d68a3107a@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80731>

On Tue, Apr 29, 2008 at 01:31:51PM -0700, Geoffrey Irving wrote:

> I sincerely hope that pdf/postscript don't allow the internal
> rendering code to branch based on the current date.  That would be an
> absurd security hole, and would indeed make you entirely correct.  If
> you actually know that it is possible to write that in postscript, I
> would very much want to see an example.

Have a look at 

* http://th.informatik.uni-mannheim.de/People/Lucks/HashCollisions/letter_of_rec.ps
vs 
* http://th.informatik.uni-mannheim.de/People/Lucks/HashCollisions/order.ps

both found on a website[1] already mentioned[2] in this thread. :-)

[1]: http://th.informatik.uni-mannheim.de/People/Lucks/HashCollisions/
[2]: http://marc.info/?l=git&m=120949349923584&w=2

- F

-- 
Regards,
Fredrik Skolmli
