From: Nikolaus Demmel <nikolaus@nikolaus-demmel.de>
Subject: Re: [PATCH] git-svn: enable platform-specific authentication
Date: Sat, 18 Feb 2012 20:06:11 -0800 (PST)
Message-ID: <1329624371869-7298038.post@n2.nabble.com>
References: <1305708320-8614-1-git-send-email-grddev@gmail.com> <20110518195710.GA10697@dcvr.yhbt.net> <20110809210638.GK6418@login.drsnuggles.stderr.nl> <20120103204403.GI17548@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 05:06:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ryy2S-0002GG-Qd
	for gcvg-git-2@plane.gmane.org; Sun, 19 Feb 2012 05:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445Ab2BSEGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Feb 2012 23:06:12 -0500
Received: from sam.nabble.com ([216.139.236.26]:43250 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150Ab2BSEGM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2012 23:06:12 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <nikolaus@nikolaus-demmel.de>)
	id 1Ryy2N-00047B-SN
	for git@vger.kernel.org; Sat, 18 Feb 2012 20:06:11 -0800
In-Reply-To: <20120103204403.GI17548@login.drsnuggles.stderr.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191016>


Matthijs Kooijman wrote
> 
> I sent the below patch a few months ago, and not having it applied in
> git-svn bit me again just now. Did any of you get a chance to have a
> look at it?
> 
> I'm still not 100% sure if this patch is correct for all the corner
> cases, but it works like a charm in the regular case.
> 
> Perhaps it should just be included as is?
> 

Hi,

is this patch also meant to deal with / fix the handling the keychain as an
authentication handler on OS X?

Is there anything I could do to help getting this moving forward? I could
try test it on OS X, if noone else can.

Cheers,
Nikolaus


--
View this message in context: http://git.661346.n2.nabble.com/PATCH-git-svn-enable-platform-specific-authentication-tp6376961p7298038.html
Sent from the git mailing list archive at Nabble.com.
