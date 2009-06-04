From: stuart <stuart@xnet.com>
Subject: Can I set up a GIT server w/o administration privileges on a Solaris
 machine?
Date: Thu, 04 Jun 2009 11:35:50 -0500
Message-ID: <4A27F7E6.8060405@xnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 04 18:41:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCG0d-0001M4-K2
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 18:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756308AbZFDQkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 12:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755840AbZFDQka
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 12:40:30 -0400
Received: from nlpi157.sbcis.sbc.com ([207.115.36.171]:34006 "EHLO
	nlpi157.prodigy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166AbZFDQka (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 12:40:30 -0400
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jun 2009 12:40:29 EDT
Received: from [192.168.0.201] (adsl-99-142-0-215.dsl.emhril.sbcglobal.net [99.142.0.215])
	(authenticated bits=0)
	by nlpi157.prodigy.net (8.13.8 smtpauth/dk/map_regex/8.13.8) with ESMTP id n54GY2eE014253
	for <git@vger.kernel.org>; Thu, 4 Jun 2009 11:34:03 -0500
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120701>

Hi...

Can I set up a GIT server w/o administration privileges on a Solaris 
machine?

I think this should be a simple question to answer.  I have looked in 
the archives - but most, if not all, who post are setting up GIT servers 
  using administration privileges.  I have a shell account on a Solaris 
box where I can create web pages and trigger the execution of scripts 
from those pages...but no administration right.  So, I started down the 
path of privately installing software.  However, it became apparent that 
I need git listing on this port and running that daemon...both of which 
are almost impossible with out administration rights.

So, is there a way to get some basic GIT functionality through serving 
up web pages and executing CGI scripts.  Is there somewhere I can read 
up on this type of server installation?

-thank you
