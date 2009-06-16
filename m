From: Andreas Ericsson <ae@op5.se>
Subject: libgit2 review help needed
Date: Tue, 16 Jun 2009 11:08:01 +0200
Message-ID: <4A3760F1.8060905@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 16 11:08:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGUeV-0006Fq-QT
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 11:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbZFPJIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 05:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbZFPJID
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 05:08:03 -0400
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:42096 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751450AbZFPJIB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jun 2009 05:08:01 -0400
Received: from source ([209.85.220.225]) by na3sys009aob101.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSjdg88RhJ177ARGzpU7uIcKUPEedgya6@postini.com; Tue, 16 Jun 2009 02:08:04 PDT
Received: by fxm25 with SMTP id 25so1631331fxm.36
        for <git@vger.kernel.org>; Tue, 16 Jun 2009 02:08:02 -0700 (PDT)
Received: by 10.86.81.15 with SMTP id e15mr7472189fgb.35.1245143282476;
        Tue, 16 Jun 2009 02:08:02 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 12sm12262907fgg.20.2009.06.16.02.08.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Jun 2009 02:08:02 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121667>

As some of you know, I've stepped up as co-maintainer of libgit2 along
with Shawn, who has precious little time to handle the patches that
come along. Happily, this seems to have spurred some interest in the
community and patches have started arriving for various parts of the
system. However, I'm not the expert on any parts of the git core, and
my knowledge of buildtools other than gcc et al is scarce, so I need
help reviewing the patches that come in.

Unless I hear cries against it, I'll ask patch submitters to send their
patches to git@vger from now on, with "[libgit2 PATCH x/n]" prefix for
their patches so those who are not interested in libification can easily
filter out such threads. Any help reviewing patches would be much
appreciated.

To the libgit2 contributors:
Please start sending patches to git@vger.kernel.org, with me (ae@op5.se)
on Cc if no cries of outrage follow this email.

Thanks all.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
