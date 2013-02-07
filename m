From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: Credentials and the Secrets API...
Date: Thu, 07 Feb 2013 09:46:05 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87halochci.fsf@lifelogs.com>
References: <CAEBDL5Udooim_3Za76Q1Rt_aGXtsSv76nxRegGWRBE=WJQzfZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 15:46:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3SkB-0002Ec-Ee
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 15:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755589Ab3BGOqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 09:46:09 -0500
Received: from z.lifelogs.com ([173.255.230.239]:45127 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754000Ab3BGOqH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 09:46:07 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 54EF2DE0E3;
	Thu,  7 Feb 2013 14:46:06 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <CAEBDL5Udooim_3Za76Q1Rt_aGXtsSv76nxRegGWRBE=WJQzfZA@mail.gmail.com>
	(John Szakmeister's message of "Thu, 27 Oct 2011 12:05:03 -0400")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215700>

On Thu, 27 Oct 2011 12:05:03 -0400 John Szakmeister <john@szakmeister.net> wrote: 

JS> Just wanted to keep folks in the loop.  It turns out that the Secrets
JS> API is still to young.  I asked about the format to store credentials
JS> in (as far as attributes), and got a response from a KDE developer
JS> that says it's still to young on their front.  They hope to have
JS> support in the next release of KDE.  But there's still the issue of
JS> what attributes to use.

JS> With that information, I went ahead and created a
JS> gnome-credential-keyring that uses Gnome's Keyring facility.  I still
JS> need to do a few more things (mainly run it against Jeff's tests), but
JS> it's generally working.  Just wanted to keep folks in the loop.
JS> Hopefully, I can get patches out this weekend.

Do you think the Secrets API has matured enough?  KDE has had a new
release since your post...

Thanks
Ted
