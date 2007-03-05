From: Xavier Maillard <zedek@gnu.org>
Subject: Re: [PATCH 1/7] .git directory should be ignored
Date: Mon, 5 Mar 2007 09:02:04 +0100
Organization: GNU's Not UNIX!
Message-ID: <200703050802.l25824cQ007817@localhost.localdomain>
References: <15268.1172917083@localhost> <7vzm6u7zle.fsf@assigned-by-dhcp.cox.net>
Reply-To: Xavier Maillard <zedek@gnu.org>
Cc: git@vger.kernel.org, julliard@winehq.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 05 09:05:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO8CG-0000dO-Rb
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 09:05:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbXCEIFZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 03:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbXCEIFZ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 03:05:25 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:49331 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932129AbXCEIFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 03:05:25 -0500
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 1C4547CF6;
	Mon,  5 Mar 2007 09:05:24 +0100 (CET)
Received: from localhost.localdomain (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l25824E1007820;
	Mon, 5 Mar 2007 09:02:04 +0100
Received: (from zedek@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l25824cQ007817;
	Mon, 5 Mar 2007 09:02:04 +0100
X-Authentication-Warning: localhost.localdomain: zedek set sender to zedek@gnu.org using -f
In-reply-to: <7vzm6u7zle.fsf@assigned-by-dhcp.cox.net> (junkio@cox.net)
Jabber-ID: zedek@im.lolica.org
User-Agent: Rmail in GNU Emacs 23.0.51.1 on GNU/Linux
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41410>

   From: Junio C Hamano <junkio@cox.net>

   Xavier Maillard <zedek@gnu.org> writes:

   > Add .git to the list of extensions to be ignored
   The above does mirror what pcl-cvs does for "CVS/" but I notice
   that vc-cvs.el does not do so, neither vc-rcs.el excludes
   "RCS/".

Oops wrong file /o\. Iintended to do this into git.el... Please
ignore. Iwill double-check my future contributions before sending
it here.

Sorry
-- 
Xavier
