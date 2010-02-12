From: "Vladimir Panteleev" <thecybershadow@gmail.com>
Subject: Re: Commit annotations (editable commit messages)
Date: Sat, 13 Feb 2010 01:18:26 +0200
Message-ID: <op.u71e00v4m02fvl@cybershadow.mshome.net>
References: <op.u71cw50km02fvl@cybershadow.mshome.net>
 <32541b131002121455s46bfe15aie484e9be484259c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 00:19:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng4mv-0006YZ-9S
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 00:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755676Ab0BLXSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 18:18:55 -0500
Received: from lo.gmane.org ([80.91.229.12]:49099 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754057Ab0BLXSy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 18:18:54 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ng4mf-0006PF-LM
	for git@vger.kernel.org; Sat, 13 Feb 2010 00:18:49 +0100
Received: from 89.28.117.31 ([89.28.117.31])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 00:18:49 +0100
Received: from thecybershadow by 89.28.117.31 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 00:18:49 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 89.28.117.31
User-Agent: Opera Mail/10.50 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139764>

On Sat, 13 Feb 2010 00:55:46 +0200, Avery Pennarun <apenwarr@gmail.com>  
wrote:

> 2010/2/12 Vladimir Panteleev <thecybershadow@gmail.com>:
>> You have to agree, being able to edit commit messages in a controlled
>> (logged/versioned) fashion is pretty useful. Aside mundane corrections  
>> such
>> as typos or undocumented changes, it makes it possible to document bugs  
>> and
>> other unintended changes in the commit that they were introduced. This  
>> is
>> possible in centralized VCSes and is implemented in Subversion  
>> (controlled
>> by a server-side hook).
>
> It sounds like you want to read about a new feature called git-notes:
> http://www.kernel.org/pub/software/scm/git/docs/git-notes.html
>
> Have fun,
>
> Avery

Wow, thanks! Looks like I'm behind the times. (Currently stuck with  
msysGit/1.6.5)

The documentation looks pretty scant. Does anyone know how close were my  
suggestions to the actual implemented behavior (esp. regarding rebasing)?

-- 
Best regards,
  Vladimir                            mailto:thecybershadow@gmail.com
