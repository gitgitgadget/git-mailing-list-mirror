From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: git-cvsimport-3 and incremental imports
Date: Sun, 20 Jan 2013 20:06:43 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130121010643.GA25437@thyrsus.com>
References: <20130120200922.GC7498@serenity.lan>
 <20130120232008.GA25001@thyrsus.com>
 <20130120234205.GC3474@elie.Belkin>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 02:07:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx5rN-0001GF-Pe
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 02:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608Ab3AUBHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 20:07:14 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:33471
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542Ab3AUBHN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 20:07:13 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 669C2421A9; Sun, 20 Jan 2013 20:06:43 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20130120234205.GC3474@elie.Belkin>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214063>

Jonathan Nieder <jrnieder@gmail.com>:
> Junio proposed a transition strategy, but I don't think it's fair to
> say he has chosen it without discussion or is imposing it on you.

I have said everything I could about the bad effects of encouraging
people to continue to use cvsps-2.x, it didn't budge Junio an
inch, and I'm tired of fighting about it.  Quibbling about the 
semantics of 'impose' will neither change these facts nor make
me any less frustrated with the outcome.

I will continue to do what I can to make cvsps-3.x and cvs-fast-export as
bug-free as possible, given the innate perverseness of CVS.  They
won't be perfect; they will be *better*.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
