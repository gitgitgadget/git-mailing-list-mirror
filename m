From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: [RFC/PATCH] git wrapper: add --git-path=<path> and --bare options
Date: Wed, 26 Jul 2006 08:18:25 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060726061825.GA3638@informatik.uni-freiburg.de>
References: <Pine.LNX.4.63.0607251926190.29667@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0607251042120.29649@g5.osdl.org> <Pine.LNX.4.63.0607251952000.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Jul 26 08:18:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5cjF-00065c-Ap
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 08:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbWGZGSb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 02:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbWGZGSb
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 02:18:31 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:61331 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1030312AbWGZGSb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 02:18:31 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1G5cj0-0003fx-46; Wed, 26 Jul 2006 08:18:30 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.6/8.12.11) with ESMTP id k6Q6IQcF004055;
	Wed, 26 Jul 2006 08:18:26 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.6/8.12.11/Submit) id k6Q6IP6N004054;
	Wed, 26 Jul 2006 08:18:25 +0200 (MEST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	junkio@cox.net
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607251952000.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24208>

Hi,

Johannes Schindelin wrote:
> > Since "--git-dir" makes more sense than "--git-path", I'd suggest just 
> > fixing the OPTIONS section ;)
> 
> Will do. Thanks.

When you're at it, you may want to change the Subject, too.

Oh, you already sent out a new patch with the old Subject :-)

Best regards
Uwe
-- 
Uwe Zeisberger

http://www.google.com/search?q=sin%28pi%2F2%29
