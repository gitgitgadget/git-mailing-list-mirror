From: Mr Tava Ithia <tava.ithia@rbs.co.uk>
Subject: Unable to get GIT GUI to start on Windows XP - Git-1.9.4-preview20140929
Date: Tue, 6 Oct 2015 13:49:29 +0000 (UTC)
Message-ID: <loom.20151006T154739-494@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 06 16:05:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjSri-0007Sj-Ux
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 16:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337AbbJFOFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 10:05:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:59603 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752251AbbJFOFH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 10:05:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZjSrY-0007Mw-Gl
	for git@vger.kernel.org; Tue, 06 Oct 2015 16:05:04 +0200
Received: from 155.136.80.171 ([155.136.80.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Oct 2015 16:05:04 +0200
Received: from tava.ithia by 155.136.80.171 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Oct 2015 16:05:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 155.136.80.171 (Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; .NET4.0C; .NET4.0E))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279148>

Dear Support

Can you please assist me, as I've got this issue starting up GIT GUI on 
Windows XP, Service Pack 3

Whenever I try to start-up GIT GUI, I get the following error 
message "Error in startup script", please see below.

Error in startup script

unable to open key: The system cannot find the file specified.
  while executing
"registry values $key "LocaleName""
  (procedure "mgcat::Init" line 50)
  invoked from within
"msgcat::Init"
 (file "C:/Program Files/The Git Development 
Community/Git/lib/tcl8/8.5/msgcat-1.5.0.tm" line 603)
 invoked from within
"source -encoding utf-8 {C:/Program Files/The Git Development 
Community/Git/lib/tcl8/8.5/msgcat-1.5.0.tm}"
 ("package ifneeded msgcat 1.5.0" script)
 invoked from within
"package require msgcat"
 (file "C:/Program Files/The Git Development Community/Git/libexec/git-
core/git-gui.tcl" line 94)
 invoked from within
"source [file join [file dirname [info script]] git-gui.tcl]"
 (file "C;\Program Files\The Git Development Community\Git\libexec\git-
core\git2 line 25)

Git Release Notes (Git-1.9.4-preview20140929)
Last update: 29 September 2014

I've been searching the web forums for weeks now and speaking to other 
members of my team, but know one has been able to find the solution.

Any assistance you can give me would be very much appreciated.

Kind regards

Tava Ithia 
