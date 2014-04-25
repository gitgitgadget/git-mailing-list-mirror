From: Jeff King <peff@peff.net>
Subject: Re: What is missing from Git v2.0
Date: Fri, 25 Apr 2014 14:24:59 -0400
Message-ID: <20140425182459.GA29329@sigill.intra.peff.net>
References: <5358bae8ab550_1f7b143d31037@nysa.notmuch>
 <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
 <20140424134106.GA27035@thunk.org>
 <20140424195559.GA1336@luc-arch>
 <CALZVapn0gEHc7t2fjk7YGd2o0yfpGLu0JCgUtdREvROC8_mqXg@mail.gmail.com>
 <5359c9d612298_771c15f72f02a@nysa.notmuch>
 <CAGK7Mr6dss7BF-srQ3SqeZe2hAe9nS07fGe--ka1rvC5hXvbSA@mail.gmail.com>
 <20140425133520.GC11124@thunk.org>
 <535a9f375e196_3984aa530c46@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Theodore Ts'o <tytso@mit.edu>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	Javier Domingo Cansino <javierdo1@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 20:25:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdkoH-0000ZV-1Z
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 20:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206AbaDYSZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 14:25:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:38479 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753832AbaDYSZC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 14:25:02 -0400
Received: (qmail 19908 invoked by uid 102); 25 Apr 2014 18:25:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Apr 2014 13:25:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Apr 2014 14:24:59 -0400
Content-Disposition: inline
In-Reply-To: <535a9f375e196_3984aa530c46@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247088>

On Fri, Apr 25, 2014 at 12:45:27PM -0500, Felipe Contreras wrote:

> When I say literally everbody agreed to move away from the name "index" (except
> Junio and another guy) I mean it. I even composed a list:
> 
> http://article.gmane.org/gmane.comp.version-control.git/233469
> 
> Jeff King, Jonathan Nieder, Matthieu Moy, they all agreed.

With reference to my name, your email says:

  Jeff King:
  "staging area" makes perfect sense

But here's that statement in context[1]:

  So the term "staging area" makes perfect sense to me; it is where we
  collect changes to make a commit. I am willing to accept that does not
  to others (native English speakers or no), and that we may need to
  come up with a better term. But I think just calling it "the stage" is
  even worse; it loses the concept that it is a place for collecting and
  organizing.

In other words, I was saying that the term makes sense to me, and
primarily comparing favorably to a worse proposal. I am not commenting
at all on a plan to change names, which is what you are claiming above.

I do think the term "staging area" is fine, but picking a term is only
step one of a plan. The rest is deciding how to make the change, and
whether it is worth it. I remain undecided on the latter bits. Please
don't quote me out of context in a way that implies that I am decided.

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/168012
