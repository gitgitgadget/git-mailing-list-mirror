From: "J. Longman" <longman@xiplink.com>
Subject: jgit as a jira plugin
Date: Wed, 29 Oct 2008 19:02:26 -0400
Message-ID: <5915DAE3-7BDF-4296-9DB3-6FBEE504A317@xiplink.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 30 00:06:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvK6N-0004tU-E6
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 00:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755749AbYJ2XCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 19:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755656AbYJ2XCf
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 19:02:35 -0400
Received: from smtp172.iad.emailsrvr.com ([207.97.245.172]:38522 "EHLO
	smtp172.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119AbYJ2XCe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 19:02:34 -0400
Received: from relay7.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay7.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id A79AE1CC934
	for <git@vger.kernel.org>; Wed, 29 Oct 2008 19:02:32 -0400 (EDT)
Received: by relay7.relay.iad.mlsrvr.com (Authenticated sender: jlongman-AT-xiplink.com) with ESMTP id 991171CC8B1
	for <git@vger.kernel.org>; Wed, 29 Oct 2008 19:02:32 -0400 (EDT)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99425>

Hey there,

I've integrated jgit into a plugin for the Jira Issue tracking  
system.  There is more information here: http://confluence.atlassian.com/display/JIRAEXT/Jira+Git+Plugin

I'm new to git, jgit and jira plugin writing, so I have a number of  
questions.  These are the ones I have for you:

1) I noticed that there is a maven pom file.  Are you present in a  
maven repository?  Also any problem with embedding a working snapshot  
in my plugin?
2) I'd like to find out the jgit way to achieve the equivalent of 'svn  
update'.  I understand that fetch can do this but being new to git, I  
don't really understand quite what I need yet.  The goal is to have  
git the latest commits from the origin before indexing.

Thanks for jgit - it took me a day or two to wrap my head around  
getting the list of files changed in a commit but otherwise its great  
to have something that can be integrated into jira.

later, jl

--
J. Longman
longman@xiplink.com

The information transmitted is intended only for the person or entity to
which it is addressed and may contain confidential and/or privileged
material.  If you have received this in error, please contact the sender
and delete this communication and any copy immediately.  Thank you.
