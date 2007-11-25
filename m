From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Git Screencast ?
Date: Sun, 25 Nov 2007 17:57:05 +0100
Message-ID: <20071125165705.GA25800@diana.vm.bytemark.co.uk>
References: <fi1a9f$30q$1@ger.gmane.org> <47453C6D.1080403@op5.se> <fi5bet$brl$1@ger.gmane.org> <20071123101426.GA15902@dualtron.vpn.rwth-aachen.de> <20071123205825.GB14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Gilger <heipei@hackvalue.de>,
	Michael Donaghy <mike@mikedonaghy.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Nov 25 17:58:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwKoG-0007TU-Ta
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 17:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357AbXKYQ6A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2007 11:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753286AbXKYQ6A
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 11:58:00 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3631 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205AbXKYQ57 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 11:57:59 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IwKn3-0006kf-00; Sun, 25 Nov 2007 16:57:05 +0000
Content-Disposition: inline
In-Reply-To: <20071123205825.GB14735@spearce.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65973>

On 2007-11-23 15:58:25 -0500, Shawn O. Pearce wrote:

> Actually some users have found that its easier to grok the index by
> using git-gui. You can more directly see the state of update
> actions, and it is fairly easy to stage/unstage individual hunks of
> files through git-gui. Once you get that down then seeking the same
> methods through the command line isn't too difficult,

I spent a good chunk of time getting familiar with the index before
there was a git-gui, and I can only agree: git-gui makes it obvious
how simple the concept of an index really is, in a way the
command-line tools never did. With the command line, you have to
visualize it yourself, which means you have to understand it first;
but with git-gui, it's just drawn on your screen, plain and simple.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
