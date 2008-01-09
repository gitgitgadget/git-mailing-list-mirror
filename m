From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [STG PATCH] change usage string of refresh to not refer to removed options
Date: Wed, 9 Jan 2008 08:20:36 +0100
Message-ID: <20080109072036.GA28839@diana.vm.bytemark.co.uk>
References: <200801082143.53125.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Wed Jan 09 09:40:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCWTj-0000dY-Di
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 09:40:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbYAIIjg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jan 2008 03:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbYAIIjg
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 03:39:36 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3022 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbYAIIjf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 03:39:35 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JCVEq-0007WI-00; Wed, 09 Jan 2008 07:20:36 +0000
Content-Disposition: inline
In-Reply-To: <200801082143.53125.kumbayo84@arcor.de>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69967>

Thanks! But ...

On 2008-01-08 21:43:53 +0100, Peter Oberndorfer wrote:

> for changing the patch author, commiter and description

the first line in the commit message (which ends up being the Subject:
line in the mail) should be a short and self-contained summary. No
need to resend just because of that, though -- I can fix it up.

> I saw this while doing the refresh --index patch. There was a
> discussion about bringing back refresh -e If that also brings back
> this options, please do not apply the patch:-)

Resurrecting "refresh -e" is on my todo list. But until then, this is
a good fix.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
