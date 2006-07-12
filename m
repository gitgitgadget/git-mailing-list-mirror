From: Paul Jakma <paul@clubi.ie>
Subject: Re: [PATCH] Remove more gcc extension usage.
Date: Wed, 12 Jul 2006 14:46:01 +0100 (IST)
Message-ID: <Pine.4s.4.64.0607121445510.20605@sheen.jakma.org>
References: <20060708183402.GA17644@spearce.org> <7vy7v4orpt.fsf@assigned-by-dhcp.cox.net>
 <20060708190327.GA17763@spearce.org> <20060709073155.GP22573@lug-owl.de>
 <20060710052255.GA15173@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 15:46:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0f3B-0002yh-VM
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 15:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWGLNqj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 09:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWGLNqj
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 09:46:39 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:60058 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S1751366AbWGLNqi
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 09:46:38 -0400
Received: from sheen.jakma.org (IDENT:U2FsdGVkX1/natPq1WoxYSoEWPAI017EM2HqoXZ22UY@sheen.jakma.org [212.17.55.53])
	(authenticated bits=0)
	by hibernia.jakma.org (8.13.6/8.13.6) with ESMTP id k6CDk1N2032448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Jul 2006 14:46:16 +0100
X-X-Sender: paul@sheen.jakma.org
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060710052255.GA15173@spearce.org>
Mail-Copies-To: paul@jakma.org
Mail-Followup-To: paul@jakma.org
X-NSA: al aqsar fluffy jihad cute musharef kittens jet-A1 ear avgas wax ammonium bad qran dog inshallah allah al-akbar martyr iraq hammas hisballah rabin ayatollah korea revolt pelvix mustard gas x-ray british airways washington peroxide cool
X-Virus-Scanned: ClamAV 0.88.2/1592/Tue Jul 11 21:40:37 2006 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23781>

On Mon, 10 Jul 2006, Shawn Pearce wrote:

> So Monday turned out to be today.  The compiler version:
>
>  $ cc -V
>  cc: Forte Developer 7 C 5.4 2002/03/09
>  usage: cc [ options] files.  Use 'cc -flags' for details

> and from `man cc`:
>
>  -xc99  enables C99 features:

Only a subset of C99.

You need SOS10 for full C99 support, Sun have made SOS freely 
downloadable since version 10.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
It is easier to change the specification to fit the program than vice versa.
