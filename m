From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: What am I doing wrong?
Date: Fri, 16 May 2008 14:43:59 +0200
Message-ID: <g0jvig$1dn$1@ger.gmane.org>
References: <482D6F41.2060809@laser-point.co.uk> <g0js1p$l22$1@ger.gmane.org> <482D7EE1.9020503@laser-point.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 14:45:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwzJ2-000484-3Z
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 14:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403AbYEPMoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 08:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131AbYEPMoM
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 08:44:12 -0400
Received: from main.gmane.org ([80.91.229.2]:53815 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbYEPMoL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 08:44:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JwzIA-0000Oc-BS
	for git@vger.kernel.org; Fri, 16 May 2008 12:44:10 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 May 2008 12:44:10 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 May 2008 12:44:10 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <482D7EE1.9020503@laser-point.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82282>

Paul Gardiner venit, vidit, dixit 16.05.2008 14:32:
> Michael J Gruber wrote:
>> Paul Gardiner venit, vidit, dixit 16.05.2008 13:25:
>>> I create the initial repository with
>>>
>>>      git-clone /<full-path>/<name>.git/ <folder>
>>>
>>> That works fine, but then I can't fetch. git-fetch gives the error
>>> "fatal: 'origin': unable to chdir or not a git archive"
>>> "fatal: The remote end hung up unexpectedly"
>>>
>>> P.
>> Are you trying to clone a bare repository?
>> Or is your repo maybe at /<full-path>/<name> with a .git subdir?
> 
> Yes, a bare repository.

Then, maybe the full list of command lines (including cd and git-fetch) 
would be helpful in order to track this down.

Michael
