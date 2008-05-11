From: Ping Yin <pkufranky@gmail.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words configurable
Date: Sun, 11 May 2008 21:27:46 +0800
Organization: (kooxoo Corp.)
Message-ID: <20080511132746.GA26550@kooxoo235>
References: <7vprs1ny5e.fsf@gitster.siamese.dyndns.org> <46dff0320805050510t3bc5fd0eq44e0d58d1bb57629@mail.gmail.com> <46dff0320805051740o65eee07eqc7073e4fa7996277@mail.gmail.com> <alpine.DEB.1.00.0805060954470.30431@racer> <46dff0320805061815k6aca9020g285b09da2bcf29c3@mail.gmail.com> <alpine.DEB.1.00.0805071223450.30431@racer> <7viqxqc4gs.fsf@gitster.siamese.dyndns.org> <20080508103436.GB3300@mithlond.arda.local> <46dff0320805100202j54b0922cy50a2c93c4eff1757@mail.gmail.com> <46dff0320805110616s6df19657r1e4c80634267fd81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 15:28:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvBbV-0002yG-L7
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 15:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbYEKN1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 09:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbYEKN1v
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 09:27:51 -0400
Received: from mail.qikoo.org ([60.28.205.235]:42502 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751528AbYEKN1u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 09:27:50 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id E9A86470AE; Sun, 11 May 2008 21:27:46 +0800 (CST)
Mail-Followup-To: Ping Yin <pkufranky@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46dff0320805110616s6df19657r1e4c80634267fd81@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81771>

* Ping Yin <pkufranky@gmail.com> [2008-05-11 21:16:11 +0800]:

> 
> With following patch, the diff output becomes (i don't know which one is better)
> 
> OpenOffice.org has {+a }user setting for defining the minimum length for
> words to be hyphenated. By default the word length is counted from the
> whole word - even for compound words. For example the {compound +}word
> 'elokuvalippu' is {+considered }12 characters long. The word will be
> hyphenated like

The above two lines are auto wrapped by gmail client, should be

'elokuvalippu' is {+considered }12 characters long. The word will be hyphenated like

Sorry for that.

> 
> -- 
> Ping Yin
