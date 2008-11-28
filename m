From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit] Import file(s) problem
Date: Fri, 28 Nov 2008 10:25:56 +0100
Message-ID: <20081128092556.GA4380@diana.vm.bytemark.co.uk>
References: <492EC5F5.2050807@ruby.dti.ne.jp> <b0943d9e0811271406u6768f45csdb5ae775436404b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 10:27:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5zdE-00083H-5s
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 10:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbYK1J0G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Nov 2008 04:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbYK1J0G
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 04:26:06 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3294 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbYK1J0F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 04:26:05 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1L5zbo-0001AX-00; Fri, 28 Nov 2008 09:25:56 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0811271406u6768f45csdb5ae775436404b8@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101869>

On 2008-11-27 22:06:01 +0000, Catalin Marinas wrote:

> The '..' construct has special meaning in both Git and StGit meaning
> an interval of commits or patches. We'll need to reject patch names
> with '..' to avoid such errors.

I added a note to the bug database:

  https://gna.org/bugs/index.php?10919

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
