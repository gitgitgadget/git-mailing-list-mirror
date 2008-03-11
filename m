From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Git and pristine-tar
Date: Tue, 11 Mar 2008 18:03:21 +0000 (UTC)
Message-ID: <loom.20080311T180018-539@post.gmane.org>
References: <47D68203.10905@bioinf.uni-sb.de>  <m3y78pxsf5.fsf@localhost.localdomain>  <47D69CE0.3030505@bioinf.uni-sb.de> <8aa486160803110807m277363d6kaf7e1dd401fc9e2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 19:04:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ8pi-0007wo-Dh
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 19:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbYCKSDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 14:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbYCKSDg
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 14:03:36 -0400
Received: from main.gmane.org ([80.91.229.2]:34494 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751597AbYCKSDf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 14:03:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JZ8p1-0005GT-EC
	for git@vger.kernel.org; Tue, 11 Mar 2008 18:03:31 +0000
Received: from 137.204.201.149 ([137.204.201.149])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 18:03:31 +0000
Received: from sergio.callegari by 137.204.201.149 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 18:03:31 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.201.149 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080207 Ubuntu/7.10 (gutsy) Firefox/2.0.0.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76889>

> Maybe you can have a look to pristine-tar. From:
> 
> http://kitenet.net/~joey/code/pristine-tar/
> 

I have just given a look to pristine tar.  If I understand correctly what it
does, I believe it would be very nice to have a pristine zip too. That should
do the job nicely with all opendocument files, making openoffice document
management with git very parsimonious on storage.

Am I correct?
