From: David Kastrup <dak@gnu.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 23 Jan 2008 09:45:30 +0100
Message-ID: <85tzl5udzp.fsf@lola.goethe.zz>
References: <alpine.LFD.1.00.0!801211407130.2957@woody.linux-foundation.org>
	<0CA4DF3F-1B64-4F62-8794-6F82C21BD068@sb.org>
	<alpine.LFD.1.00.0801211538590.2957@woody.linux-foundation.org>
	<F663E088-BCAD-4C5D-89D5-EAF97A29C1DE@sb.org>
	<alpine.LFD.1.00.0801211656130.2957@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801211702050.2957@woody.linux-foundati!on.org>
	<34103945-2078-4983-B409-2D01EF071A8B@sb.org>
	<alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org>
	<E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org>
	<20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu>
	<E6F76F93-24C9-4D10-813C-770A9C3A9828@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@MIT.EDU>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 09:46:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHbFL-0003ps-0U
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 09:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbYAWIpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 03:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbYAWIpg
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 03:45:36 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:37401 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751175AbYAWIpf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2008 03:45:35 -0500
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 78DE324AE78;
	Wed, 23 Jan 2008 09:45:33 +0100 (CET)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id 520BF1B8E57;
	Wed, 23 Jan 2008 09:45:33 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-046-029.pools.arcor-ip.net [84.61.46.29])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 12F731BF3D5;
	Wed, 23 Jan 2008 09:45:33 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 8D9B41C3D4E5; Wed, 23 Jan 2008 09:45:29 +0100 (CET)
In-Reply-To: <E6F76F93-24C9-4D10-813C-770A9C3A9828@sb.org> (Kevin Ballard's
	message of "Tue, 22 Jan 2008 19:38:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92/5528/Wed Jan 23 07:59:37 2008 on mail-in-04.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71523>

Kevin Ballard <kevin@sb.org> writes:

> I just finished talking to one of the HFS+ developers, so I suspect I
> know a lot more on this subject now than you do.

Uh, Ted is a filesystem developer.  I can't count the hours I spent
talking with my father, a theoretical physicist, but that does not make
me qualified to consider myself a better authority on physics than a
sub-average actual grad student of the matter.

If you don't manage to check your arrogance eventually, you'll be
causing more damage to your cause than if you just shut up.  You make
abundantly clear that you don't understand the _implications_ of the
details you may or not may happen to find out.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
