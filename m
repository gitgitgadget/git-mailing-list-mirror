From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [RFH PATCH] Teach the emacs git mode about core.excludesfile
Date: Tue, 31 Jul 2007 21:57:00 +0200
Message-ID: <20070731195700.GC28331@diana.vm.bytemark.co.uk>
References: <20070731011100.23561.27554.stgit@yoghurt> <87abtcvozz.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 21:57:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFxqG-0002q9-NB
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 21:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919AbXGaT5O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 15:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754810AbXGaT5N
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 15:57:13 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1634 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606AbXGaT5N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 15:57:13 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IFxq0-0007TO-00; Tue, 31 Jul 2007 20:57:00 +0100
Content-Disposition: inline
In-Reply-To: <87abtcvozz.fsf@wine.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54371>

On 2007-07-31 12:36:32 +0200, Alexandre Julliard wrote:

> I would do it this way:
>
> From: Alexandre Julliard <julliard@winehq.org>
> Date: Tue, 31 Jul 2007 12:19:05 +0200
> Subject: [PATCH] git.el: Take into account the core.excludesfile conf=
ig option.
>
> Also don't require .git/info/exclude to exist in order to list unknow=
n
> files.
>
> Signed-off-by: Alexandre Julliard <julliard@winehq.org>

Acked-by: Karl Hasselstr=F6m <kha@treskal.com>

Works beautifully, thanks.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
