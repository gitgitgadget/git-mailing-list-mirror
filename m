From: Intland <info@intland.com>
Subject: EGit for Mylyn 0.9.3: EGit integrated with the Mylyn task framework
Date: Fri, 17 Dec 2010 11:40:10 +0100
Message-ID: <4D0B3E0A.5030801@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 17 11:50:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTXt7-0001n9-1C
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 11:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370Ab0LQKuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Dec 2010 05:50:05 -0500
Received: from mail00d.mail.t-online.hu ([84.2.42.5]:21791 "EHLO
	mail00d.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab0LQKuE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 05:50:04 -0500
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Dec 2010 05:50:04 EST
Received: from [192.168.1.67] (dsl51B6134D.pool.t-online.hu [81.182.19.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail00d.mail.t-online.hu (Postfix) with ESMTPSA id 5FC5D75877E
	for <git@vger.kernel.org>; Fri, 17 Dec 2010 11:40:11 +0100 (CET)
User-Agent: Thunderbird 2.0.0.24 (X11/20101027)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163871>

Hi all,

EGit for Mylyn is a custom fork of the original EGit project, to integrate EGit (the Git plugin for Eclipse) with Mylyn 
(the task-focused framework).
Intland Software has created this fork to *enable associating Git changes with Mylyn tasks, and tracking these 
associations*. However, it was primarily developed to satisfy Intland's own needs, the binaries and the source code is 
freely available for downloading and cloning.

Highlights in this fork:
* "Open Corresponding Task" feature
* Commit messages are initialized with the IDs of the active Mylyn tasks
* EGit tightly integrated with the codeBeamer issue trackers

More details, download info, etc.: http://blogs.intland.com/main/entry/20101216
