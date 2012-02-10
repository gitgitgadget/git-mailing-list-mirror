From: Serhat Sevki Dincer <jfcgauss@gmail.com>
Subject: git svn problem
Date: Fri, 10 Feb 2012 20:15:55 +0200
Message-ID: <CAPqC6xRtZXwv+U6AKRUXDz=m-G4AjgWksbwqeMD_qzS8YC=DoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 19:16:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvv0r-0006C5-Je
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 19:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759562Ab2BJSP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 13:15:56 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62752 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947Ab2BJSPz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 13:15:55 -0500
Received: by qcqw6 with SMTP id w6so1798240qcq.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 10:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=BrFN3UH6vQnSQcYNy+wZbRhaTBTeh2VKIqyOaKCJ81U=;
        b=gKgFPBCP+4WCSnX1Y5V0P23yijYXQLG7kM+4GClyEBYDynyQfwSxeWGsnKSLFULm+8
         jS6uZGg3oogXbTvpCQOWNUXf+L+nnvNHHz/p2rTpJPLp65dcsTL5XXz9NYYOt+sP7OU7
         9a/dFYpi8jIknRzsNzA78AHFKv2C/sbFyapY0=
Received: by 10.229.77.69 with SMTP id f5mr4895754qck.12.1328897755100; Fri,
 10 Feb 2012 10:15:55 -0800 (PST)
Received: by 10.229.144.196 with HTTP; Fri, 10 Feb 2012 10:15:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190430>

Hi,

I am using git-svn (1.7.4.1-3 on ubuntu) to get a project. It has two
svn repositories, apparently disjoint. First half is at
http://svn.plone.org/svn/plone/plone.app.locales, and the continuation
at http://svn.plone.org/svn/collective/plone.app.locales
How can i get a nice linear git-svn repository? the second one is the
new location of the project. I am only interested in the trunks btw.

Thanks..
