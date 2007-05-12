From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH v2] Document patch syntax.
Date: Sat, 12 May 2007 22:43:52 +0200
Message-ID: <20070512204352.GE28039@diana.vm.bytemark.co.uk>
References: <20070512185919.26101.3956.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat May 12 22:44:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmyRb-0006gJ-UI
	for gcvg-git@gmane.org; Sat, 12 May 2007 22:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755903AbXELUnz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 12 May 2007 16:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753689AbXELUnz
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 16:43:55 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2282 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755705AbXELUnz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 16:43:55 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HmyRU-000079-00; Sat, 12 May 2007 21:43:52 +0100
Content-Disposition: inline
In-Reply-To: <20070512185919.26101.3956.stgit@gandelf.nowhere.earth>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47093>

On 2007-05-12 20:59:30 +0200, Yann Dirson wrote:

> Acked-by: Karl Hasselstr?m <kha@treskal.com>

Your mail headers say

  Content-Type:   text/plain; charset=3Dutf-8
  Content-Transfer-Encoding: QUOTED-PRINTABLE

but the body contains

  Acked-by: Karl Hasselstr=3DF6m <kha@treskal.com>

which is QP-encoded latin1, not utf8. (It's an illegal utf8 byte
sequence, which is why it showed up as a question mark in my MUA.)

> +Patches in the current stack are just refered to by their name.  Som=
e

s/refered/referred/. I missed this the first time -- sorry.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
