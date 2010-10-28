From: Michael Quaas <michaelquaas@web.de>
Subject: How to publish a local initilized repository?
Date: Thu, 28 Oct 2010 13:25:48 +0200
Message-ID: <4CC95DBC.6080805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 28 13:29:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBQff-0002fI-Ma
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 13:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758321Ab0J1L3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 07:29:23 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:41614 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753068Ab0J1L3W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 07:29:22 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 1495516A8DC69
	for <git@vger.kernel.org>; Thu, 28 Oct 2010 13:25:50 +0200 (CEST)
Received: from [77.179.189.134] (helo=[192.168.181.30])
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #24)
	id 1PBQcA-0002xD-00
	for git@vger.kernel.org; Thu, 28 Oct 2010 13:25:50 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.11) Gecko/20101006 Thunderbird/3.1.5
X-Sender: michaelquaas@web.de
X-Provags-ID: V01U2FsdGVkX1/C/wcF3cAnqKlL3/2wGw+zfhSfjh9mNWMH45DP
	KIOFYqSEh2Zl4PlZ9XRDCbKlgEb3jC3aas9M6Pjr1DMEZmCVHG
	fjKiIEJt5wCh8F6gJpiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160171>

Hello,

I have local repository initialized with git-init. Now I want to share 
this with others through a repository server. How is the best way to do 
this? Proberly I can't just push it on the server, can I? Do I have to 
copy the whole project on the server and then clone it locally? Is it 
then possible to push and pull from it?

Yours
Michael
