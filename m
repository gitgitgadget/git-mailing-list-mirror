From: Andreas Ericsson <ae@op5.se>
Subject: Re: use repo as git log parameter
Date: Fri, 03 Jul 2009 11:29:15 +0200
Message-ID: <4A4DCF6B.4060101@op5.se>
References: <82ec251f0907030103q3cbf8be1tfb7c46106de878e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lynn Lin <lynnos@tong-ji.org>
X-From: git-owner@vger.kernel.org Fri Jul 03 11:29:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMf5E-00033S-6b
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 11:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855AbZGCJ3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 05:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752375AbZGCJ3R
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 05:29:17 -0400
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:47920 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751171AbZGCJ3Q (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jul 2009 05:29:16 -0400
Received: from source ([209.85.219.208]) by na3sys009aob106.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSk3PbugIFyQsWXN3M8+rjMRTJ/w0yn7e@postini.com; Fri, 03 Jul 2009 02:29:20 PDT
Received: by ewy4 with SMTP id 4so1119259ewy.9
        for <git@vger.kernel.org>; Fri, 03 Jul 2009 02:29:17 -0700 (PDT)
Received: by 10.210.130.13 with SMTP id c13mr699548ebd.13.1246613357441;
        Fri, 03 Jul 2009 02:29:17 -0700 (PDT)
Received: from clix.int.op5.se (90-227-179-205-no128.tbcn.telia.com [90.227.179.205])
        by mx.google.com with ESMTPS id 5sm4465947eyh.0.2009.07.03.02.29.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Jul 2009 02:29:16 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <82ec251f0907030103q3cbf8be1tfb7c46106de878e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122692>

Lynn Lin wrote:
> Hi All,
>       Is there some like this
>                git log http://abc.com/demo.git
>      don't need a local clone tree
> 

No. There are tools like gitweb for browsing history of a repository
you don't want to download. If you really want to examine it minutely,
you should probably just clone it instead. A git repository is
usually very, very small once cloned out.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
