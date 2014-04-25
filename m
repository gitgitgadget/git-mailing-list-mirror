From: Jeff King <peff@peff.net>
Subject: Re: What is missing from Git v2.0
Date: Fri, 25 Apr 2014 15:12:36 -0400
Message-ID: <20140425191236.GA31637@sigill.intra.peff.net>
References: <20140424195559.GA1336@luc-arch>
 <CALZVapn0gEHc7t2fjk7YGd2o0yfpGLu0JCgUtdREvROC8_mqXg@mail.gmail.com>
 <5359c9d612298_771c15f72f02a@nysa.notmuch>
 <CAGK7Mr6dss7BF-srQ3SqeZe2hAe9nS07fGe--ka1rvC5hXvbSA@mail.gmail.com>
 <20140425133520.GC11124@thunk.org>
 <535a9f375e196_3984aa530c46@nysa.notmuch>
 <20140425182459.GA29329@sigill.intra.peff.net>
 <535aa905cd59c_44cee6530ccb@nysa.notmuch>
 <20140425185731.GA31454@sigill.intra.peff.net>
 <535ab03711d81_471d7d930822@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Theodore Ts'o <tytso@mit.edu>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	Javier Domingo Cansino <javierdo1@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 21:12:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdlYG-0002nG-3Z
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 21:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692AbaDYTMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 15:12:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:38565 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751191AbaDYTMi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 15:12:38 -0400
Received: (qmail 23907 invoked by uid 102); 25 Apr 2014 19:12:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Apr 2014 14:12:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Apr 2014 15:12:36 -0400
Content-Disposition: inline
In-Reply-To: <535ab03711d81_471d7d930822@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247108>

On Fri, Apr 25, 2014 at 01:57:59PM -0500, Felipe Contreras wrote:

> > Maybe I was not clear in my response, so let me try again. I do _not_
> > necessarily agree that we need to move away from the name index.
> 
> So you agree that "the index" is a bad name, and you agree "staging area" is a
> better name, yet you don't agree we should move away from the term "index"?

I don't agree that "the index" is a "bad" name, because that implies
some objective level of "bad".

I do think the name "staging area" is fine, and I think it may even be
better than "index", if we were picking a name out of the blue.

I am undecided on whether we should move away from the term "index". The
way you have phrased it seems like you are trying to create a logical
contradiction: A is bad, B is good, therefore we should move from A to
B. But that neglects the cost of moving.

Frankly, I am not that interested in discussing it with you. I _am_
interested in you not using my name to claim that I believe things I do
not.

-Peff
