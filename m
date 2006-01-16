From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [kernel.org users] [RFC] "clone --naked"?
Date: Mon, 16 Jan 2006 10:06:05 +0100
Message-ID: <1137402365.3034.5.camel@laptopd505.fenrus.org>
References: <Pine.LNX.4.64.0601121556240.3535@g5.osdl.org>
	 <43CB57A0.29999.F89D30F@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	 <7vfynoy5p5.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	git@vger.kernel.org, users@kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 10:06:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyQJs-0007rG-5a
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 10:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWAPJGN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 04:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWAPJGM
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 04:06:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38371 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751107AbWAPJGL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 04:06:11 -0500
Received: from [2002:d55d:ead:110:20e:35ff:fea5:7eb2] (helo=[IPv6:2002:d55d:ead:110:20e:35ff:fea5:7eb2])
	by pentafluge.infradead.org with esmtpsa (Exim 4.54 #1 (Red Hat Linux))
	id 1EyQJS-0002L4-RB; Mon, 16 Jan 2006 09:06:07 +0000
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfynoy5p5.fsf_-_@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14731>

On Sun, 2006-01-15 at 23:47 -0800, Junio C Hamano wrote:
> "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.DE> writes:
> 
> > On 14 Jan 2006 at 15:39, Junio C Hamano wrote:
> >
> > [...]
> >> BTW, I have been meaning to make this easier, by introducing a
> >> new option to "git clone", like this:
> > ...
> > You must be over 21 to use --naked, however ;-)
> > Maybe you find a better word.
> 
> Linus seems to use word "bare" sometimes.  Checking the git-core
> documentation, repository-layout documentation first used the
> word naked on Sep 1 2005, while there is no mention of "bare"
> repository anywhere.  Maybe "bare" is preferred?
> 
> I hope you do not mind my sending this message out to git list
> to take a quick poll.

While I don't give a rats bottom about the "21"-ness of naked, "naked"
is more likely to trigger spam traps than "bare" though... just a side
consideration but unfortunately needed nowadays ;(
