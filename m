From: Auke Kok <auke-jan.h.kok@intel.com>
Subject: Re: stgit: cannot push a patch - Python trace dump
Date: Fri, 15 Sep 2006 07:26:39 -0700
Message-ID: <450AB81F.2090305@intel.com>
References: <450A3524.5040403@intel.com> <tnxwt855wvr.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 15 16:29:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOEgM-0007zg-BR
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 16:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbWIOO2j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 10:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbWIOO2j
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 10:28:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:23073 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751343AbWIOO2j (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Sep 2006 10:28:39 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by mga01.intel.com with ESMTP; 15 Sep 2006 07:28:36 -0700
Received: from fmsmsx331.fm.intel.com (HELO fmsmsx331.amr.corp.intel.com) ([132.233.42.156])
  by fmsmga001.fm.intel.com with ESMTP; 15 Sep 2006 07:28:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,171,1157353200"; 
   d="scan'208"; a="131054539:sNHT26491759"
Received: from ahkok-mobl.jf.intel.com ([134.134.3.190]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 15 Sep 2006 07:28:34 -0700
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by ahkok-mobl.jf.intel.com (Postfix) with ESMTP id 03EE13FF47;
	Fri, 15 Sep 2006 07:26:39 -0700 (PDT)
User-Agent: Mail/News 1.5.0.5 (X11/20060728)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <tnxwt855wvr.fsf@arm.com>
X-OriginalArrivalTime: 15 Sep 2006 14:28:34.0720 (UTC) FILETIME=[39DE3200:01C6D8D3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27088>

Catalin Marinas wrote:
> Auke Kok <auke-jan.h.kok@intel.com> wrote:
>> I'm preparing patches for upstream and am haunted by an apparent
>> patch breaking stg. The problem appears to be one or more of my
>> patches breaking a push:
> [...]
>> I've been abusing stg by leaving the commit messages empty so I
>> assume that that's the cause here, or related to the problem.
> 
> Thanks, I fixed StGIT to cope with this and I'll update the repository
> and snapshot tonight (which, BTW, will contain the initial support for
> patch history tracking).

awesome and awesome, allthough I have no idea what that (patch history 
tracking) is about :)

Auke
