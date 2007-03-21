From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] Added make options NO_GUI and WITH_P4IMPORT.
Date: Wed, 21 Mar 2007 17:42:11 +0300
Message-ID: <20070321144210.GF14837@codelabs.ru>
References: <20070320114525.GP96806@codelabs.ru> <etpuen$2uo$2@sea.gmane.org> <20070321051406.GW96806@codelabs.ru> <Pine.LNX.4.63.0703211213100.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070321115004.GB14837@codelabs.ru> <Pine.LNX.4.63.0703211522320.22628@wbgn013.biozentrum.uni-wuerzburg.de> <4601437D.1010700@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Mar 21 15:42:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU21W-0001b3-Oh
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 15:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbXCUOmS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 10:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752923AbXCUOmS
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 10:42:18 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:55312 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbXCUOmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 10:42:16 -0400
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HU211-0004Nt-A1; Wed, 21 Mar 2007 17:42:15 +0300
Content-Disposition: inline
In-Reply-To: <4601437D.1010700@gnu.org>
X-Spam-Status: No, score=-1.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_40
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42792>

Paolo, good day.

Wed, Mar 21, 2007 at 03:38:53PM +0100, Paolo Bonzini wrote:
> >> I am happening to develop on some machines on which I have no
> >> X-Windows or any GUI providers at all, so I prefer not to have the
> >> Tcl/Tk dependency at all.
> > 
> > If you don't do something, it is often interesting to state why: if you 
> > don't install something to prevent a dependency you don't want to have, it 
> > is different from saying that you do not want to have a GUI, _even if_ the 
> > dependency is there already.
> 
> I read his message as "these are useless for me, so why introduce a
> useless dependency?"  The "effect" is to have no Tcl dependence,
> but the original reason is to have no GUI.

Yep, you're right. That was I meant originally. How do you feel
about NO_GUI or NO_TCL names?
-- 
Eygene
