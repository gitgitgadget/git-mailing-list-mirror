From: Ping Yin <pkufranky@gmail.com>
Subject: Re: log --graph --first-parent weirdness
Date: Thu, 5 Jun 2008 09:37:19 +0800
Organization: (kooxoo Corp.)
Message-ID: <20080605013719.GA1433@kooxoo235>
References: <20080604150042.GA3038@mithlond.arda.local> <7vmym1xgy4.fsf@gitster.siamese.dyndns.org> <20080604173820.GA3038@mithlond.arda.local> <7v1w3dxeh9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Adam Simpkins <adam@adamsimpkins.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 03:38:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K44Qv-00068M-NR
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 03:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404AbYFEBh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 21:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754722AbYFEBh2
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 21:37:28 -0400
Received: from mail.qikoo.org ([60.28.205.235]:59966 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752327AbYFEBh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 21:37:27 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 8774C470AE; Thu,  5 Jun 2008 09:37:19 +0800 (CST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>,
	Adam Simpkins <adam@adamsimpkins.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v1w3dxeh9.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83843>

* Junio C Hamano <gitster@pobox.com> [2008-06-04 11:05:38 -0700]:

> And if the graph actually draws the real ancestry graph (i.e. without
> --first-parent), the lines visually show which is merge and which is not,
> so the "M" gets very distracting.
> 
> I'd really suggest changing the "M" and use "*" everywhere.

I vote for this change.
