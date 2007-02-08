From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] qgit: Default the log window to wider than the file list and set monospaced font
Date: Thu, 08 Feb 2007 10:46:59 +0100
Organization: At home
Message-ID: <eqerfk$tr7$1@sea.gmane.org>
References: <200702072138.36787.andyparkins@gmail.com> <e5bfff550702080039l236b1f69o6765b8e2dff3e3c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 08 10:46:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF5qw-0007OH-Rb
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 10:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422893AbXBHJqA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 04:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423137AbXBHJp7
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 04:45:59 -0500
Received: from main.gmane.org ([80.91.229.2]:42094 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422893AbXBHJp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 04:45:59 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HF5qX-0000vg-RW
	for git@vger.kernel.org; Thu, 08 Feb 2007 10:45:41 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 10:45:41 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 10:45:41 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39051>

Marco Costalba wrote:

>> The font for the log viewer is set to "Monospace", but this should
>> really be done in software and given a config setting (perhaps use the
>> patch view font)
>>
> 
> Thanks Andy for patches, I will apply as soon as I have access to my
> box, probably this evening.
> 
> Regarding "Monospace" it should be changeable with Settings menu and
> should apply _only_ to fixed space font viewers, in our case only
> patch viewer and file content viewer.

Shouldn't commit message be also in fixed-width (monospace) font?
Sometimes there is ASCII-art used (mainly for diagrams) in commit
messages; gitweb uses monospace font for commit messages.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
