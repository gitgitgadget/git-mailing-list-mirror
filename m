From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH 4/6] user-manual: fix .gitconfig editing examples
Date: Mon, 7 May 2007 11:33:28 +0200
Message-ID: <8aa486160705070233g4e9ed55cx747ab34426c9d369@mail.gmail.com>
References: <20070507064257.GB31269@diana.vm.bytemark.co.uk>
	 <8aa486160705070029l65a7b78cl33c50c4bc194f54b@mail.gmail.com>
	 <20070507092704.GA1106@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J. Bruce Fields" <bfields@citi.umich.edu>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon May 07 11:33:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkzb6-0006l2-Vj
	for gcvg-git@gmane.org; Mon, 07 May 2007 11:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbXEGJdb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 7 May 2007 05:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754125AbXEGJdb
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 05:33:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:45279 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbXEGJda convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2007 05:33:30 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1081537uga
        for <git@vger.kernel.org>; Mon, 07 May 2007 02:33:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XXgA2ps0FZUn0/8XMgNvGpMJ/poxqGRY0BxIBgQfLu7HCbbB8uBdKAN2g00jBOXrajO1xse4woyPrezxM0UaVb6WduRnxOVInK3ini9PGQuhBdiJ1GK9pFFwSCaN31WRx+JsI6owA1IA99bJOlWe+iT6Iez1NuK48g4PEKJDuqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YCoXpkA0ezlcStMQoJ3C/kNXf0UrrrJ4X0cwF8Q2DmfWvKqB6c97H/5cHqXnlL4wxVSM4OYASMPGuv+b4y2yqOJh5dGtxohB1aHjN52jOJ/inJGsNubDhthTbZeGMlQCngSdbK+uUxDw1MZi3N7KZgwHPAjl5xR7suuxB+RL/U8=
Received: by 10.78.193.19 with SMTP id q19mr2179551huf.1178530408898;
        Mon, 07 May 2007 02:33:28 -0700 (PDT)
Received: by 10.78.137.19 with HTTP; Mon, 7 May 2007 02:33:28 -0700 (PDT)
In-Reply-To: <20070507092704.GA1106@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46437>

On 5/7/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-05-07 09:29:23 +0200, Santi B=E9jar wrote:
>
> > I see it OK. Both in the mail and in the repo.
>
> The headers said, among other things,
>
>   Content-Transfer-Encoding: QUOTED-PRINTABLE
>   Content-Type: TEXT/PLAIN; charset=3DISO-8859-1
>

My headers say:

Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

> and the raw text of the body was
>
>   Santi B=3DC3=3DA9jar points out that
>
> Note how the "=E9" in your name is encoded with two bytes.
>
> But if it's not broken in the repository, it's probably nothing to
> worry about. :-)

Or +1 for a git log that uses .mailcap in the commit message :-D

Santi
