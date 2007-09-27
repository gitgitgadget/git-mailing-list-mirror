From: Brett Schwarz <brett_schwarz@yahoo.com>
Subject: Re: Relating to some syntax error in the gitk script
Date: Thu, 27 Sep 2007 10:00:27 -0700 (PDT)
Message-ID: <915048.40970.qm@web38908.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Ritwik Ghosh <ritwik.ghosh@sasken.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 27 19:08:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iawpk-0003GD-UN
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 19:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757086AbXI0RHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 13:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757029AbXI0RHM
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 13:07:12 -0400
Received: from web38908.mail.mud.yahoo.com ([209.191.125.114]:47781 "HELO
	web38908.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754189AbXI0RHK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 13:07:10 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Sep 2007 13:07:10 EDT
Received: (qmail 43601 invoked by uid 60001); 27 Sep 2007 17:00:27 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=fS6MlWJYftAb4L91v7+bwtvG+EEDSsZpK0ocgpUiNRLXPtgmI7BtUHk9z1TnYEbck01nMtDmD5wnwkKcHTatOJw5rqHdBJ4p4p/XG79WAHMevwV5eghlatbj4jJsHL6rU2rpQFWVnBRJXhYng2+ab1lEWxRwK1GjDjJvCIDlU8k=;
X-YMail-OSG: _reOL18VM1kV_ZvcwiCR5Dpz8PgUHGSMwL3.JPNgP3xNzVPMc8hGzOfz.aaC25OUDaDKTj4XJgPiKB5InDRhwD7l3tmiLl9OaKjtIw0uQqMwnaZ4th_l1qP.k2qn.g--
Received: from [209.191.119.133] by web38908.mail.mud.yahoo.com via HTTP; Thu, 27 Sep 2007 10:00:27 PDT
X-Mailer: YahooMailRC/651.50 YahooMailWebService/0.7.134
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59305>

> 
> When I am running the gitk command I get the following error message:-
> 
> ========================================================================
> ===========================
> Error in startup script: syntax error in expression "$i >= [llength
> $argv] && $revtreeargs ne {}"
>     while executing
> "if {$i >= [llength $argv] && $revtreeargs ne {}} {
>     # no -- on command line, but some arguments (other than -d)
>     if {[catch {
>         set f [eval exec..."
>     (file "./gitk" line 7912)
> ========================================================================
> ============================
> 
> Is there a problem with the script or is it a problem with my
> environment...?
> 

What version of Tcl are you running? You should be using >= 8.4





       
____________________________________________________________________________________
Yahoo! oneSearch: Finally, mobile search 
that gives answers, not web links. 
http://mobile.yahoo.com/mobileweb/onesearch?refer=1ONXIC
