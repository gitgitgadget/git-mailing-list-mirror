From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] git.el: Support for incremental status updates.
Date: Tue, 31 Jul 2007 21:58:35 +0200
Message-ID: <20070731195835.GD28331@diana.vm.bytemark.co.uk>
References: <87sl7ekt40.fsf@wine.dyndns.org> <20070730232226.GA2413@diana.vm.bytemark.co.uk> <87k5shudz7.fsf@morpheus.local> <20070731111438.GA17903@diana.vm.bytemark.co.uk> <874pjktnoe.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 21:58:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFxrk-0003OT-Lz
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 21:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810AbXGaT6q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 15:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754802AbXGaT6p
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 15:58:45 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4258 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728AbXGaT6p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 15:58:45 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IFxrX-0007Tw-00; Tue, 31 Jul 2007 20:58:35 +0100
Content-Disposition: inline
In-Reply-To: <874pjktnoe.fsf@wine.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54372>

On 2007-07-31 20:48:01 +0200, Alexandre Julliard wrote:

> Yes, it's a new function. Something like this should work:
>
> From: Alexandre Julliard <julliard@winehq.org>
> Date: Tue, 31 Jul 2007 20:45:53 +0200
> Subject: [PATCH] git.el: Avoid using ewoc-set-data for compatibility =
with Emacs 21.
>
> Signed-off-by: Alexandre Julliard <julliard@winehq.org>

Acked-by: Karl Hasselstr=F6m <kha@treskal.com>

I've only tested it on emacs 21, though.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
