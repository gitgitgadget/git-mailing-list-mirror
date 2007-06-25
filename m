From: Nanako Shiraishi <nanako3@bluebottle.com>
Subject: Re: qgit: Annotate hundreds of files at terrific speed ;-)
Date: Mon, 25 Jun 2007 15:35:21 +0900
Message-ID: <200706250638.l5P6crkR026564@mi1.bluebottle.com>
References: <e5bfff550706242259s143fe874mf82736426e94ecba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 08:39:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2iE1-0002zs-GM
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 08:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754552AbXFYGiz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 25 Jun 2007 02:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754276AbXFYGiz
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 02:38:55 -0400
Received: from mi1.bluebottle.com ([206.188.25.14]:43738 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbXFYGiy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 02:38:54 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l5P6crkR026564
	for <git@vger.kernel.org>; Sun, 24 Jun 2007 23:38:53 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=pFOxgkk+2BJAVGNF//w3SJ/brLu7Me7z4l+r/WAsAlOuHRo/iTv0YeItm+73H1TGP
	QdTbHxrCgYsKPi3rPmgQK5tSSOTs2RIRoT3CermC7R/D8fcM4LoOJW/4U03VkSY
Received: from nanako3.mail.bluebottle.com (81-21-243-20.televork.ee [81.21.243.20])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l5P6chx1006594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 24 Jun 2007 23:38:52 -0700
In-Reply-To: <e5bfff550706242259s143fe874mf82736426e94ecba@mail.gmail.com>
X-Trusted-Delivery: <6e3cc5c6ba5cf5296d71cb1702074b70>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50864>


>> Marco Costalba <mcostalba@gmail.com> wrote:
>
> - filtering, ie selecting with the mouse some lines and getting a
> subset of the file history that modified at least one of that lines i=
s
> not possible.

I often use "git blame -L'/regexp/,/regexp/'" (you can use line
numbers there, too).  Is this different from what you talk above?

--=20
=E3=81=97=E3=82=89=E3=81=84=E3=81=97 =E3=81=AA=E3=81=AA=E3=81=93 http:/=
/ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Get a free email address with REAL anti-spam protection.
http://www.bluebottle.com
