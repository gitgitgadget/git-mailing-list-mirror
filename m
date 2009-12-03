From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pull: clarify advice for the unconfigured error case
Date: Wed, 2 Dec 2009 20:43:15 -0500
Message-ID: <20091203014315.GA12061@coredump.intra.peff.net>
References: <1257968052.26362.155.camel@heerbeest>
 <AC99BA30-A36D-4798-8E7D-9D69EFE99D55@dbservice.com>
 <1258035449.26362.273.camel@heerbeest>
 <20091112155310.7836c388@perceptron>
 <20091112150626.GA24848@coredump.intra.peff.net>
 <20091112170814.1858aba4@perceptron>
 <20091113040754.GA3255@progeny.tock>
 <20091127141704.GA24080@progeny.tock>
 <7vk4x57z4e.fsf@alter.siamese.dyndns.org>
 <20091203012535.GA16259@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Jan Nieuwenhuizen <janneke-list@xs4all.nl>,
	Tomas Carnecky <tom@dbservice.com>,
	git list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 02:43:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NG0jC-0003vJ-SC
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 02:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbZLCBnJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Dec 2009 20:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752562AbZLCBnJ
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 20:43:09 -0500
Received: from peff.net ([208.65.91.99]:40543 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036AbZLCBnI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 20:43:08 -0500
Received: (qmail 29011 invoked by uid 107); 3 Dec 2009 01:47:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 02 Dec 2009 20:47:43 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Dec 2009 20:43:15 -0500
Content-Disposition: inline
In-Reply-To: <20091203012535.GA16259@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134424>

On Wed, Dec 02, 2009 at 07:26:14PM -0600, Jonathan Nieder wrote:

> > and does the lack of follow-up mean everybody involved in the discu=
ssion
> > is happy with this version?
>=20
> I=E2=80=99m not sure.  I know I like it. :-)
>=20
> I was the only one with nitpicks about the wording (sorry).  Re
> whether to use configuration file syntax or a 'git config' command
> line snippet, it seemed like there was some consensus once it was
> clear that the user would have to modify the lines anyway to fill in
> the right values.  But others can speak up if this seems wrong.

Yeah, that was my main complaint, and I withdrew it after getting a
clue. :) I gave the patch another quick look, and I think it is fine.

-Peff
