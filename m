From: Johan Herland <johan@herland.net>
Subject: Re: Builtin-clone?
Date: Tue, 19 Feb 2008 08:08:33 +0100
Message-ID: <200802190808.33611.johan@herland.net>
References: <alpine.LNX.1.00.0802182341430.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Kristian =?iso-8859-1?q?H=F8gsberg?= <krh@redhat.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 08:09:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRMbw-0007oH-9m
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 08:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703AbYBSHJP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Feb 2008 02:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754560AbYBSHJO
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 02:09:14 -0500
Received: from smtp.getmail.no ([84.208.20.33]:36823 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754297AbYBSHJN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Feb 2008 02:09:13 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JWH00J2B56XWD00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 19 Feb 2008 08:08:57 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JWH000TS569JY30@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 19 Feb 2008 08:08:33 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JWH008885695Q60@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 19 Feb 2008 08:08:33 +0100 (CET)
In-reply-to: <alpine.LNX.1.00.0802182341430.5816@iabervon.org>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74379>

On Tuesday 19 February 2008, Daniel Barkalow wrote:
> I remember some discussion of what was still needed in order to make =
clone=20
> a trivial caller of init, config, fetch, and (optionally) checkout, a=
nd=20
> that there was still something. But has anyone actually written the b=
ulk=20
> of builtin-clone.c?

I remember Kristian H=F8gsberg posted some WIP back in December:
http://thread.gmane.org/gmane.comp.version-control.git/67915/

I recently sent him (and the list) an email asking about his progress (=
and -=20
once his work arrives - whether it's a good idea to make 'git clone'=20
produce packed refs), but I have yet to hear from him...


Have fun! :)

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
