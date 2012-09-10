From: Rob Marshall <Rob.Marshall17@gmail.com>
Subject: Re: Problems with repack during push
Date: Mon, 10 Sep 2012 12:54:44 -0400
Message-ID: <504E1B54.70603@gmail.com>
References: <504E1256.4020605@gmail.com> <vpqfw6pj13t.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 10 19:02:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB7N2-0000p5-4W
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 19:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143Ab2IJRBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 13:01:52 -0400
Received: from qmta13.westchester.pa.mail.comcast.net ([76.96.59.243]:44086
	"EHLO qmta13.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750935Ab2IJRBv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Sep 2012 13:01:51 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Sep 2012 13:01:51 EDT
Received: from omta03.westchester.pa.mail.comcast.net ([76.96.62.27])
	by qmta13.westchester.pa.mail.comcast.net with comcast
	id xQrL1j0050bG4ec5DUupYf; Mon, 10 Sep 2012 16:54:49 +0000
Received: from Rob-Marshalls-iMac.local ([76.23.194.37])
	by omta03.westchester.pa.mail.comcast.net with comcast
	id xUue1j00Z0oslp03PUue1C; Mon, 10 Sep 2012 16:54:38 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:15.0) Gecko/20120824 Thunderbird/15.0
In-Reply-To: <vpqfw6pj13t.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205148>

OK, thanks. I'll check with the guy who set up the server.

Rob

On 9/10/12 12:26 PM, Matthieu Moy wrote:
> Rob Marshall <Rob.Marshall17@gmail.com> writes:
>
>> If I do a 'git repack' it works fine, so are these
>> messages coming from the remote server?
>
> I guess so, and your remote server has a restricted environment (chroot
> or so) with very few commands allowed, which prevents shell-scripts from
> executing properly.
>
