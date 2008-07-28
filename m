From: =?windows-1250?Q?Jurko_Gospodneti=E6?= <jurko.gospodnetic@docte.hr>
Subject: gitk crashing on Windows.
Date: Mon, 28 Jul 2008 16:58:24 +0200
Message-ID: <g6kmqf$q9p$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1250;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 17:01:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNUCg-0002FO-JO
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 17:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935AbYG1O6p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2008 10:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753371AbYG1O6p
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 10:58:45 -0400
Received: from main.gmane.org ([80.91.229.2]:38814 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616AbYG1O6o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 10:58:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KNUBL-0007LG-5d
	for git@vger.kernel.org; Mon, 28 Jul 2008 14:58:39 +0000
Received: from 87.252.133.29 ([87.252.133.29])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 14:58:39 +0000
Received: from jurko.gospodnetic by 87.252.133.29 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 14:58:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87.252.133.29
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90464>

   Hi.

   When you run gitk from a git repository on Windows it starts up and=20
starts updating its 'Row X/Y' output labels. This lasts for a few=20
seconds but if you terminate the application before this updating is=20
complete you get a Windows message stating:

   'Wish Application has encountered a problem and needs to close. We=20
are sorry for the inconvenience.'

   and the standard 'Send Error Report'/'Don't Send' buttons.

   Hope this helps.

   Best regards,
     Jurko Gospodneti=E6
