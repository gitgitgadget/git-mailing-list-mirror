From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFD] Proposal for git-svn: storing SVN metadata (git-svn-id)
 in notes
Date: Tue, 31 May 2011 10:25:59 +0200
Message-ID: <4DE4A617.9020907@alum.mit.edu>
References: <201105281154.25223.jnareb@gmail.com> <20110531045324.GA13661@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 31 10:26:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRKHF-0002p3-3y
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 10:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758272Ab1EaI0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 04:26:05 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:58624 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758100Ab1EaI0D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 04:26:03 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p4V8PxHk024976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 31 May 2011 10:25:59 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <20110531045324.GA13661@dcvr.yhbt.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174797>

On 05/31/2011 06:53 AM, Eric Wong wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>> Eric, from what I remember you don't have time nor inclination for 
>> adding new features to git-svn, is it?
> 
> Yes, that's mostly the case.  I suggest anybody interested in working on
> git-svn further to split out the Perl modules into separate files before
> doing any more work on it.

What kind of design documentation is available for git-svn?  Is there
any documentation about the format and contents of the files that
git-svn uses?

Such documentation would make it a lot easier for new developers to get
involved.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
