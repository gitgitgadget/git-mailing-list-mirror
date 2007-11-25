From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Sun, 25 Nov 2007 18:00:19 +0100
Message-ID: <20071125170019.GB25800@diana.vm.bytemark.co.uk>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site> <fi5743$32p$1@ger.gmane.org> <Pine.LNX.4.64.0711230050270.27959@racer.site> <f329bf540711221723g2754ce03r4da6d429c45668c@mail.gmail.com> <Pine.LNX.4.64.0711230149430.27959@racer.site> <20071123205958.GC14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, hanwen@xs4all.nl,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Nov 25 18:00:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwKqe-0008Gx-VU
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 18:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbXKYRAa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2007 12:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753288AbXKYRAa
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 12:00:30 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3638 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbXKYRA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 12:00:29 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IwKqB-0006lF-00; Sun, 25 Nov 2007 17:00:19 +0000
Content-Disposition: inline
In-Reply-To: <20071123205958.GC14735@spearce.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65974>

On 2007-11-23 15:59:58 -0500, Shawn O. Pearce wrote:

> I have been considering creating a "git-gui daemon" process that
> links to libgit.a and can be driven bidirectionally through its
> stdin/stdout. Based on git-fast-export, sorta. But I haven't even
> started it...
>
> But the idea is sort of what Han-Wen wants. Why should I fork
> rev-parse to get a ref value? Or update-ref to change one?

Obviously, something like this would be very valuable for StGit as
well.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
