From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Signing by StGIT broken
Date: Thu, 10 Jan 2008 08:42:52 +0100
Message-ID: <20080110074252.GA18629@diana.vm.bytemark.co.uk>
References: <1199933596.21499.15.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 10:03:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCtJb-0003XU-9U
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 10:03:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbYAJJCj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jan 2008 04:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752625AbYAJJCi
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 04:02:38 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1767 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbYAJJCg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 04:02:36 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JCs3w-0004rO-00; Thu, 10 Jan 2008 07:42:52 +0000
Content-Disposition: inline
In-Reply-To: <1199933596.21499.15.camel@dv>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70051>

On 2008-01-09 21:53:16 -0500, Pavel Roskin wrote:

> "stg edit --sign" is not working anymore. It was working in version
> 0.14.

Thanks for the report and the detailed analysis. I'll write a test and
fix it (but not quite immediately, so feel free to beat me to it).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
