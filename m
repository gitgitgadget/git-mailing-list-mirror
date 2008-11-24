From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Display (empty) when appropriate for the goto command
Date: Mon, 24 Nov 2008 12:19:09 +0100
Message-ID: <20081124111909.GB31986@diana.vm.bytemark.co.uk>
References: <20081123212318.9835.53505.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 12:20:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4ZUS-00045Q-42
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 12:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbYKXLTN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Nov 2008 06:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbYKXLTN
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 06:19:13 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1120 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbYKXLTM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 06:19:12 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1L4ZTB-0008Rb-00; Mon, 24 Nov 2008 11:19:09 +0000
Content-Disposition: inline
In-Reply-To: <20081123212318.9835.53505.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101601>

On 2008-11-23 21:23:18 +0000, Catalin Marinas wrote:

> This is a fix for bug #11810. The original implementation of goto
> used to display (empty patch) when a patch became empty during a
> push + merge operation. This patch adds this feature again.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>

Acked-by: Karl Hasselstr=F6m <kha@treskal.com>

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
