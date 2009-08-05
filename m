From: Andreas Ericsson <ae@op5.se>
Subject: Re: The XZ patch?
Date: Wed, 05 Aug 2009 11:57:36 +0200
Message-ID: <4A795790.9010805@op5.se>
References: <5F7EF736-9D0B-4455-A0F7-E7314B4F29E4@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark A Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Wed Aug 05 11:57:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYdFk-0005p9-Dy
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 11:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934075AbZHEJ5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 05:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933928AbZHEJ5k
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 05:57:40 -0400
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:40898 "HELO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933810AbZHEJ5j (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 05:57:39 -0400
Received: from source ([209.85.219.221]) by na3sys009aob104.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSnlXks6Fh8yoWvuNEMuW9zkJiMJgY3G6@postini.com; Wed, 05 Aug 2009 02:57:40 PDT
Received: by ewy21 with SMTP id 21so4417497ewy.45
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 02:57:38 -0700 (PDT)
Received: by 10.210.138.6 with SMTP id l6mr7786647ebd.84.1249466258165;
        Wed, 05 Aug 2009 02:57:38 -0700 (PDT)
Received: from clix.int.op5.se (90-227-179-205-no128.tbcn.telia.com [90.227.179.205])
        by mx.google.com with ESMTPS id 7sm897684eyb.30.2009.08.05.02.57.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Aug 2009 02:57:37 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <5F7EF736-9D0B-4455-A0F7-E7314B4F29E4@uwaterloo.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124891>

Mark A Rada wrote:
> Hi,
> 
> I was wondering what the fate of my XZ patch was (I didn't do something
>  dumb, did I?). Never got a response after my last submit.
> 

No comments usually meant noone cared enough about the implemented
feature to comment on it. Personally, I'd never use a compression
algorithm that hogs as much memory as XZ does. "Good enough" really
is just that, imo, and bzip2 and gzip are widely available pretty
much everywhere, whereas I've never heard of XZ before.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
