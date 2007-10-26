From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: How to run git-gui always in English?
Date: Fri, 26 Oct 2007 23:41:24 +0200
Message-ID: <20071026214124.GB3062@steel.home>
References: <CCAD0DE0-65D4-4FEC-B02F-658010FECD04@zib.de> <Pine.LNX.4.62.0710260857210.3542@perkele.intern.softwolves.pp.se>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Oct 26 23:41:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlWvz-0002OB-J8
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 23:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283AbXJZVl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 17:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754241AbXJZVl3
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 17:41:29 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:24732 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184AbXJZVl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 17:41:28 -0400
Received: from tigra.home (Fa859.f.strato-dslnet.de [195.4.168.89])
	by post.webmailer.de (klopstock mo14) (RZmta 14.0)
	with ESMTP id d038fcj9QHIGgX ; Fri, 26 Oct 2007 23:41:24 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C20D9277AE;
	Fri, 26 Oct 2007 23:41:24 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 69CDF56D22; Fri, 26 Oct 2007 23:41:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0710260857210.3542@perkele.intern.softwolves.pp.se>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggT2NGA==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62446>

Peter Karlsson, Fri, Oct 26, 2007 10:00:32 +0200:
> Steffen Prohaska:
>
>> There are a lot of efforts going on to localize git-gui, including 
>> technical terms like "push". Personally I don't understand what this 
>> should be useful for. The command is called "git push"s. So, why should it 
>> be named differently in the gui.
>
> Not that I agree that "push" is a technical word, but perhaps you have a 
> point. Why should there be such words in the GUI to start with? It's a GUI, 
> trying to abstract away the command line. Why not have a button "Send" or a 
> menu entry "Send changes to server", mimicing the "git push" command line 
> option? Using command line names or showing protocol data directly in a 
> user-oriented GUI is most often a bad idea.
>
> Or perhaps what we need is an actual translation from "gitish" to English, 
> which would have
>
> msgid "Push"
> msgstr "Send changes to server"
>

Because you do not send changes to a _server_. There is no server.
There is just another repo. Hence just "push"
