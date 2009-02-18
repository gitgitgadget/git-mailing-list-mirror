From: "Arya, Manish Kumar" <m.arya@yahoo.com>
Subject: post-receive email
Date: Wed, 18 Feb 2009 04:44:55 -0800 (PST)
Message-ID: <556409.61398.qm@web35708.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 13:46:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZloo-0002wM-GO
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 13:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbZBRMo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 07:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbZBRMo5
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 07:44:57 -0500
Received: from web35708.mail.mud.yahoo.com ([66.163.179.162]:43126 "HELO
	web35708.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751728AbZBRMo4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Feb 2009 07:44:56 -0500
Received: (qmail 61776 invoked by uid 60001); 18 Feb 2009 12:44:55 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=2z8nrtl51tuNTFY5gy3UVyhuKeXHHDwCWUMABzrRFUoSIQqiD5pURYxsPS2I2kz9GBPNEMJLuhR+3U4kJ5FTazZ2urOA2WrXDygcrDrgrrpJ4N4Pen9YoWQBgTpGyX0wvIUXmS9Gt399n+XEi4gcKS90WaKoUqWjKzSWpbiajO8=;
X-YMail-OSG: FTpAzksVM1lQeoWSYhLm6xNj7M_aNGP_64TpSejD7L9BDr09JH5pN0aVew6GGydpKRxMwPKARJp6DHyG.wsEjnN7Hjg5IiU_wuwxcHZTKw0jUwt5SDJfepdeusYRbwIJwx3d.VDX0YAfDHJkmClhvL9l_mZK5cAm.HcwkdvcN0GyuDm_X5Qg2XJqHjP1v9CXt5WFhv0T_V8d9b1gyYsn
Received: from [221.134.157.65] by web35708.mail.mud.yahoo.com via HTTP; Wed, 18 Feb 2009 04:44:55 PST
X-Mailer: YahooMailWebService/0.7.260.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110530>

Hi,

  I am using git 1.6.1

I have configured post-receive hook for sending emails on remote push activity.

But I am getting this error while push. any one using this script for email. can you suggest some other working script for this ?

----------------------------------
Counting objects: 5, done.
Compressing objects: 100% (3/3)   Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3)   Writing objects: 100% (3/3), 344 bytes, done.
Total 3 (delta 1), reused 0 (delta 0)
hooks/post-receive: syntax error at line 73: `oldrev=$' unexpected
error: hooks/post-receive exited with error code 2
Pushing to ssh://xxx.xxx.xxx.net/opt/repos/mka.git
To ssh://xxx.xxx.xxx.net/opt/repos/mka.git
   db4b382..186b0af  master -> master
-----------------------------------


      
