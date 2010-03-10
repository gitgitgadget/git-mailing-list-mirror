From: Kurt Harriger <kurtharriger@gmail.com>
Subject: error cloning svn repository
Date: Wed, 10 Mar 2010 10:45:48 -0700
Message-ID: <4B97DACC.2020107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 10 18:51:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpQ4A-0006zo-J9
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 18:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573Ab0CJRvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 12:51:25 -0500
Received: from relay.ihostexchange.net ([66.46.182.52]:39957 "EHLO
	relay.ihostexchange.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932548Ab0CJRvY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 12:51:24 -0500
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Mar 2010 12:51:24 EST
Received: from HUB103.ihostexchange.net (66.46.182.53) by
 HUB102.ihostexchange.net (66.46.182.52) with Microsoft SMTP Server (TLS) id
 8.1.393.1; Wed, 10 Mar 2010 12:46:05 -0500
Received: from [10.1.2.193] (208.42.231.116) by smtp.ihostexchange.net
 (66.46.182.50) with Microsoft SMTP Server (TLS) id 8.1.393.1; Wed, 10 Mar
 2010 12:45:56 -0500
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141909>

I'm getting the following error attempting to clone an svn repository.

$ git svn clone -s https://npanday.svn.codeplex.com/svn/ npanday

Initialized empty Git repository in /home/kurtharriger/npanday/.git/

fatal: Not a valid object name ls-tree -r --name-only -z : command 
returned error: 128
