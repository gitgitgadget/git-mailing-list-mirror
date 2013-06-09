From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 14:45:54 -0400
Message-ID: <20130609184553.GG810@sigill.intra.peff.net>
References: <20130608164902.GA3109@elie.Belkin>
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
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:46:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulkcs-0006Me-0o
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983Ab3FISp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 14:45:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:37501 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868Ab3FISp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 14:45:57 -0400
Received: (qmail 20575 invoked by uid 102); 9 Jun 2013 18:46:47 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 09 Jun 2013 13:46:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jun 2013 14:45:54 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0kkhDOSSdF=E4PvO24hg++_FpP3YFaGRD3yq80XG0TRJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227093>

On Mon, Jun 10, 2013 at 12:02:11AM +0530, Ramkumar Ramachandra wrote:

> This is all very good, Jeff.  Various people have expressed what's
> wrong with fc's "demeanour", "tone", and "style of discussion" in
> various different ways at various different points in time.  This goes
> on and on and on with no end in sight. WHAT do we do?

My advice would be to ignore him when the discussion proceeds in an
unproductive direction.

But I never wanted to tell other people what to do with respect to
Felipe. My point was to express public agreement with Jonathan, and show
that individual members of the community may be less interested in
helping you if you behave in certain ways. At this point, I do not have
any hope of impacting Felipe's behavior, but I thought it might be
demonstrative to other list members.  We do not have an explicit code of
conduct on the list, but it is not as if behavior is without
consequences. If you are not easy to work with, people will get tired of
dealing with you eventually[1].

-Peff

[1] Or maybe not. Maybe there are enough people interested in what
    Felipe has to say that he will continue to get review. I even try to
    review his patches myself when there is something factually and
    obviously wrong to point out, and it won't suck me into a
    time-wasting argument that goes nowhere.

    But the point is that each individual can make the choice
    themselves, and then the problem is solved for them.
