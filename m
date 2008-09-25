From: Nicolas Pitre <nico@cam.org>
Subject: Re: On Sponsor Notices
Date: Wed, 24 Sep 2008 22:36:41 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809242233360.14631@xanadu.home>
References: <20080924204358.144077183@suse.cz>
 <20080924225120.GL10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, spearce@spearce.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Sep 25 04:38:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KigkD-0004Vt-Rg
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 04:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbYIYChE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 22:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752671AbYIYChE
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 22:37:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:58383 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbYIYChD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 22:37:03 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K7Q00KPVCL6YP40@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 24 Sep 2008 22:36:42 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080924225120.GL10544@machine.or.cz>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96723>

On Thu, 25 Sep 2008, Petr Baudis wrote:

>   Hi,
> 
>   to follow up a little on the "This patch has been sponsored by
> Novartis" messages - I have been on a summer internship at Novartis busy
> deploying Git and these patches (still quite a few more to come, mostly
> for gitweb) have been one of the main outputs of that work.
> 
>   However, I'm not sure if acknowledging the Novartis-originated patches
> in the log message like this is the best practice and we will understand
> if the maintainers will decide to strip these notices when applying the
> patches. Usually, this kind of acknowledgement is made by using
> "sponsored" email addresses, however mine will probably stop working
> shortly after I leave and the only way to read it is, shall we say,
> utmostly inconvenient. ;-) Now, Shawn has proposed 'Sponsored-by:' line
> at the header footer, which is also an interesting possibility.

I'd suggest you do like some people working on the Linux kernel, i.e. 
use your employer's email address for the Signed-off-by line but use 
whatever address you prefer for the from/author line.


Nicolas
