From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v16 0/7] config commit verbose
Date: Mon, 9 May 2016 10:28:25 -0400
Message-ID: <20160509142825.GB9552@sigill.intra.peff.net>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
 <1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
 <xmqq7ff8b99q.fsf@gitster.mtv.corp.google.com>
 <CAPig+cQO3W4WthHstrVFWziU2RAuNyEzeQwBEyDXG8dghRjECQ@mail.gmail.com>
 <20160506162058.Horde.toAFyoD2uVNcv2x2Ssx_9zt@webmail.informatik.kit.edu>
 <xmqqshxv5hhg.fsf@gitster.mtv.corp.google.com>
 <20160507053209.GA1704@sigill.intra.peff.net>
 <CACBZZX5FHBG8xXc4wKUyW90FianJB1PT2FyByqYVqccb2ef2eg@mail.gmail.com>
 <xmqqy47kxu68.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 16:33:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azmAj-0005Jg-BU
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 16:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbcEIO23 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2016 10:28:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:36281 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751026AbcEIO22 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 10:28:28 -0400
Received: (qmail 13100 invoked by uid 102); 9 May 2016 14:28:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 May 2016 10:28:27 -0400
Received: (qmail 19343 invoked by uid 107); 9 May 2016 14:28:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 May 2016 10:28:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2016 10:28:25 -0400
Content-Disposition: inline
In-Reply-To: <xmqqy47kxu68.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293996>

On Sun, May 08, 2016 at 11:48:31AM -0700, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>=20
> > I.e. I really expect --verbose to be a more verbose version of the
> > primary thing a command is doing, which in the case of "commit
> > --amend" is giving me info I need to modify the commit.
>=20
> That summarises what I wanted to say very well.  Thanks.

I guess I do not really consider the template content to be the primary
thing the command is doing. It is subjective, though. I don't feel
strongly enough to keep discussing it if other people don't agree.

-Peff
