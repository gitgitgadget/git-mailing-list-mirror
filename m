From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Autosign newly created patches
Date: Sun, 14 Sep 2008 10:37:28 +0200
Message-ID: <20080914083728.GB30664@diana.vm.bytemark.co.uk>
References: <20080912215515.10270.32667.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 10:16:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KemmW-0003IG-IS
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 10:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbYINIPY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 04:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbYINIPX
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 04:15:23 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1411 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbYINIPW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 04:15:22 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Ken6n-00084j-00; Sun, 14 Sep 2008 09:37:29 +0100
Content-Disposition: inline
In-Reply-To: <20080912215515.10270.32667.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95823>

On 2008-09-12 22:55:56 +0100, Catalin Marinas wrote:

> This patch adds the autosign configuration variable which is checked
> by the "new" command to automatically sign the patch message.

Sounds useful. I have a sign-off command in my .emacs, but I expect
this would be useful for those who don't.

> BTW, what happened to the patchdescr.tmpl file? It doesn't seem to
> be used anymore, however one can save a template file

I don't know. I don't use it myself, so it's perfectly possible that
I've broken it without noticing, seeing as there is no test suite
coverage ...

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
