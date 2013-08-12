From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [RFC PATCH] During a shallow fetch, prevent sending over
 unneeded objects
Date: Mon, 12 Aug 2013 10:02:03 +0200
Message-ID: <20130812080203.GK10217@login.drsnuggles.stderr.nl>
References: <20130711220127.GK10217@login.drsnuggles.stderr.nl>
 <CACsJy8CP6pGRwEn6H=cbKxTMuOjzAF3=Qh8qsLbJaw6feK3NMw@mail.gmail.com>
 <7vfvukbrqh.fsf@alter.siamese.dyndns.org>
 <CACsJy8BahoGcDcLjSaHA-62_KQE2wD-p5oeJOOA4nk8ZRfXrEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 10:02:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8n4x-0004dd-4v
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 10:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab3HLICL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 04:02:11 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:38909 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731Ab3HLICJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 04:02:09 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1V8n4l-0005AK-Gy; Mon, 12 Aug 2013 10:02:04 +0200
Received: (nullmailer pid 19858 invoked by uid 1000);
	Mon, 12 Aug 2013 08:02:03 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACsJy8BahoGcDcLjSaHA-62_KQE2wD-p5oeJOOA4nk8ZRfXrEA@mail.gmail.com>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 AWL                    AWL: From: address is in the auto white-list
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232173>

Hi Duy,

> OK. Mathijs, do you want make a patch for it?
I'm willing, but:
 - I don't understand the code and all of your comments well enough yet
   to start coding right away (though I haven't actually invested enough
   time in this yet, either).
 - I'll be on vacation for the next two weeks.

When I get back, I'll re-read this thread properly and reply where I
don't follow it. Feel free to continue discussing the plan until then,
of course :-)

Gr.

Matthijs
