From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Question around git-shell usage in Everyday Git
Date: Thu, 2 Feb 2006 21:23:56 +0000
Message-ID: <200602022123.57120.alan@chandlerfamily.org.uk>
References: <200602012301.56141.alan@chandlerfamily.org.uk> <200602020517.05827.alan@chandlerfamily.org.uk> <7vbqxqxqk7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 02 22:24:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4lvv-0004JE-Nk
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 22:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWBBVX7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 16:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWBBVX7
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 16:23:59 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:8116
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S932257AbWBBVX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2006 16:23:58 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1F4lvp-0001L4-Av; Thu, 02 Feb 2006 21:23:57 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
In-Reply-To: <7vbqxqxqk7.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15518>

On Thursday 02 February 2006 05:44, Junio C Hamano wrote:
...
>
> So in short, I am mildly negative about this.  If I were doing
> this kind of thing I'd have one unix UID and one directory per
> one physical user.  What is the real reason (other than "I just
> do not want to" feeling) you want to have smaller number of home
> directories than you have users?

You are right.  I don't know whether you can tell, but I wrote my last note at 
just gone 5:00am my time this moring  after getting up to go an catch a 
flight to Germany for the day.  I spent the flight and the wait for the 
flight back going over the options in my mind and I NOW think it better to 
have proper home directories.

I do have to say, my motivation originally was more about not announcing to 
the world the internal structure of my filesystem rather than the limitation 
around creating lots of home directories, but part of the reasoning to myself 
today was that that probably doesn't really matter.

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
