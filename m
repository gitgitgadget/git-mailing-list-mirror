From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGIT experimental branches updated
Date: Mon, 3 Sep 2007 11:01:21 +0200
Message-ID: <20070903090121.GA5051@diana.vm.bytemark.co.uk>
References: <20070903002029.GA31957@diana.vm.bytemark.co.uk> <b0943d9e0709030129y2ced4f61jaf42c07a7798f47a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 11:02:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS7ov-0000kT-L9
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 11:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687AbXICJB1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 3 Sep 2007 05:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753645AbXICJB1
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 05:01:27 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1223 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542AbXICJB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 05:01:26 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IS7o9-0001mA-00; Mon, 03 Sep 2007 10:01:21 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0709030129y2ced4f61jaf42c07a7798f47a@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57455>

On 2007-09-03 09:29:18 +0100, Catalin Marinas wrote:

> BTW, would an extension to 'stg import' to import patches from
> mailing lists (NNTP or maybe just mbox) directly be useful? There is
> support for mbox importing anyway and it would need a procmail
> filter to generate the mbox and just a regex filtering in 'import'
> to apply the StGIT patches only.

I don't think I'd use that function -- it's very convenient to just
manually copy the patch mails I want to a separate mbox, which I then
pipe to git-am. (Yes, I know, I should be using "stg import", but "stg
assimilate" is just too useful.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
