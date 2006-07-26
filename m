From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] git wrapper: add --git-path=<path> and --bare options
Date: Wed, 26 Jul 2006 00:12:04 -0700
Message-ID: <7vfygou9ff.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607251926190.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0607251042120.29649@g5.osdl.org>
	<Pine.LNX.4.63.0607251952000.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060726061825.GA3638@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Jul 26 09:12:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5dYw-00051V-UQ
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 09:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWGZHMH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 03:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWGZHMH
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 03:12:07 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:51087 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932513AbWGZHMG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 03:12:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060726071205.EADT2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Jul 2006 03:12:05 -0400
To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20060726061825.GA3638@informatik.uni-freiburg.de> (Uwe
	Zeisberger's message of "Wed, 26 Jul 2006 08:18:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24209>

Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> writes:

> Johannes Schindelin wrote:
>> > Since "--git-dir" makes more sense than "--git-path", I'd suggest just 
>> > fixing the OPTIONS section ;)
>> 
>> Will do. Thanks.
>
> When you're at it, you may want to change the Subject, too.
>
> Oh, you already sent out a new patch with the old Subject :-)

I've fixed things up to replace all --git-path with --git-dir, I
think.
