From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 18:03:46 +0200
Message-ID: <20080717160346.GA26862@diana.vm.bytemark.co.uk>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <7vmykhpn6z.fsf@gitster.siamese.dyndns.org> <20080717155538.GE11759@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 18:06:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJVzb-0002K2-ED
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 18:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757505AbYGQQFF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2008 12:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757486AbYGQQFF
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 12:05:05 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1538 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756410AbYGQQFE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 12:05:04 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KJVxK-00074U-00; Thu, 17 Jul 2008 17:03:46 +0100
Content-Disposition: inline
In-Reply-To: <20080717155538.GE11759@fieldses.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88869>

On 2008-07-17 11:55:38 -0400, J. Bruce Fields wrote:

> Is there a way to commit the contents of a tarball without using
> plumbing?

contrib/fast-import/import-tars.perl

It currently lacks a bit in flexibility, IIRC, but it does its job
well.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
