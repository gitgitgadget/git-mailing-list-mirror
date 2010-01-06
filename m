From: Roman Fietze <roman.fietze@telemotive.de>
Subject: Re: [PATCH] bash completion: add space between branch name and status flags
Date: Wed, 6 Jan 2010 12:59:01 +0100
Organization: Telemotive AG
Message-ID: <201001061259.01639.roman.fietze@telemotive.de>
References: <200911201309.16193.roman.fietze@telemotive.de> <20091230224129.6117@nanako3.lavabit.com> <20091230145751.GE6914@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 06 13:05:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSUe7-0004LB-NJ
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 13:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807Ab0AFMFr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jan 2010 07:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755715Ab0AFMFr
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 07:05:47 -0500
Received: from coyote.quickmin.net ([217.14.112.24]:65459 "EHLO
	coyote.quickmin.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755478Ab0AFMFq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jan 2010 07:05:46 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jan 2010 07:05:46 EST
Received: (qmail 19511 invoked from network); 6 Jan 2010 12:59:03 +0100
Received: by simscan 1.4.0 ppid: 19507, pid: 19509, t: 0.0126s
         scanners: clamav: 0.95.2/m:49/d:8609
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=default; d=telemotive.de;
  b=LnO7voZ6S8cKzqdIrt9oC6l7QYQQkBLm6YXc1JhjKUAemWhWrJigcgUeEQ2ZBsz1Dd+MwxNYfkvPvkCpvlJgLVX53+1VC6CDmgwKcT3tRjfu0WDWu9scr2DBTJVxA6ZCI+6L0vONPQp6ashzSvpr//rh8ht/RWd40XLX1UoJ8FI=  ;
Received: from mail.telemotive.de (62.206.149.210)
  by coyote.quickmin.net with SMTP; 6 Jan 2010 12:59:03 +0100
Received: from alderan.mit.telemotive.de ([192.168.5.15])
          by mail.telemotive.de (Lotus Domino Release 8.0.2FP1)
          with ESMTP id 2010010612590130-700 ;
          Wed, 6 Jan 2010 12:59:01 +0100 
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de [192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id DF6C2B7FA0;
	Wed,  6 Jan 2010 12:59:01 +0100 (CET)
Received: by rfietze.mit.telemotive.de (Postfix, from userid 10062)
	id BA1791820A0F; Wed,  6 Jan 2010 12:59:01 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.27.39-0.2-default; KDE/4.3.4; x86_64; ; )
In-Reply-To: <20091230145751.GE6914@spearce.org>
X-MIMETrack: Itemize by SMTP Server on muc/Telemotive(Release 8.0.2FP1|January 12, 2009) at
 06.01.2010 12:59:01,
	Serialize by Router on muc/Telemotive(Release 8.0.2FP1|January 12, 2009) at
 06.01.2010 12:59:02,
	Serialize complete at 06.01.2010 12:59:02
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136262>

Hello Shawn,

On Wednesday 30 December 2009 15:57:51 Shawn O. Pearce wrote:

> ... but Roman Fietze didn't send
> a revised patch, so it got dropped

Sorry about that, but our Notes "spam filter" has been eating
important mail again.


I'l check the version as proposed by you as soon as I'm back.


Roman

--=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
