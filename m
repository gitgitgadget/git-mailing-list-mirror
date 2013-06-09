From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 21:25:06 +0200
Message-ID: <87zjuz84tp.fsf@hexa.v.cablecom.net>
References: <CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
	<CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
	<20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609052624.GB561@sigill.intra.peff.net>
	<CALkWK0mu2_9M5aTczcEkv37eLaAg5_mGDZ_W9nqQFoesB4wc3g@mail.gmail.com>
	<20130609180437.GB810@sigill.intra.peff.net>
	<CALkWK0kkhDOSSdF=E4PvO24hg++_FpP3YFaGRD3yq80XG0TRJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 21:25:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllEs-0002Q6-39
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984Ab3FITZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:25:10 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:41115 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562Ab3FITZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:25:09 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 9 Jun
 2013 21:24:52 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 9 Jun
 2013 21:25:06 +0200
In-Reply-To: <CALkWK0kkhDOSSdF=E4PvO24hg++_FpP3YFaGRD3yq80XG0TRJA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 10 Jun 2013 00:02:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227108>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Jeff King wrote:
>> I actually think word choice and politeness is only a small part of it,
>> and one that I live without.  It is not just _how_ something is said,
>> but _what_ is said. And sometimes what is said does not lead in a
>> productive direction. I found Thomas's comment here:
>>
>>   http://article.gmane.org/gmane.comp.version-control.git/227053
>>
>> sums up the core of many of the conflicts I've seen on the list.
>
> This is all very good, Jeff.  Various people have expressed what's
> wrong with fc's "demeanour", "tone", and "style of discussion" in
> various different ways at various different points in time.  This goes
> on and on and on with no end in sight. WHAT do we do?
>
> I'll be frank: I'm a pragmatic person, and I want to see work.
> Despite all this mess, who has shown me the most number of patches
> with some direction?  Felipe.  Who gets the most number of patches
> into git.git, by far?  Felipe.  And who is wasting time theorizing
> about what's wrong with Felipe in various ways?  Everyone else.

At what cost?

The arguments arise to a large degree from attempting to review his
work.  Not doing so is not an option, see e.g.:

  http://article.gmane.org/gmane.comp.version-control.git/223279
  http://article.gmane.org/gmane.comp.version-control.git/225969
  http://article.gmane.org/gmane.comp.version-control.git/226125

And that's not even counting the part of the argument that arises purely
from deliberate flaunting of the project's guidelines.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
