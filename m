From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Eclipse Plugin install issue
Date: Sun, 8 Feb 2009 01:20:06 +0100
Message-ID: <200902080120.06894.robin.rosenberg.lists@dewire.com>
References: <b0a3bf780902060717l653cc6dcx385aa147f606a520@mail.gmail.com> <200902061710.34337.robin.rosenberg@dewire.com> <1234007463339-2288907.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tim Schofield <tim.schofield1960@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 01:21:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVxQb-0006EF-Jy
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 01:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755719AbZBHAUO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Feb 2009 19:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755485AbZBHAUN
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 19:20:13 -0500
Received: from mail.dewire.com ([83.140.172.130]:14922 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755409AbZBHAUM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Feb 2009 19:20:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0E00D147E89B;
	Sun,  8 Feb 2009 01:20:11 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VFbeEnKBv847; Sun,  8 Feb 2009 01:20:08 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 1150F800258;
	Sun,  8 Feb 2009 01:20:08 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <1234007463339-2288907.post@n2.nabble.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108906>

l=F6rdag 07 februari 2009 12:51:03 skrev Tim Schofield:
> I am getting this identical error. I am using 200902052244 and eclips=
e
> Version: 3.4.1 Build id: M20080911-1700.

Was that a pristine version of that build or did you have other plugins=
 too?
I know Eclipse can give very confusing error messages sometimes when
things don't match up. It might be that we have a dependency requiremen=
t
that is too strict and collides with another plugin.

-- robin
