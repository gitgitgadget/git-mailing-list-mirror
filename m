From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Thu, 15 Jan 2009 15:03:46 +0200
Message-ID: <871vv4soul.fsf@iki.fi>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>
	<alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de>
	<87ljtdk9b3.fsf@iki.fi> <200901142059.09005.trast@student.ethz.ch>
	<alpine.DEB.1.00.0901142258250.3586@pacific.mpi-cbg.de>
	<8763khtbfc.fsf@iki.fi>
	<alpine.DEB.1.00.0901151337080.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 14:06:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNRuW-00076J-Bq
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 14:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654AbZAOND5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 08:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754497AbZAOND5
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 08:03:57 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:50409 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbZAOND4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 08:03:56 -0500
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 48FC59C703C226AD; Thu, 15 Jan 2009 15:03:47 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LNRsw-0002co-Oo; Thu, 15 Jan 2009 15:03:46 +0200
In-Reply-To: <alpine.DEB.1.00.0901151337080.3586@pacific.mpi-cbg.de> (Johannes Schindelin's message of "Thu\, 15 Jan 2009 13\:41\:37 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105792>

Johannes Schindelin (2009-01-15 13:41 +0100) wrote:

> Exactly because it works logically, I do not want to change it.  This is 
> what the user said, and for a change, it could be what the user meant.

I'm just saying that it would be helpful (to me at least) if the man
page included this advice. Thomas Rast already suggested this in his
version of the man page change:

    You may want to append `|\S` to your regular expression to make sure
    that it matches all non-whitespace characters.
