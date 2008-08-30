From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] git gui: use apply --unidiff-zero when staging hunks
   without context
Date: Sat, 30 Aug 2008 21:43:19 +0200
Message-ID: <48B9A2D7.8090801@telecom.at>
References: <20080830164527.GA25370@localhost> <20080830165600.GB25370@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Aug 30 21:51:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZWTe-0006gQ-MZ
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 21:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbYH3TuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 15:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbYH3TuM
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 15:50:12 -0400
Received: from mail2.drei.at ([213.94.78.131]:61585 "EHLO mail2.drei.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752463AbYH3TuL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 15:50:11 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Aug 2008 15:50:11 EDT
Received: (qmail 7937 invoked from network); 30 Aug 2008 19:43:22 -0000
Received: from atumsv2vp02.um.internal (HELO atummr0mt01.um.internal) ([172.23.102.243])
          (envelope-sender <johannes.sixt@telecom.at>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 30 Aug 2008 19:43:22 -0000
Received: from [77.119.16.207] (atummr0vp02.um.internal [172.23.102.241])
	by atummr0mt01.um.internal (MOS 3.8.3-GA)
	with ESMTP id AGV34640;
	Sat, 30 Aug 2008 21:43:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080830165600.GB25370@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94411>

Clemens Buchacher schrieb:
> git apply does not work correctly with zero-context patches. It does a
> little better with --unidiff-zero.

No, NO, NOOOOO! This kills your data!

http://thread.gmane.org/gmane.comp.version-control.git/67854/focus=68127

-- Hannes
