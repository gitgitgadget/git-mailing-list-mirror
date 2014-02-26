From: Jeff King <peff@peff.net>
Subject: Re: Git in GSoC 2014
Date: Wed, 26 Feb 2014 06:30:28 -0500
Message-ID: <20140226113028.GB3599@sigill.intra.peff.net>
References: <20140225154158.GA9038@sigill.intra.peff.net>
 <CACsJy8Bw7JqokgGt46T7Xivk08F-DS4Dj-j1PWxoStu=cVzo5w@mail.gmail.com>
 <CAFFjANRqKqq_f9SCR4vP3YKUpfk1J2RQdB9G4gnY2OcZivzhXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Vicent =?utf-8?B?TWFydMOt?= <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 12:30:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIch8-0001nc-Ev
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 12:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbaBZLaa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Feb 2014 06:30:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:57315 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751100AbaBZLaa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 06:30:30 -0500
Received: (qmail 12944 invoked by uid 102); 26 Feb 2014 11:30:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Feb 2014 05:30:30 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Feb 2014 06:30:28 -0500
Content-Disposition: inline
In-Reply-To: <CAFFjANRqKqq_f9SCR4vP3YKUpfk1J2RQdB9G4gnY2OcZivzhXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242726>

On Wed, Feb 26, 2014 at 12:24:13PM +0100, Vicent Mart=C3=AD wrote:

> > One thing I noticed after tg/index-v4-format is both libgit2 and jg=
it
> > do not seem to support index v4. So we could add "index v4 support =
on
> > libgit2" to the idea page. It's a relatively small task though once
> > you get a hang on index format.
>=20
> That sounds like a nice task for the Summer of Code too, specially
> with the current effort to make Index v4 more visible in Core Git.

Yeah, I'd agree. Want to write it up?

> I wonder if anybody from JGit would also be interested on mentoring
> for the equivalent task (index v4 on JGit). I've CC'ed Shawn Pearce.

A project that added to both libgit2 and JGit would be cool, but I don'=
t
know if that is asking too much of the student (multiple languages and
projects is going to increase the time spent on non-code friction).

-Peff
