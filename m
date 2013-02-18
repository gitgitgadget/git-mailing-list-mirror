From: Ronan Keryell <Ronan.Keryell@silkan.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Mon, 18 Feb 2013 10:02:45 -0800
Message-ID: <87fw0ta4ai.fsf@an-dro.info.enstb.org>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
	<87k3q5zfaa.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	"Jakub Narebski" <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Jens Lehmann" <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 18 19:15:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7VFY-00055a-HG
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 19:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485Ab3BRSPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 13:15:11 -0500
Received: from minou.info.enstb.org ([193.50.97.146]:44023 "EHLO
	minou.info.enstb.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab3BRSPK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 13:15:10 -0500
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Feb 2013 13:15:09 EST
Received: from an-dro.info.enstb.org (localhost [127.0.0.1])
	by minou.info.enstb.org (8.14.4/8.14.4/Debian-2) with ESMTP id r1II2jHH011484;
	Mon, 18 Feb 2013 19:02:47 +0100
In-Reply-To: <87k3q5zfaa.fsf@pctrast.inf.ethz.ch> (Thomas Rast's message of
	"Mon, 18 Feb 2013 18:46:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216489>

>>>>> On Mon, 18 Feb 2013 18:46:05 +0100, Thomas Rast <trast@student.ethz.ch> said:

    Thomas>    The actual programming must be done in C using pthreads
    Thomas> for obvious reasons.

Are there obvious reasons OpenMP would not be enough to do the job?

It looks like a trade-off between the code readability & portability
versus the real expressiveness of what parallelism control details are
needed.
-- 
  Ronan KERYELL                            |\/  Phone:  +1 650 386 6482
  SILKAN Wild Systems                      |/)
  4962 El Camino Real #201                 K    Ronan.Keryell@silkan.com
  Los Altos, CA 94022                      |\   skype:keryell
  USA                                      | \  http://silkan.com
