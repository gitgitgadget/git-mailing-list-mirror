From: Andreas Ericsson <ae@op5.se>
Subject: Re: Patch (1.6.2.1) for fixing bad single quote
Date: Tue, 14 Apr 2009 14:35:20 +0200
Message-ID: <49E48308.6090202@op5.se>
References: <49E49E50.26678.1760A84@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Tue Apr 14 14:37:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lthsn-0006IN-84
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 14:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197AbZDNMfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 08:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755013AbZDNMfX
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 08:35:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:3900 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754344AbZDNMfX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 08:35:23 -0400
Received: by fg-out-1718.google.com with SMTP id 16so475870fgg.17
        for <git@vger.kernel.org>; Tue, 14 Apr 2009 05:35:21 -0700 (PDT)
Received: by 10.86.94.11 with SMTP id r11mr5604113fgb.11.1239712521281;
        Tue, 14 Apr 2009 05:35:21 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id l19sm8767858fgb.16.2009.04.14.05.35.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Apr 2009 05:35:21 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <49E49E50.26678.1760A84@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116533>

Ulrich Windl wrote:
> Hi,
> 
> this is my very first attempt to use Git to make a Git patch; a microscopic 
> contribution. I hope the attached Patch is OK. basically it's this:
> 

It looks alright, but there's a document called SubmittingPatches in the
Documentation folder of git.git itself which you should read before you
intend to submit patches, as it makes life easier for our benevolent but
overworked democratic dictator Junio.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
