From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] [import-tars] fix importing of subversion tars
Date: Tue, 24 Apr 2007 14:34:57 +0200
Message-ID: <20070424123457.GA27766@diana.vm.bytemark.co.uk>
References: <20070424073907.GA22121@diana.vm.bytemark.co.uk> <20070424084037.GA8906@informatik.uni-freiburg.de> <20070424100924.GB23811@diana.vm.bytemark.co.uk> <20070424115104.GA14986@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Michael Loeffler <zvpunry@zvpunry.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 14:35:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgKEq-0007Z2-2p
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 14:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161742AbXDXMfQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Apr 2007 08:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161744AbXDXMfQ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 08:35:16 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1809 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161742AbXDXMfO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 08:35:14 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HgKET-0007F1-00; Tue, 24 Apr 2007 13:34:57 +0100
Content-Disposition: inline
In-Reply-To: <20070424115104.GA14986@informatik.uni-freiburg.de>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45445>

On 2007-04-24 13:51:04 +0200, Uwe Kleine-K=F6nig wrote:

> add a / between the prefix and name fields of the tar archive if
> prefix is non-empty.
>
> Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.d=
e>

Acked-by: Karl Hasselstr=F6m <kha@treskal.com>

This solves my problem with the Subversion tarballs. Thanks!

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
