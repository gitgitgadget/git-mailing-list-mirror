From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] config: Use parseopt.
Date: Sat, 14 Feb 2009 23:36:26 +0100
Organization: At home
Message-ID: <gn7h17$o6t$1@ger.gmane.org>
References: <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de> <1234612989-32297-1-git-send-email-felipe.contreras@gmail.com> <alpine.DEB.1.00.0902142041370.10279@pacific.mpi-cbg.de> <94a0d4530902141231t143067e5n872558a4e515be4a@mail.gmail.com> <alpine.DEB.1.00.0902142328530.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 23:38:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYT98-0001P9-Bw
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 23:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611AbZBNWge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 17:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753819AbZBNWgd
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 17:36:33 -0500
Received: from main.gmane.org ([80.91.229.2]:39568 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754577AbZBNWgd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 17:36:33 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LYT7h-0002bA-B3
	for git@vger.kernel.org; Sat, 14 Feb 2009 22:36:33 +0000
Received: from abwj21.neoplus.adsl.tpnet.pl ([83.8.233.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 22:36:33 +0000
Received: from jnareb by abwj21.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 22:36:33 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwj21.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109944>

Johannes Schindelin wrote:

>> You mean fail if -e or -l have extra arguments?
> 
> Yes.

'-l' can have extra arguments: '-z'

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
