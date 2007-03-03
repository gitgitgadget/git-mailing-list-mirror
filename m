From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: (Re: gitweb not friendly to firefox?) and unusable in the lynx
Date: Sat, 3 Mar 2007 04:41:35 +0100
Message-ID: <200703030441.36627.jnareb@gmail.com>
References: <989B956029373F45A0B8AF02970818902DA81B@zch01exm26.fsl.freescale.net> <200703030357.18822.jnareb@gmail.com> <alpine.LRH.0.82.0703022223060.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Oleg Verych <olecom@flower.upol.cz>,
	Junio C Hamano <junkio@cox.net>,
	Li Yang-r58472 <LeoLi@freescale.com>, rea-git@codelabs.ru,
	Raimund Bauer <ray@softwarelandschaft.com>,
	git@vger.kernel.org, Alp Toker <alp@atoker.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Mar 03 04:39:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNL5q-0000Lc-FA
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 04:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992913AbXCCDjV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 22:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992935AbXCCDjV
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 22:39:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:22846 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992913AbXCCDjU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 22:39:20 -0500
Received: by ug-out-1314.google.com with SMTP id 44so872662uga
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 19:39:19 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=c716GGC8DzJw6ud+inZktKa/jTRPs8/d9Y6QEum1VT54rVC8MPyCg97BKDoXlazpuYaQhbouCyx+igAt7rE6d//wHUxKIsvUgbqNqpAXDDu8XM1zj4eMVBlzjTQUdMOdxY1rVTL8rNx4OxbRZAKGpYqmbDyWkwSycX6C8Oh8PYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=us+VRkfbYiSMrpXMEKmJDOulLMD0DGIvOLgXM+JIuyzcCZH7J80aPs8H5/VGB9zn+j2hJCHmmIJcapOF1OxdOfYgtd13Yibregx+3Rb/PPe/j054E72p05ufMtw0ysnKQxnsgsx4msIlN4VdiVesGfabTz66eXKnD89MZhUTmDA=
Received: by 10.67.29.12 with SMTP id g12mr4433816ugj.1172893158999;
        Fri, 02 Mar 2007 19:39:18 -0800 (PST)
Received: from host-81-190-30-210.torun.mm.pl ( [81.190.30.210])
        by mx.google.com with ESMTP id w7sm15015710mue.2007.03.02.19.39.14;
        Fri, 02 Mar 2007 19:39:15 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LRH.0.82.0703022223060.29426@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41269>

Nicolas Pitre wrote:
> On Sat, 3 Mar 2007, Jakub Narebski wrote:
> 
>> By "conservatively" it means that it uses 'application/xhtml+xml' only when
>> client explicitly claims that it accepts its, and it is not due to for
>> example */* accept globbing.
>> 
>> So if lynx isn't working, it is its damn fault...
> 
> I absolutely don't care.
> 
> I use lynx, and lynx worked perfectly fine before.  So it is not lynx 
> that broke it.  Please fix gitweb.

WORKSFORME.

Lynx Version 2.8.5rel.1 (04 Feb 2004)
libwww-FM 2.14, SSL-MM 1.4.1, OpenSSL 0.9.7f

git web interface version 1.5.0.rc3.gc0bbd

(and application/xhtml+xml is _not_ among Accept's).
-- 
Jakub Narebski
Poland
