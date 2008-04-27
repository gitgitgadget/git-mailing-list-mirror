From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [GIT PULL] sh updates for 2.6.25
Date: Sun, 27 Apr 2008 20:04:29 +0100
Message-ID: <1209323069.25560.88.camel@pmac.infradead.org>
References: <20080415172333.GA29489@linux-sh.org>
	 <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 21:06:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqCCA-0006Mw-Al
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 21:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761458AbYD0TEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 15:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761255AbYD0TEi
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 15:04:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:36158 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761455AbYD0TEh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 15:04:37 -0400
Received: from pmac.infradead.org ([2001:8b0:10b:1:20d:93ff:fe7a:3f2c])
	by pentafluge.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1JqCAp-0002wm-DV; Sun, 27 Apr 2008 19:04:31 +0000
In-Reply-To: <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org>
X-Mailer: Evolution 2.22.1 (2.22.1-1.fc9) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80477>

On Tue, 2008-04-15 at 11:01 -0700, Linus Torvalds wrote:
> Paul, your git tree is odd. Not quite corrupt, but it doesn't really 
> follow the rules either.
> 
> In particular, it has empty lines at the top of those commits, and I 
> wonder how you created them. 

Hm, I noticed those go past on the commits list and meant to
investigate, but got distracted before I got round to it. Should I
assume there's nothing to fix in the script which feeds the list, then?

$todo--; :)

-- 
dwmw2
