From: Noel Grandin <noel@peralex.com>
Subject: Re: Any news on an Eclipse plugin?
Date: Tue, 07 Mar 2006 08:59:26 +0200
Message-ID: <440D2F4E.9090009@peralex.com>
References: <20060306173229.GA27965@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1141714747-80022-317"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 07:59:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGWAV-0007oC-6R
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 07:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbWCGG7g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 01:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752078AbWCGG7g
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 01:59:36 -0500
Received: from mail.peralex.com ([196.1.58.220]:10744 "EHLO mail.peralex.com")
	by vger.kernel.org with ESMTP id S1752077AbWCGG7f (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 01:59:35 -0500
Received: from [192.168.1.230] (noel.ct [192.168.1.230])
	by mail.peralex.com (8.13.4/8.13.4) with ESMTP id k276x0BF002267;
	Tue, 7 Mar 2006 08:59:00 +0200 (SAST)
	(envelope-from noel@peralex.com)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050923 Thunderbird/1.0.7 Mnenhy/0.7.3.0
X-Accept-Language: en-us, en
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060306173229.GA27965@spearce.org>
X-Enigmail-Version: 0.93.0.0
X-Scanned-By: MIMEDefang 2.42
X-Synonym: Copied by Synonym (http://www.modulo.ro/synonym) to: mailbackup@peralex.com
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (mail.peralex.com [192.168.1.7]); Tue, 07 Mar 2006 08:59:07 +0200 (SAST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17323>

This is a multi-part message in MIME format...

------------=_1141714747-80022-317
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


The subversion plugin (subclipse.tigris.org) might be a good starting
point since it delegates a lot of it's low-level work through an
interface called svnClientAdapter. Re-implementing that to talk to git
should get you something useful in a reasonable time-frame.

Note that an eclipse team plugin is a pretty complicated beast.


Shawn Pearce wrote:

>I'm considering starting an Eclipse plugin for GIT.  So I did
>some digging to see if any existing projects have anything I can
>contribute to (rather than starting from scratch) but I only turned
>up a thread from May 2005 started by Jon Seymour:
>
>  http://www.gelato.unsw.edu.au/archives/git/0505/3357.html
>
>anyone know anything newer?  If there's nothing existing worth
>starting with other than the CVS or SVN plugins (as mentioned in
>this thread) I'll probably start putting together a prototype and
>start making it available early next week.
>
>I'm going to carefully read the thread that I linked to above before
>writing anything, so there's no need to start getting into the core
>and not so core discussion again.  I'll read it over for myself. :-)
>
>  
>


NOTICE: Please note that this email, and the contents thereof, 
are subject to the standard Peralex email disclaimer, which may 
be found at: http://www.peralex.com/disclaimer.html

If you cannot access the disclaimer through the URL attached 
 and you wish to receive a copy thereof please send 
 an email to email@peralex.com

------------=_1141714747-80022-317--
