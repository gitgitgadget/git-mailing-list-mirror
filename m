From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 4/6] user-manual: fix .gitconfig editing examples
Date: Mon, 7 May 2007 11:27:04 +0200
Message-ID: <20070507092704.GA1106@diana.vm.bytemark.co.uk>
References: <20070507064257.GB31269@diana.vm.bytemark.co.uk> <8aa486160705070029l65a7b78cl33c50c4bc194f54b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J. Bruce Fields" <bfields@citi.umich.edu>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 11:28:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkzVk-0005n2-Fr
	for gcvg-git@gmane.org; Mon, 07 May 2007 11:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbXEGJ1M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 7 May 2007 05:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754227AbXEGJ1M
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 05:27:12 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4091 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183AbXEGJ1L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 05:27:11 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HkzUm-0000KL-00; Mon, 07 May 2007 10:27:04 +0100
Content-Disposition: inline
In-Reply-To: <8aa486160705070029l65a7b78cl33c50c4bc194f54b@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46436>

On 2007-05-07 09:29:23 +0200, Santi B=E9jar wrote:

> I see it OK. Both in the mail and in the repo.

The headers said, among other things,

  Content-Transfer-Encoding: QUOTED-PRINTABLE
  Content-Type: TEXT/PLAIN; charset=3DISO-8859-1

and the raw text of the body was

  Santi B=3DC3=3DA9jar points out that

Note how the "=E9" in your name is encoded with two bytes.

But if it's not broken in the repository, it's probably nothing to
worry about. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
