From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [doc] User Manual Suggestion
Date: Mon, 27 Apr 2009 00:42:30 +0200
Message-ID: <20090426224230.GB12338@atjola.homenet>
References: <m24owgqy0j.fsf@boostpro.com> <200904240051.46233.johan@herland.net> <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com> <200904242230.13239.johan@herland.net> <alpine.LNX.2.00.0904241655090.2147@iabervon.org> <20090424213848.GA14493@coredump.intra.peff.net> <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com> <20090424231632.GB10155@atjola.homenet> <b4087cc50904241701jb78ce50m122fef475b0f1de7@mail.gmail.com> <B8EE4B7B-CBCE-47D6-97B2-2F505A218B58@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>, Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@fieldses.org>
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 10:37:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyD5F-0002Cy-N5
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 00:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbZDZWmv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2009 18:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752753AbZDZWmv
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 18:42:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:37859 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751924AbZDZWmu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 18:42:50 -0400
Received: (qmail invoked by alias); 26 Apr 2009 22:42:46 -0000
Received: from i59F5A916.versanet.de (EHLO atjola.local) [89.245.169.22]
  by mail.gmx.net (mp067) with SMTP; 27 Apr 2009 00:42:46 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/1kCIX/db10Db2bQErbA+npi1fWP+Mh9Dc0WPJ/k
	ryPAXZ6EYX3Mxe
Content-Disposition: inline
In-Reply-To: <B8EE4B7B-CBCE-47D6-97B2-2F505A218B58@boostpro.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117610>

On 2009.04.24 20:48:57 -0400, David Abrahams wrote:
>
> On Apr 24, 2009, at 8:01 PM, Michael Witten wrote:
>
>>> What's wrong with just calling the object name "object name"?
>>
>> What's wrong with calling the object address "object address"?
>
> Neither captures the connection to the object's contents.  I think =20
> "value ID" would be closer, but it's probably too horrible.

I think I asked this in another mail, but I'm quite tired, so just to
make sure: What do you mean by "value"? I might be weird (I'm not a
native speaker, so I probably make funny and wrong connotations from
time to time), but while I can accept "content" to include the type and
size of the object, the term "value" makes me want to exclude those
pieces of meta data. So "value" somehow feels wrong to me, as the hash
covers those two fields.

Bj=F6rn
