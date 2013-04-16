From: Jeff King <peff@peff.net>
Subject: Re: Ensimag students projects, version 2013
Date: Mon, 15 Apr 2013 20:58:37 -0400
Message-ID: <20130416005836.GC14995@sigill.intra.peff.net>
References: <vpqobdg515m.fsf@grenoble-inp.fr>
 <CALkWK0nFB1dzmp6yC9XS4ADmWf9tfQYtsSH0K1u0dtBWT0CRNw@mail.gmail.com>
 <vpqzjwzkb4e.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	git <git@vger.kernel.org>, Phil Hord <phil.hord@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 16 02:58:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URuER-0003QB-Qv
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 02:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934813Ab3DPA6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 20:58:44 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47320 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934340Ab3DPA6n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 20:58:43 -0400
Received: (qmail 31607 invoked by uid 107); 16 Apr 2013 01:00:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Apr 2013 21:00:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Apr 2013 20:58:37 -0400
Content-Disposition: inline
In-Reply-To: <vpqzjwzkb4e.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221340>

On Mon, Apr 15, 2013 at 06:32:49PM +0200, Matthieu Moy wrote:

> > - Create an advice.ui (like color.ui) to turn off all advice.  I don't
> > need advice.
> 
> I tend to agree with you, but the idea has explicitly been rejected in
> the past. The problem with an option like this is that it would also
> disable the advices that may be added in the future. By letting people
> disable the advices one by one, people see new advices as they arrive.
> You may think of it like "do not show this message again" tickboxes in
> some graphical user interfaces.

FWIW, I do not think it was so much rejected as that I had initially
planned to implement it, then decided against it. Mostly because I
wanted to actually get annoyed with each piece of advice before
disabling it. Because sometimes the right answer is actually "make the
advice better".

But I do not mind somebody adding it if it is a burning desire.

-Peff
