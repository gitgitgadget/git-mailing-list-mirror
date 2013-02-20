From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: Credentials and the Secrets API...
Date: Wed, 20 Feb 2013 12:01:49 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87k3q2yl4y.fsf@lifelogs.com>
References: <CAEBDL5Udooim_3Za76Q1Rt_aGXtsSv76nxRegGWRBE=WJQzfZA@mail.gmail.com>
	<87halochci.fsf@lifelogs.com>
	<CAEBDL5VQxhnL+wdkf_5=MmG4ptBr4TFyyAvbMWxRom9SRxJ6Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 18:02:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8D3r-0002uZ-Hv
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 18:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933629Ab3BTRCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 12:02:01 -0500
Received: from plane.gmane.org ([80.91.229.3]:53377 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933416Ab3BTRCA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 12:02:00 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1U8D3j-0002q3-0R
	for git@vger.kernel.org; Wed, 20 Feb 2013 18:02:19 +0100
Received: from c-24-60-176-11.hsd1.ma.comcast.net ([24.60.176.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Feb 2013 18:02:19 +0100
Received: from tzz by c-24-60-176-11.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Feb 2013 18:02:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-60-176-11.hsd1.ma.comcast.net
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:n2LxfbtWdjwx2tldVcOGmE3p+Ws=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216709>

On Sat, 9 Feb 2013 05:58:47 -0500 John Szakmeister <john@szakmeister.net> wrote: 

JS> On Thu, Feb 7, 2013 at 9:46 AM, Ted Zlatanov <tzz@lifelogs.com> wrote:
>> On Thu, 27 Oct 2011 12:05:03 -0400 John Szakmeister <john@szakmeister.net> wrote:
>> 
JS> Just wanted to keep folks in the loop.  It turns out that the Secrets
JS> API is still to young.  I asked about the format to store credentials
JS> in (as far as attributes), and got a response from a KDE developer
JS> that says it's still to young on their front.  They hope to have
JS> support in the next release of KDE.  But there's still the issue of
JS> what attributes to use.

>> Do you think the Secrets API has matured enough?  KDE has had a new
>> release since your post...

JS> Yes, I think it has.  Several other applications appear to be using
JS> it, including some things considered "core" in Fedora--which is a good
JS> sign.

Wonderful.  Do you still have interest in working on this credential?

Ted
