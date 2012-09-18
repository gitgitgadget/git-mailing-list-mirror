From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: Can git pull from a mercurial repository?
Date: Tue, 18 Sep 2012 14:40:54 +0200
Message-ID: <000a01cd959a$d8cd0730$8a671590$@schmitz-digital.de>
References: <k39lir$gpm$1@ger.gmane.org> <50585F10.3080307@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Andreas Ericsson'" <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 18 14:41:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDx7A-0001rk-Uo
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 14:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932960Ab2IRMlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 08:41:12 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:65155 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932928Ab2IRMlK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 08:41:10 -0400
Received: from DualCore (dsdf-4d0a151d.pool.mediaWays.net [77.10.21.29])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0LlLpD-1TpDGs0Qo3-00atnz; Tue, 18 Sep 2012 14:41:09 +0200
In-Reply-To: <50585F10.3080307@op5.se>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGhEpNGyEwugTaQMUDb1fc5WliObQHoH3lpl9nHtFA=
Content-Language: de
X-Provags-ID: V02:K0:/+qmPNjXOmN+tZanUrGMDfgVAsWoObxEQzhMyB/+Btt
 4ShONWhXsAy9VPDSPDzeJzZE+R2fD83lxqRNEKwAPoXMPgtVHQ
 rLCKrKnb0VYiT0H3D8RrV/KvGDkXpwZS36QZ2C+l6ONB0dDjZI
 4uIX4Xzzg1KRPnTaSF4SP0FtCXV5pHazfrffJJKSeQ/UUGviKh
 mGE3ncuqU1EaGQFfbNxqeA2Ftb6BCYsqficxYuDNfCultXbBYD
 M/zGm4kXqYB3yPvkTdX1u0yoDIcI36kbRge5GauuY45idnw8t8
 KDi+MHDZsXB51Mcm0r2hjicJ9BhTJ/KJL0TcFViLWVmJRT1EXp
 UBo8MdgUIIQ6rOVjP5OaSzSVKYaG0D0rcdIAST1ToqSjVyyHCv
 3LBEtjSacthtw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205829>

> From: Andreas Ericsson [mailto:ae@op5.se]
> Sent: Tuesday, September 18, 2012 1:46 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: Can git pull from a mercurial repository?
> 
> On 09/18/2012 01:22 PM, Joachim Schmitz wrote:
> > Is there an easy way to get git to clone/pull from a Mercurial repository?
> >
> 
> Yes. Google "git remote helpers" and you'll most likely find it.

Well, I found a few. No idea how to get them to work though (so far for the 'easy' part of my question)

It seems https://github.com/rfk/git-remote-hg requires Python 2.5 (and I only have 2.4), also I have no idea how to get it installed
https://github.com/SRabbelier/git is 3 years old, apparently never made it into git, guess for a reason? 
Then I found https://github.com/fingolfin/git/commits/remote-hg, looks very confusing to me...
