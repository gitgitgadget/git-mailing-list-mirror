From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Git in a Nutshell guide
Date: Mon, 19 Nov 2007 17:23:05 -0500
Message-ID: <20071119222305.GE22293@fieldses.org>
References: <1195477504.8093.15.camel@localhost> <8c5c35580711190845s71a4880ek4ab28170d277e0e6@mail.gmail.com> <E983072E-E9FD-499E-A418-B630A275C4F3@lrde.epita.fr> <8c5c35580711190904v5975e81k3d515dc44fee9c21@mail.gmail.com> <25CF3422-A236-46CE-B243-3F01117B7743@lrde.epita.fr> <vpqtznirtlk.fsf@bauges.imag.fr> <60891A14-1D6E-4114-ACEF-4C981D326CFA@lrde.epita.fr> <vpq63zxq5s2.fsf@bauges.imag.fr> <0E0AA90A-2282-4AFE-8B94-EA0E35B57D65@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Lars Hjemli <hjemli@gmail.com>,
	Jonas Juselius <jonas.juselius@chem.uit.no>,
	git@vger.kernel.org
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Nov 19 23:23:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuF1y-0006BR-Dy
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 23:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381AbXKSWXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 17:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752030AbXKSWXX
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 17:23:23 -0500
Received: from mail.fieldses.org ([66.93.2.214]:49163 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753520AbXKSWXW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 17:23:22 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IuF1F-0000W6-3r; Mon, 19 Nov 2007 17:23:05 -0500
Content-Disposition: inline
In-Reply-To: <0E0AA90A-2282-4AFE-8B94-EA0E35B57D65@lrde.epita.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65508>

On Mon, Nov 19, 2007 at 10:51:35PM +0100, Benoit Sigoure wrote:
> On Nov 19, 2007, at 10:33 PM, Matthieu Moy wrote:
>
>> Benoit Sigoure <tsuna@lrde.epita.fr> writes:
>>
>>> No please stop adding links from on man page to another.  If you read
>>> man git-reflog, you surely want to learn the HEAD@{N} syntax and see
>>> practical uses cases.
>>
>> I don't understand your point.
>>
>> Yes, if I read man git-reflog, I do surely want to learn HEAD@{N}
>> syntax, but that is _precisely_ what my patch does.
>
> By telling you to read another man page which is annoying and a recurring 
> complaint.

Are we looking at the same patch?  It both gives examples of the syntax
*and* refers to another page.  I thought it was the lack of the former,
rather than the presence of the latter, that was the recurring
complaint....

--b.
