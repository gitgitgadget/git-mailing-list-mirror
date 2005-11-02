From: Petr Baudis <pasky@suse.cz>
Subject: Re: cogito: missing *.txt files in Documentation/tutorial-script
Date: Thu, 3 Nov 2005 00:13:16 +0100
Message-ID: <20051102231315.GL16512@pasky.or.cz>
References: <1130972850.23026.11.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 03 00:14:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXRnF-0003TZ-45
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 00:13:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbVKBXNS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 18:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965337AbVKBXNS
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 18:13:18 -0500
Received: from w241.dkm.cz ([62.24.88.241]:7106 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965335AbVKBXNR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 18:13:17 -0500
Received: (qmail 7888 invoked by uid 2001); 3 Nov 2005 00:13:16 +0100
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1130972850.23026.11.camel@dv>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11056>

  Hello,

Dear diary, on Thu, Nov 03, 2005 at 12:07:30AM CET, I got a letter
where Pavel Roskin <proski@gnu.org> told me that...
> Following files are missing in cogito:
> 
> Documentation/tutorial-script/0002-alice-license.txt
> Documentation/tutorial-script/0009-alice-README.txt
> Documentation/tutorial-script/0020-alice-CONTRIBUTORS.txt
> 
> I believe they weren't committed because *.txt is ignored in
> Documentation/.gitignore
> 
> You may want to add Documentation/tutorial-script/.gitignore and put
> following line in it:
> 
> !*.txt

  thanks, good catch. Fixed, done, pushed out.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
