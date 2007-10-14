From: David Kastrup <dak@gnu.org>
Subject: Re: git blame crashes with internal error
Date: Sun, 14 Oct 2007 16:56:31 +0200
Message-ID: <85hcktn3s0.fsf@lola.goethe.zz>
References: <20071014143628.GA22568@atjola.homenet> <47122D02.9060204@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Oct 14 16:56:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih4t0-00059C-8f
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 16:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346AbXJNO4B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2007 10:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755242AbXJNO4A
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 10:56:00 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:51574 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbXJNO4A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2007 10:56:00 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1Ih4so-0003fw-Ui; Sun, 14 Oct 2007 10:55:59 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 750F21C4CE11; Sun, 14 Oct 2007 16:56:31 +0200 (CEST)
In-Reply-To: <47122D02.9060204@op5.se> (Andreas Ericsson's message of "Sun\, 14 Oct 2007 16\:51\:46 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60853>

Andreas Ericsson <ae@op5.se> writes:

> Bj=F6rn Steinbrink wrote:
>>
>> I tried all git releases from 1.5.3 to 1.5.3.4 as well as the curren=
t
>> master and all of them crashed. A small shell script to reproduce th=
e
>> problem is attached.
>>
>
> Manual bisect? Ugh. This *is* the century of the competent developer
> tools, you know... ;-)

It's not a "bisect" when it crashes in all versions.

--=20
David Kastrup, Kriemhildstr. 15, 44793 Bochum
