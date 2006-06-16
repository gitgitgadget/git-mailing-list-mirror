From: Junio C Hamano <junkio@cox.net>
Subject: Re: Collecting cvsps patches
Date: Fri, 16 Jun 2006 16:22:39 -0700
Message-ID: <7vslm4bs8w.fsf@assigned-by-dhcp.cox.net>
References: <20060611122746.GB7766@nowhere.earth>
	<46a038f90606111516v2c8c68e2v818a0a0f9dca2da6@mail.gmail.com>
	<20060611224205.GF1297@nowhere.earth> <e6jj39$6ua$1@sea.gmane.org>
	<20060616212334.GN7766@nowhere.earth> <e6v7vr$ila$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 17 01:22:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrNeG-00029a-7J
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 01:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWFPXWl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 19:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWFPXWl
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 19:22:41 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:45984 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932472AbWFPXWk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 19:22:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060616232239.WPJG27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Jun 2006 19:22:39 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e6v7vr$ila$1@sea.gmane.org> (Jakub Narebski's message of "Fri,
	16 Jun 2006 23:31:46 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21988>

Jakub Narebski <jnareb@gmail.com> writes:

> Yann Dirson wrote:
>
>> On Mon, Jun 12, 2006 at 11:27:37AM +0000, Anand Kumria wrote:
>>> On Mon, 12 Jun 2006 00:42:05 +0200, Yann Dirson wrote:
>>> 
>>> > http://ydirson.free.fr/soft/git/cvsps.git
>>> 
>>> I think you need to chmod +x hooks/post-update
>>> 
>>> and then run 'git-update-server-info'.
>> 
>> Unfortunately, I only have FTP access to push to this site, so I have
>> to run git-update-server-info myself, and occasionally forget.  I'll
>> have to bring up-to-date my old cg-ftppush script some day :)
>
> Or extend git to allow push/pull also via ftp?

Patches welcome.
