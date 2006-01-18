From: Mathias Waack <Mathias.Waack@rantzau.de>
Subject: Joining Repositories
Date: Wed, 18 Jan 2006 13:25:59 +0100
Organization: IFU
Message-ID: <200601181325.59832.Mathias.Waack@rantzau.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jan 18 13:26:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzCOK-0006Qa-UZ
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 13:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWARM0S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 07:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWARM0S
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 07:26:18 -0500
Received: from mail1.Rantzau.de ([193.100.124.142]:26584 "EHLO
	mail1.Rantzau.de") by vger.kernel.org with ESMTP id S932436AbWARM0S
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 07:26:18 -0500
Received: from [172.28.19.207] (helo=[192.168.48.128])
	by mail1.Rantzau.de with asmtp (TLSv1:RC4-MD5:128)
	(some SMTP-Gateway)
	id 1EzCO7-0003bM-00
	for git@vger.kernel.org; Wed, 18 Jan 2006 13:26:07 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
Content-Disposition: inline
X-Scanner: exiscan *1EzCO7-0003bM-00*sEsRZf5tCzY* (Rantzau ///// Gruppe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14819>

Hello everybody, 

we're using git with cogito as a frontend. For some reasons I forgot we have 
some repositories which belong to the same project. To simplify the whole 
thing I would like to join these repositories. It mainly means to move some 
directories. So lets say I have: 

	/r1/.git
	/r2/.git

and what I would like to have is

	/r/.git
	   r1
           r2

Of course the history should remain (otherwise it would be to easy). 

How should I do this?

Thanks for your answers

	Mathias
