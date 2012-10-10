From: "Balch, David" <david.balch@conted.ox.ac.uk>
Subject: RE: username case conflict in git svn clone [SOLVED]
Date: Wed, 10 Oct 2012 10:18:24 +0100
Message-ID: <E8456C8A4306A24E9D3115FE527913F6043090C6@bannerfish.conted.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Andreas Schwab" <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 11:18:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLsR6-0001bK-Aj
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 11:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028Ab2JJJSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 05:18:30 -0400
Received: from relay0.mail.ox.ac.uk ([129.67.1.161]:59924 "EHLO
	relay0.mail.ox.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918Ab2JJJS3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2012 05:18:29 -0400
X-Greylist: delayed 59639 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Oct 2012 05:18:29 EDT
Received: from bannerfish.conted.ox.ac.uk ([129.67.167.2])
	by relay0.mail.ox.ac.uk with esmtp (Exim 4.75)
	(envelope-from <david.balch@conted.ox.ac.uk>)
	id 1TLsQu-0000kP-09; Wed, 10 Oct 2012 10:18:28 +0100
X-Ninja-PIM: Scanned by Ninja
X-Ninja-AttachmentFiltering: (no action)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
Thread-Topic: username case conflict in git svn clone [SOLVED]
Thread-Index: Ac2mxyu9mXA/kaDgRG2BLN26Fesrmg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207381>

Gah! Schoolboy error.
 juser = Joe User <joe.user@example.com>

Thanks for the pointer!

Cheers,
Dave.

> -----Original Message-----
> From: Andreas Schwab [mailto:schwab@linux-m68k.org]
> Sent: 09 October 2012 19:03
> To: Balch, David
> Cc: git@vger.kernel.org
> Subject: Re: username case conflict in git svn clone
> 
> David Balch <david.balch@conted.ox.ac.uk> writes:
> 
> > whenusers.txt contains:
> >
> > juser Joe User <joe.user@example.com>
> >
> > JUser Joe User <joe.user@example.com>
> 
> Reread the manual.  Hint: there must be an equal sign.
> 
> Andreas.
> 
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276
> 4ED5 "And now for something completely different."
