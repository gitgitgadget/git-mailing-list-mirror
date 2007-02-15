From: Bill Lear <rael@zopyra.com>
Subject: Re: OT: data destruction classics (was: Re: Error converting from
 1.4.4.1 to 1.5.0?)
Date: Thu, 15 Feb 2007 05:58:22 -0600
Message-ID: <17876.19166.796821.477083@lisa.zopyra.com>
References: <7vhctor78j.fsf@assigned-by-dhcp.cox.net>
	<17875.17647.74882.218627@lisa.zopyra.com>
	<7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net>
	<17875.30187.289679.417079@lisa.zopyra.com>
	<17875.30687.661794.512124@lisa.zopyra.com>
	<Pine.LNX.4.64.0702141314440.20368@woody.linux-foundation.org>
	<17875.33204.413186.355557@lisa.zopyra.com>
	<Pine.LNX.4.64.0702141722410.1757@xanadu.home>
	<17875.36879.872210.264473@lisa.zopyra.com>
	<45D3B4E7.8050408@fs.ei.tum.de>
	<20070215021345.GB29732@spearce.org>
	<Pine.LNX.4.64.0702141836510.20368@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 15 12:58:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHfG0-0004oH-8A
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 12:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965673AbXBOL6c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 06:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965681AbXBOL6c
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 06:58:32 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61800 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965673AbXBOL6c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 06:58:32 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1FBwNF04773;
	Thu, 15 Feb 2007 05:58:23 -0600
In-Reply-To: <Pine.LNX.4.64.0702141836510.20368@woody.linux-foundation.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39822>

On Wednesday, February 14, 2007 at 18:51:09 (-0800) Linus Torvalds writes:
>On Wed, 14 Feb 2007, Shawn O. Pearce wrote:
>> Simon 'corecode' Schubert <corecode@fs.ei.tum.de> wrote:
>> > Bill Lear wrote:
>> > >I'm still muttering to myself that I could be that dumb...
>> > 
>> > Still better than trying to backup with
>> > 
>> > tar czvf data* destfile.tar.gz
>> > 
>> > automatic tape backup is a real helper then :)
>> 
>> or manual backup to "tape", where the tape device supplied was
>> the only disk...  SunOS 4 did not take too kindly to its kernel,
>> swap space, root fs being overwritten...
>
>Hey, I can beat that (stop me at any time you've heard this story. No? Ok, 
>then..)
>
>I auto-dialed my harddisk. 
>...
>That was one big (perhaps _the_) impetus for just deciding to make Linux 
>good enough that I wouldn't need to actually reinstall Minix. ...
>was already able to bootstrap itself at that point, it just wasn't quite 
>as good yet. I fixed that in short order, and indeed, I never did end up 
>feeding the 17 floppy disks into my computer to reinstall Minix.
>
>Moral of the story: "Stupidity is what makes the world go round."

Agreed.  I often think stupid mistakes are a way of injecting random
--- and at the time, unwelcome --- searches into creative solution
spaces.

As in other cases, this one involved an extremely simple answer very
close to the start of the solution space, but (thanks to me), we drug
this out all over the place and got to explore lots of things we
otherwise wouldn't have.


Bill
