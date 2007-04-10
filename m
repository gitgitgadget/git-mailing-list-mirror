From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [RFC/PATCH] Optimized PowerPC SHA1 generation for Darwin (OS X)
Date: Tue, 10 Apr 2007 11:48:01 +0200
Message-ID: <20070410094801.GA6148@diana.vm.bytemark.co.uk>
References: <20070406234826.GG3854@regex.yaph.org> <Pine.LNX.4.64.0704061830350.6730@woody.linux-foundation.org> <20070408200939.GL3854@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Arjen Laarhoven <arjen@yaph.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 14:38:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbCxh-00037U-56
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 11:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281AbXDJJsZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 10 Apr 2007 05:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753314AbXDJJsZ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 05:48:25 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1611 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbXDJJsY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 05:48:24 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HbCxF-0001sN-00; Tue, 10 Apr 2007 10:48:01 +0100
Mail-Followup-To: Arjen Laarhoven <arjen@yaph.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070408200939.GL3854@regex.yaph.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44121>

On 2007-04-08 22:09:39 +0200, Arjen Laarhoven wrote:

>  ppc/{sha1ppc.S =3D> sha1ppc.in.S} |  110 +++++++++++++++++++--------=
-----------

Wouldn't it be prettier if this filename was .S.in instead of .in.S?
Additional file suffixes are usually added at the end (e.g. .tar.gz),
and it makes more sense too.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
