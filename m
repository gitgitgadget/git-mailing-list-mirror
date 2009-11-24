From: Mark Blakeney <markb@berlios.de>
Subject: Re: gitk does not show path file list
Date: Tue, 24 Nov 2009 05:36:37 +0000 (UTC)
Message-ID: <loom.20091124T060334-836@post.gmane.org>
References: <33e2b2760911170409q4cbdad8ay83ae5c941bc5ff95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 24 06:37:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCo5Z-0000re-BH
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 06:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538AbZKXFhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 00:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753485AbZKXFhB
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 00:37:01 -0500
Received: from lo.gmane.org ([80.91.229.12]:38832 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619AbZKXFhA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 00:37:00 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NCo5J-0000m2-Cb
	for git@vger.kernel.org; Tue, 24 Nov 2009 06:37:05 +0100
Received: from 124-171-204-125.dyn.iinet.net.au ([124.171.204.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Nov 2009 06:37:00 +0100
Received: from markb by 124-171-204-125.dyn.iinet.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Nov 2009 06:37:00 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 124.171.204.125 (Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/532.5 (KHTML, like Gecko) Chrome/4.0.249.4 Safari/532.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133560>

This seems to me to be a straight out bug but given I've had no response here
and  given this is such a simple issue then I guess it's not a bug and I'm just
missing something? Please somebody, why does gitk (usually) not show the subset
list of files affected when you give it a path?

E.g. If I am in a src dir then "gitk ." does not list files. Neither does "gitk
$PWD" nor "gitk ../src". However "cd ..; git src" does list files!?

Is there a more appropriate forum/list for git newcomers?
