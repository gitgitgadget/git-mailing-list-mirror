From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words
	configurable
Date: Sat, 10 May 2008 12:14:13 +0300
Message-ID: <20080510091413.GB5542@mithlond.arda.local>
References: <46dff0320805041840g1b9362d3u138b9d40cde160f2@mail.gmail.com> <7vprs1ny5e.fsf@gitster.siamese.dyndns.org> <46dff0320805050510t3bc5fd0eq44e0d58d1bb57629@mail.gmail.com> <46dff0320805051740o65eee07eqc7073e4fa7996277@mail.gmail.com> <alpine.DEB.1.00.0805060954470.30431@racer> <46dff0320805061815k6aca9020g285b09da2bcf29c3@mail.gmail.com> <alpine.DEB.1.00.0805071223450.30431@racer> <7viqxqc4gs.fsf@gitster.siamese.dyndns.org> <20080508103436.GB3300@mithlond.arda.local> <46dff0320805100202j54b0922cy50a2c93c4eff1757@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 10 11:15:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JulAe-0004Vw-RP
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 11:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbYEJJOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 05:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbYEJJOX
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 05:14:23 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:49446 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751191AbYEJJOX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 05:14:23 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.rokki.sonera.fi (8.5.014)
        id 482329DB0013F448; Sat, 10 May 2008 12:14:16 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1Jul9h-0001hM-SC; Sat, 10 May 2008 12:14:13 +0300
Content-Disposition: inline
In-Reply-To: <46dff0320805100202j54b0922cy50a2c93c4eff1757@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81659>

Ping Yin wrote (2008-05-10 17:02 +0800):

> On Thu, May 8, 2008 at 6:34 PM, Teemu Likonen <tlikonen@iki.fi> wrote:
> > There are only three words added to the text; additions are written
> > as {+word} in the --color-words output.
> 
> You not only added the three words, but also wrap line at different
> position.

Ah, you're right of course. I'm too focused on just words and language.
I don't mind these "added" LFs on Junio's version but I understand if
someone finds them surprising when color-word-diffing natural languages.
