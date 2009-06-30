From: dtletmn <dtletmedn@gmail.com>
Subject: Does CVS has a easy way to compare file with its previous version?
Date: Tue, 30 Jun 2009 00:41:08 -0700 (PDT)
Message-ID: <1e56aa11-735a-47f7-a273-5b6bf611f528@n11g2000yqb.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 30 12:59:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLb40-0000rb-0c
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 12:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbZF3K7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 06:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752059AbZF3K7g
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 06:59:36 -0400
Received: from mail-gx0-f200.google.com ([209.85.217.200]:51901 "EHLO
	mail-gx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbZF3K7g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 06:59:36 -0400
X-Greylist: delayed 11439 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jun 2009 06:59:35 EDT
Received: by gxk24 with SMTP id 24so48793gxk.13
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 03:59:39 -0700 (PDT)
Received: by 10.100.132.4 with SMTP id f4mr873242and.13.1246347668874; Tue, 30 
	Jun 2009 00:41:08 -0700 (PDT)
X-IP: 192.203.57.28
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.0.11) 
	Gecko/2009060215 Firefox/3.0.11 GTB5,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122506>

Hi,All,

     I am wondering if cvs has an easy way to compare a file with its
previous version.

     In clearcase,I can use  :
       cleartool diff -pred file.cc

     how can I acheive it in CVS?
     any help would be highly appreciated!

     Thanks,
     dt
