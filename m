From: Jeff King <peff@peff.net>
Subject: Re: Git in GSoC 2014
Date: Wed, 26 Feb 2014 06:29:07 -0500
Message-ID: <20140226112907.GA3599@sigill.intra.peff.net>
References: <20140225154158.GA9038@sigill.intra.peff.net>
 <530CCFB0.5050406@alum.mit.edu>
 <20140226102350.GB25711@sigill.intra.peff.net>
 <530DC4D1.4060301@alum.mit.edu>
 <CAFFjANTCU-OkydggYGy9tTJqx=TkWoVi2gJge4LUUkKcdB-eZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git <git@vger.kernel.org>
To: Vicent =?utf-8?B?TWFydMOt?= <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 12:29:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIcfq-00041H-LJ
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 12:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbaBZL3K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Feb 2014 06:29:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:57307 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751140AbaBZL3J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 06:29:09 -0500
Received: (qmail 12823 invoked by uid 102); 26 Feb 2014 11:29:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Feb 2014 05:29:09 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Feb 2014 06:29:07 -0500
Content-Disposition: inline
In-Reply-To: <CAFFjANTCU-OkydggYGy9tTJqx=TkWoVi2gJge4LUUkKcdB-eZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242725>

On Wed, Feb 26, 2014 at 12:25:36PM +0100, Vicent Mart=C3=AD wrote:

> On Wed, Feb 26, 2014 at 11:41 AM, Michael Haggerty <mhagger@alum.mit.=
edu> wrote:
> > Since time is short, I already started on this.  I wrote a first dr=
aft
> > of an introduction for the students.  I also started looking for
> > microprojects.  I started going through our source files alphabetic=
ally,
> > and have already found six suggestions by "bundle.c", so I don't th=
ink
> > there will be a problem finding enough tiny things to do.
>=20
> Note that for projects that are either libgit2-centric or mix Core Gi=
t
> and libgit2, it would be worth it to the students to submit a pull
> request on libgit2 (or ideally, on both projects, although that's
> going to be hard) in order to make themselves familiar with the code
> base.

Yeah, that makes sense. I think if students are thinking primarily abou=
t
one of the libgit2 projects, they should focus on interacting with that
community. Interacting with the mailing list is good, too, but I don't
see a need to do a patch for both.

Can you come up with a short list of micro-projects for libgit2, simila=
r
to what Michael did for Git?

-Peff
