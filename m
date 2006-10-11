From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Approxidate licensing
Date: Wed, 11 Oct 2006 08:57:03 +0100
Message-ID: <1160553423.7920.60.camel@pmac.infradead.org>
References: <Pine.LNX.4.64.0610101246241.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 09:57:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXYxp-0002wC-3q
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 09:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161013AbWJKH5N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 03:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161011AbWJKH5N
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 03:57:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5550 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161013AbWJKH5M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 03:57:12 -0400
Received: from pmac.infradead.org ([81.187.2.168])
	by pentafluge.infradead.org with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1GXYxc-0001L8-TM; Wed, 11 Oct 2006 08:57:05 +0100
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0610101246241.9789@iabervon.org>
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28701>

On Tue, 2006-10-10 at 13:39 -0400, Daniel Barkalow wrote:
> Would the three of you agree to license date.c under the LGPL or BSD? It 
> looks like you're the only authors of non-trivial changes [1]. And it seems 
> reasonable to want the date parsing thing under non-GPL terms outside of 
> git.

Yeah, LGPL and BSD are both fine by me -- although I don't actually
recognise much of my own code in there. 

Btw, why isn't the meaning of 'tea-time' properly modified according to
the locale?

-- 
dwmw2
