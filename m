From: Nick Andrew <nick@nick-andrew.net>
Subject: Re: Closing the merge window for 1.6.0
Date: Sun, 20 Jul 2008 02:23:25 +0000 (UTC)
Message-ID: <loom.20080720T022105-750@post.gmane.org>
References: <7vod5kd3im.fsf@gitster.siamese.dyndns.org> <7v3amv1e8n.fsf@gitster.siamese.dyndns.org> <7vprpwhp7t.fsf@gitster.siamese.dyndns.org> <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org> <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org> <7vabgqsc37.fsf@gitster.siamese.dyndns.org> <7vtzetjbif.fsf@gitster.siamese.dyndns.org> <7vzlokhpk7.fsf@gitster.siamese.dyndns.org> <20080714085555.GJ32184@machine.or.cz> <alpine.DEB.1.00.0807141256310.8950@racer> <20080714124327.GL10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 04:24:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKObK-0004i5-BA
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 04:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755086AbYGTCXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 22:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755103AbYGTCXk
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 22:23:40 -0400
Received: from main.gmane.org ([80.91.229.2]:34954 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755079AbYGTCXk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 22:23:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KKOaE-00009B-Nx
	for git@vger.kernel.org; Sun, 20 Jul 2008 02:23:35 +0000
Received: from 124-171-245-169.dyn.iinet.net.au ([124.171.245.169])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 02:23:34 +0000
Received: from nick by 124-171-245-169.dyn.iinet.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 02:23:34 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 124.171.245.169 (Mozilla/5.0 (compatible; Konqueror/3.5; Linux) KHTML/3.5.9 (like Gecko) (Debian))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89152>

Petr Baudis <pasky <at> suse.cz> writes:

>   Upgrading to newer version, *especially* if it's over then 1.4 - 1.5
> boundary, is not something you could seriously expect Debian to do.
> At least I actually _hope_ so, as a sysadmin of a network of 40 etch
> workstations.

Perhaps Debian could add a "git1.5" package to the etch repository. That
will guarantee that no current etch users of git 1.4.4.4 will be affected,
and they can choose if they want, to install git1.5.

Nick.
