From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH v2] Document patch syntax.
Date: Sun, 13 May 2007 15:58:05 +0200
Message-ID: <20070513135805.GA8635@diana.vm.bytemark.co.uk>
References: <20070512185919.26101.3956.stgit@gandelf.nowhere.earth> <20070512204352.GE28039@diana.vm.bytemark.co.uk> <20070513130354.GG16903@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun May 13 15:58:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnEad-0000c0-Ip
	for gcvg-git@gmane.org; Sun, 13 May 2007 15:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757230AbXEMN6Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 13 May 2007 09:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757918AbXEMN6Q
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 09:58:16 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3633 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757230AbXEMN6P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 09:58:15 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HnEaL-0002vl-00; Sun, 13 May 2007 14:58:05 +0100
Content-Disposition: inline
In-Reply-To: <20070513130354.GG16903@nan92-1-81-57-214-146.fbx.proxad.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47148>

On 2007-05-13 15:03:54 +0200, Yann Dirson wrote:

> My LC_CTYPE is "french", which is an iso8859-1 locale.

I bit the bullet a year or so ago and switched over to a utf8 locale.
It's becoming increasingly hard to use non-utf8 locales: Gnome wants
utf8, Ubuntu comes with only utf8 locales installed by default, etc. I
figured that it had become less work to convert than to stay with
latin1 (but I still have a few relics, such as the system I'm writing
this mail on).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
