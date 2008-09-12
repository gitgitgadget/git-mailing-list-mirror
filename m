From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] add option to import series directly from a tar archive
Date: Fri, 12 Sep 2008 17:44:47 +0200
Message-ID: <20080912154447.GD31240@diana.vm.bytemark.co.uk>
References: <48C34EC7.9040102@gmail.com> <20080908180317.GA6123@diana.vm.bytemark.co.uk> <48C56AD9.6040007@gmail.com> <2008-09-12-14-21-13+trackit+sam@rfc1149.net> <48CA674B.9080900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Samuel Tardieu <sam@rfc1149.net>, git@vger.kernel.org
To: Clark Williams <clark.williams@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 17:24:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeAVX-00084T-DE
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 17:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756935AbYILPWo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Sep 2008 11:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756862AbYILPWo
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 11:22:44 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1462 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408AbYILPWo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 11:22:44 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KeApD-0000IJ-00; Fri, 12 Sep 2008 16:44:47 +0100
Content-Disposition: inline
In-Reply-To: <48CA674B.9080900@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95736>

On 2008-09-12 07:57:47 -0500, Clark Williams wrote:

> then write a test to keep Karl happy,

Technically, you write the test to make sure that your new feature
works as intended and won't break in the future. But since that's
rather a mouthful, I guess "Karl" will do as an acronym. ;-)

> then try to come up with a way to deal with importing patches that
> don't have complete email addresses, no descriptions, etc. Once I
> get through that, I'll see if we can deal with weirdly rooted patch
> series.

Nice.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
