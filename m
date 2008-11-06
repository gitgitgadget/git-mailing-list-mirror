From: Steve Walker <steve@idibu.com>
Subject: Re: Question: 'git pull' hangs on local machine
Date: Thu, 6 Nov 2008 12:34:08 +0100
Message-ID: <2088BFCB-99FF-42EE-91F0-0FD0592D6E19@idibu.com>
References: <C520D4F3-1B6B-4049-911E-F1D82209A7B4@idibu.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 12:35:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky395-0000MN-JE
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 12:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770AbYKFLeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 06:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753710AbYKFLeM
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 06:34:12 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:53761 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbYKFLeL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 06:34:11 -0500
Received: from [192.168.0.198] (static-109-195-228-77.ipcom.comunitel.net [77.228.195.109])
	by mrelayeu.kundenserver.de (node=mrelayeu1) with ESMTP (Nemesis)
	id 0MKwpI-1Ky37p2XZx-0001OR; Thu, 06 Nov 2008 12:34:10 +0100
In-Reply-To: <C520D4F3-1B6B-4049-911E-F1D82209A7B4@idibu.com>
X-Mailer: Apple Mail (2.929.2)
X-Provags-ID: V01U2FsdGVkX18Tk2kr4Bix+4rwh6adbz23mv088WfsUr/BLL/
 LpcB3zyWFQ+KMMHlFaCQCcPWtbjatS3N9/dGD5Nq35OCApGNYz
 Wbc9USALbga/GzCXjNKbEZhV23z77X7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100229>

All,
Please now ignore this - have tried it on a different connection and  
its now worked :)

Kind regards, Steve.

On Nov 5, 2008, at 10:49 PM, Steve Walker wrote:

> Hi there,
>
> We have git on our server - I can pull between repo's no problem on  
> the server. I've also cloned a repo on my local box to dev on. The  
> clone has worked perfectly.
>
> The problem occurs when I try to do a 'git pull' to update my local  
> repo with updates we've made on the server, i see this:
>
> StevePoota:public_html steve$ git pull
> remote: Counting objects: 89, done.
> remote: Compressing objects: 100% (63/63), done.
> Unpacking objects: 35% (24/67)
>
> It hangs on the unpacking objects stage. I tried pulling from  
> different repo, but got the same issue.
>
> I've done some test updates on the server repo's in case they were  
> corrupt but they seem to be ok...
>
> Has anyone got any ideas how to fix this?
>
> Kind regards, Steve
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

www.idibu.co.uk
steve@idibu.com

Sales: +44 (0)800 311 2750
Support: +44 (0)870 626 4268
Fax: +44 (0)8701 417 136

Mobile: +34 661 785 387
www.linkedin.com/in/stevejwalker
