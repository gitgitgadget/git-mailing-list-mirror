From: Alexander Litvinov <lan@ac-sw.com>
Subject: Re: What is in git.git
Date: Sat, 21 Jan 2006 16:33:03 +0600
Organization: AcademSoft Ltd.
Message-ID: <200601211633.03479.lan@ac-sw.com>
References: <7v3bjiuhxb.fsf@assigned-by-dhcp.cox.net> <200601211524.03096.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 11:33:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0G3W-0004BQ-0I
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 11:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWAUKdL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 05:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWAUKdL
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 05:33:11 -0500
Received: from gw.ac-sw.com ([81.1.223.2]:13239 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S932104AbWAUKdK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 05:33:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by gw.ac-sw.com (Postfix) with ESMTP id 07FC8BD37;
	Sat, 21 Jan 2006 16:33:09 +0600 (NOVT)
Received: from gw.ac-sw.com ([127.0.0.1])
 by localhost (gw.ac-sw.com [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02869-08; Sat, 21 Jan 2006 16:33:06 +0600 (NOVT)
Received: from lan.ac-sw.lcl (lan.ac-sw.lcl [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP id AEF7CBD25;
	Sat, 21 Jan 2006 16:33:06 +0600 (NOVT)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id 9C6C48DA036F; Sat, 21 Jan 2006 16:33:06 +0600 (NOVT)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 0CF4F8DA0360;
	Sat, 21 Jan 2006 16:33:04 +0600 (NOVT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8
In-Reply-To: <200601211524.03096.lan@ac-sw.com>
Content-Disposition: inline
X-Virus-Scanned: amavisd-new at gw.ac-sw.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14992>

> 1. Can I bind some branch instead of tag (commit) ?
> 2. Is it possible to commit changes of subpro's file in master branch into
> subpro branch to make this changes visible to master-2 ?

One more comment: it seems to me it is not possible to make two branches on 
separate subprojects with the same name.
