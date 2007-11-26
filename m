From: David Kastrup <dak@gnu.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 20:12:37 +0100
Message-ID: <85prxw253u.fsf@lola.goethe.zz>
References: <200711252248.27904.jnareb@gmail.com> <fiet88$68n$1@ger.gmane.org>
	<2A34D324-48A4-49EF-9D4E-5B9469A0791D@lrde.epita.fr>
	<20071126185600.GA25784@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Nov 26 20:12:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwjNs-0005aR-I6
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 20:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbXKZTM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 14:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753588AbXKZTM2
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 14:12:28 -0500
Received: from mail-in-16.arcor-online.net ([151.189.21.56]:44068 "EHLO
	mail-in-16.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753352AbXKZTM1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Nov 2007 14:12:27 -0500
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-16.arcor-online.net (Postfix) with ESMTP id 52D8B1A452B;
	Mon, 26 Nov 2007 20:12:26 +0100 (CET)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 254F32BEB68;
	Mon, 26 Nov 2007 20:12:26 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-029-090.pools.arcor-ip.net [84.61.29.90])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id E5A642A2AE7;
	Mon, 26 Nov 2007 20:12:25 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 6095D1C4D3AA; Mon, 26 Nov 2007 20:12:37 +0100 (CET)
In-Reply-To: <20071126185600.GA25784@efreet.light.src> (Jan Hudec's message of
	"Mon, 26 Nov 2007 19:56:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4928/Mon Nov 26 19:10:39 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66092>

Jan Hudec <bulb@ucw.cz> writes:

> On Mon, Nov 26, 2007 at 18:10:10 +0100, Benoit Sigoure wrote:
>> On Nov 26, 2007, at 5:46 PM, Andy Parkins wrote:
>> While we're discussing bad names, as someone already pointed out, I agree 
>> it's sad that "git push" is almost always understood as being the opposite 
>> of "git pull".
>
> Well, it is an oposite of pull. Compared to it, it is limited in that it will
> not do a merge and on the other hand extended to *also* be an oposite of
> fetch, but still oposite of pull is push.

With the same reasoning the opposite of a duck is a lobster, since a
lobster has not only fewer wings, but also more legs.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
