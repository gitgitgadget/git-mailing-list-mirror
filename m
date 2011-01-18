From: Andreas Ericsson <ae@op5.se>
Subject: Re: problem with cherry-picking a commit which comes before introducing
 a new submodule
Date: Tue, 18 Jan 2011 17:08:01 +0100
Message-ID: <4D35BAE1.6090204@op5.se>
References: <20110107172432.GA6040@onerussian.com> <20110107181501.GA28980@burratino> <20110107183226.GG6040@onerussian.com> <20110107230017.GA15495@burratino> <20110108000131.GR6040@onerussian.com> <20110111132710.GA14905@burratino> <20110118160222.GA23926@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
To: Yaroslav Halchenko <debian@onerussian.com>
X-From: git-owner@vger.kernel.org Tue Jan 18 17:08:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfE6R-0008NL-H4
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 17:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322Ab1ARQII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 11:08:08 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:46284 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab1ARQIH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 11:08:07 -0500
Received: by ewy5 with SMTP id 5so3352789ewy.19
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 08:08:04 -0800 (PST)
Received: by 10.213.29.16 with SMTP id o16mr5792985ebc.58.1295366884249;
        Tue, 18 Jan 2011 08:08:04 -0800 (PST)
Received: from [192.168.1.186] (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id r5sm543120eeh.15.2011.01.18.08.08.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Jan 2011 08:08:03 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Thunderbird/3.1.7 ThunderGit/0.1a
In-Reply-To: <20110118160222.GA23926@onerussian.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165203>

On 01/18/2011 05:02 PM, Yaroslav Halchenko wrote:
> 
> On Tue, 11 Jan 2011, Jonathan Nieder wrote:
>> ...
>> a submodule might be another reason for a directory in the worktree.
>> In any event, we get a spurious conflict.
>> Thanks, that was interesting (no patch yet, alas).
> 
> is there a way to memorize this issue somewhere (bug tracking/TODO/etc)
> where this issue could be recorded so it doesn't get forgotten? ;)
> 

It will be stored in the hive-mind of the mailing list participants.
It's quite a bit better than it sounds actually.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
