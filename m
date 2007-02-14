From: Joseph Wakeling <joseph.wakeling@webdrake.net>
Subject: Re: Newbie experience with push over ssh
Date: Wed, 14 Feb 2007 17:47:03 +0000
Message-ID: <45D34B17.70602@webdrake.net>
References: <vpq64a4bzp1.fsf@olympe.imag.fr> <20070214142731.GA1478@moooo.ath.cx> <45D33485.5020906@webdrake.net> <17875.14305.910866.273778@lisa.zopyra.com> <17875.14859.177000.558634@lisa.zopyra.com> <45D33D53.6040209@webdrake.net> <vpqbqjw65kj.fsf@olympe.imag.fr> <45D3412B.9010200@webdrake.net> <Pine.LNX.4.64.0702141237400.1757@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 18:47:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHOEJ-0003fq-8A
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 18:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbXBNRr2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 12:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbXBNRr2
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 12:47:28 -0500
Received: from alf.nbi.dk ([130.225.212.55]:1127 "EHLO alf.nbi.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932135AbXBNRr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 12:47:27 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by alf.nbi.dk (8.9.3/8.9.3) with ESMTP id SAA10816;
	Wed, 14 Feb 2007 18:47:04 +0100 (MET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
In-Reply-To: <Pine.LNX.4.64.0702141237400.1757@xanadu.home>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39704>

Nicolas Pitre wrote:
> What would be the point if you don't have GIT on the remote system?
> 
> Just use rsync or scp to copy your code over and be happy.

For one thing, I might be making small changes or have unversioned files
in my local directory that I don't want to copy.  I only want to push
across the latest code in the branch.
